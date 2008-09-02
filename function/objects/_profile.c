#include <assert.h>

static void *(*enter)(struct __methodinfo *info);
static void  (*leave)(void *cookie);

struct edge
{
  long			 totalTime;
  long			 numCalls;
  struct profile	*callee;
  struct profile	*caller;
  struct edge		*nextCallee;
  struct edge		*nextCaller;
  int			 active;
};

struct edgeList
{
  struct edge		*first;
  int			 size;
};

#define listDo(VAR, LIST, NEXT)				\
  for (VAR= (LIST)->first;  VAR;  VAR= VAR->NEXT)

struct profile
{
  long			 totalTime;
  long			 numCalls;
  long			 numSamples;
  struct __methodinfo	*method;
  struct edgeList	 callers;
  struct edgeList	 callees;
  struct profile	*next;
  int			 active;
};

struct profileList
{
  struct profile	*first;
  int			 size;
};

static struct profileList profiles = { 0, 0 };

struct entry
{
  long			 time;
  struct profile	*profile;
  struct edge		*edge;
};

static struct entry *entries= 0;
static int numEntries= 0;

static long  profilePeriod= 1000;
static float msRatio= 1.0;

static long currentTime= 0;
static long sampleTime= 0;

static long numProfiles= 0;
static long numEdges= 0;

static void sigalrm(int signo)	{ ++currentTime; }

static void profileAddCallee(struct profile *profile, struct edge *edge)
{
  edge->nextCallee= profile->callees.first;
  profile->callees.first= edge;
  profile->callees.size++;
}

static void profileAddCaller(struct profile *profile, struct edge *edge)
{
  edge->nextCaller= profile->callers.first;
  profile->callers.first= edge;
  profile->callers.size++;
}

static void profileListAdd(struct profileList *list, struct profile *profile)
{
  profile->next= list->first;
  list->first= profile;
  list->size++;
}

static void *profileEnter(struct __methodinfo *method)
{
  void	*cookie=   enter(method);
  int	 position= (long)cookie;
  struct __methodinfo *caller= _libid->methodAt(1);
  struct profile *callerProfile= caller ? caller->meta : 0;
  struct profile *calleeProfile;
  struct edge *edge= 0;

  if (sampleTime != currentTime)
    {
      assert(currentTime > sampleTime);
      if (callerProfile)
	callerProfile->numSamples += currentTime - sampleTime;
      sampleTime= currentTime;
    }

  if (!(calleeProfile= method->meta))
    {
      calleeProfile= calloc(1, sizeof(struct profile));
      calleeProfile->method= method;
      method->meta= calleeProfile;
      profileListAdd(&profiles, calleeProfile);
      ++numProfiles;
    }
  calleeProfile->numCalls++;

  if (callerProfile)
    {
      listDo(edge, &callerProfile->callees, nextCallee)
	if (calleeProfile == edge->callee)
	  break;
      if (!edge)
	{
	  edge= calloc(1, sizeof(struct edge));
	  edge->caller= callerProfile;
	  edge->callee= calleeProfile;
	  profileAddCallee(callerProfile, edge);
	  profileAddCaller(calleeProfile, edge);
	  ++numEdges;
	}
      edge->numCalls++;
    }

  if (position >= numEntries)
    {
      entries= numEntries
	? realloc(entries, sizeof(struct entry) * (numEntries *=   2))
	: malloc(          sizeof(struct entry) * (numEntries  = 128));
    }

  calleeProfile->active++;
  if (edge) edge->active++;

  entries[position].time= currentTime;
  entries[position].profile= calleeProfile;
  entries[position].edge= edge;

  return cookie;
}

static void  profileLeave(void *cookie)
{
  int position= (long)cookie;

  if (currentTime != sampleTime)
    {
      assert(currentTime > sampleTime);
      if (entries[position].profile)
	entries[position].profile->numSamples += currentTime - sampleTime;
      sampleTime= currentTime;
    }

  if (currentTime != entries[position].time)
    {
      assert(currentTime > entries[position].time);
      if (entries[position].profile && (1 == entries[position].profile->active))
	entries[position].profile->totalTime += currentTime - entries[position].time;
      if (entries[position].edge && (1 == entries[position].edge->active))
	entries[position].edge->totalTime += currentTime - entries[position].time;
    }

  if (entries[position].profile) entries[position].profile->active--;
  if (entries[position].edge   ) entries[position].edge   ->active--;

  leave(cookie);
}

static void setExecutionProfilePeriod(long uSecs)
{
  profilePeriod= uSecs;
  msRatio= (float)profilePeriod / 1000.0;
  (void)setExecutionProfilePeriod;
}

static void enableExecutionProfile(void)
{
  struct itimerval interval= { { 0, profilePeriod }, { 0, profilePeriod } };
  struct __methodinfo *method= _libid->methodAt(0);
  if (!method->meta)
    {
      struct profile *profile= calloc(1, sizeof(struct profile));
      profile->method= method;
      method->meta= profile;
      profileListAdd(&profiles, profile);
      ++numProfiles;
    }
#if defined(WIN32)
  (void)sigalrm;
#else
  signal(SIGALRM, sigalrm);
  setitimer(ITIMER_REAL, &interval, 0);
#endif
  if (enter != profileEnter)
    {
      enter= _libid->enter;  _libid->enter= profileEnter;
      leave= _libid->leave;  _libid->leave= profileLeave;
    }
  (void)enableExecutionProfile;
}

static void disableExecutionProfile(void)
{
#if defined(WIN32)
  (void)sigalrm;
#else
  signal(SIGALRM, SIG_IGN);
  setitimer(ITIMER_REAL, 0, 0);
#endif
  if (enter == profileEnter)
    {
      _libid->enter= enter;  enter= 0;
      _libid->leave= leave;  leave= 0;
    }
  (void)disableExecutionProfile;
}

static int decreasingProfileTimes  (const void *a, const void *b)
{
  long ta= (*(struct profile **)a)->totalTime;
  long tb= (*(struct profile **)a)->totalTime;
  return ta == tb	/* try to choose the root of the graph when there is a tie for largest total time */
    ? ((*(struct profile **)a)->callers.size - (*(struct profile **)a)->callers.size)
    : (tb - ta);
}

static int decreasingProfileSamples(const void *a, const void *b)	{ return (*(struct profile **)b)->numSamples - (*(struct profile **)a)->numSamples; }

static struct profile **sortedProfiles(int (*compare)(const void *, const void *))
{
  struct profile  *profile;
  struct profile **sorted;
  int n= 0;
  sorted= malloc(sizeof(struct profile *) * profiles.size);
  for (profile= profiles.first;  profile;  profile= profile->next)
    sorted[n++]= profile;
  qsort(sorted, profiles.size, sizeof(struct profile *), compare);
  return sorted;
  (void)decreasingProfileTimes;
  (void)decreasingProfileSamples;
}

static int increasingEdgeTimes(const void *a, const void *b)	{ return (*(struct edge **)a)->totalTime - (*(struct edge **)b)->totalTime; }
static int decreasingEdgeTimes(const void *a, const void *b)	{ return (*(struct edge **)b)->totalTime - (*(struct edge **)a)->totalTime; }

static struct edge *nextCaller(struct edge *edge)	{ return edge->nextCaller; }
static struct edge *nextCallee(struct edge *edge)	{ return edge->nextCallee; }

static struct edge **sortedEdges(struct edgeList *edges, int (*compare)(const void *, const void *), struct edge *((*next)(struct edge *)))
{
  struct edge  *edge;
  struct edge **sorted;
  int n= 0;
  sorted= malloc(sizeof(struct edge *) * edges->size);
  for (edge= edges->first;  edge;  edge= next(edge))
    sorted[n++]= edge;
  qsort(sorted, edges->size, sizeof(struct edge *), compare);
  return sorted;
  (void)nextCaller;
  (void)nextCallee;
  (void)increasingEdgeTimes;
  (void)decreasingEdgeTimes;
}

static void printFlatProfile(void)
{
  struct profile **sorted= sortedProfiles(decreasingProfileSamples);
  long n, totalSamples= 0, cumulSamples= 0, totalTime= 0;
  for (n= 0;  n < profiles.size;  ++n)
    {
      totalSamples += sorted[n]->numSamples;
      if (totalTime < sorted[n]->totalTime)
	totalTime= sorted[n]->totalTime;
    }
  printf("Flat profile (total time %ld ms):\n", (long)(totalTime * msRatio));
  printf("       time      cumulative    call\n");
  printf("  mSecs     %%   mSecs     %%   count method\n");
  for (n= 0;  n < profiles.size;  ++n)
    {
      struct profile *profile= sorted[n];
      cumulSamples += profile->numSamples;
      printf("%7ld %5.1f %7ld %5.1f %7ld %s %s\n",
	     (long)(profile->numSamples * msRatio), (float)profile->numSamples / totalSamples * 100.0,
	     (long)(cumulSamples * msRatio), (float)cumulSamples / totalSamples * 100.0,
	     profile->numCalls, profile->method->type, profile->method->name);
    }
  free(sorted);
}

static void printCallContextProfile(void)
{
  struct profile **sorted= sortedProfiles(decreasingProfileSamples);
  int n, totalSamples= 0, totalTime= 0;
  for (n= 0;  n < profiles.size;  ++n)
    {
      totalSamples += sorted[n]->numSamples;
      if (totalTime < sorted[n]->totalTime)
	totalTime= sorted[n]->totalTime;
    }
  printf("\nContextual profile (total time %ld ms)\n", (long)(totalTime * msRatio));
  printf("       self    self+children   call  caller\n");
  printf("   time     %%    time     %%   count method\n");
  printf("                                     callee\n");
  for (n= 0;  n < profiles.size;  ++n)
    {
      struct profile *profile= sorted[n];
      struct edge **edges= sortedEdges(&profile->callers, increasingEdgeTimes, nextCaller);
      int m;
      for (m= 0;  m < profile->callers.size;  ++m)
	{
	  struct edge *edge= edges[m];
	  if (edge->caller)
	    {
	      struct __methodinfo *method= edge->caller->method;
	      printf("              %7ld %5.1f %7ld  %s %s\n",
		     (long)(edge->totalTime * msRatio), (float)edge->totalTime / profile->totalTime * 100.0,
		     edge->numCalls, method->type, method->name);
	    }
	}
      free(edges);
      printf("%7ld %5.1f %7ld %5.1f %7ld %s %s\n",
	     (long)(profile->numSamples * msRatio), (float)profile->numSamples / totalSamples * 100.0,
	     (long)(profile->totalTime  * msRatio), (float)profile->totalTime  / totalTime    * 100.0,
	     profile->numCalls, profile->method->type, profile->method->name);
      edges= sortedEdges(&profile->callees, decreasingEdgeTimes, nextCallee);
      for (m= 0;  m < profile->callees.size;  ++m)
	{
	  struct edge *edge= edges[m];
	  if (edge->callee)
	    {
	      struct __methodinfo *method= edge->callee->method;
	      printf("              %7ld %5.1f %7ld  %s %s\n",
		     (long)(edge->totalTime * msRatio), (float)edge->totalTime / profile->totalTime * 100.0,
		     edge->numCalls, method->type, method->name);
	    }
	}
      free(edges);
      printf("\n");
    }
  free(sorted);
}

static int currentCycle= 0;

static void printCallGraphProfileFrom(struct profile *profile, struct edge *caller, float totalSamples, float totalTime, int depth)
{
  int m;
  if (caller)
    printf("%5d %7ld %5.1f %7ld %5.1f ",
	   ++currentCycle,
	   (long)(caller ->totalTime  * msRatio), (float)caller ->totalTime  / totalTime    * 100.0,
	   (long)(profile->numSamples * msRatio), (float)profile->numSamples / totalSamples * 100.0);
  else
    printf("%5d %7ld %5.1f %7ld %5.1f ",
	   ++currentCycle,
	   (long)(profile->totalTime  * msRatio), (float)profile->totalTime  / totalTime    * 100.0,
	   (long)(profile->numSamples * msRatio), (float)profile->numSamples / totalSamples * 100.0);
  
  for (m= depth;  m--;) printf("| ");
  printf("%s %s", profile->method->type, profile->method->name);
  if (profile->active)
    printf(" <%d>\n", profile->active);
  else
    {
      struct edge **edges= sortedEdges(&profile->callees, decreasingEdgeTimes, nextCallee);
      printf("\n");
      ++depth;
      profile->active= currentCycle;
      for (m= 0;  m < profile->callees.size;  ++m)
	{
	  struct edge *edge= edges[m];
	  struct profile *callee= edge->callee;
	  if (!edge->active)
	    {
	      edge->active++;
	      printCallGraphProfileFrom(callee, edge, totalSamples, totalTime, depth);
	      edge->active--;
	    }
	  
	}
      free(edges);
    }
}

static void printCallGraphProfile(void)
{
  int n;
  long totalSamples= 0, totalTime= 0;
  float floatSamples, floatTime;
  struct profile **sorted= sortedProfiles(decreasingProfileTimes);
  currentCycle= -1;
  for (n= 0;  n < profiles.size;  ++n)
    {
      struct profile *profile= sorted[n];
      struct edge *edge;
      for (edge= profile->callers.first;  edge;  edge= edge->nextCaller)
	edge->active= 0;
      profile->active= 0;
      totalSamples += profile->numSamples;
      if (totalTime < profile->totalTime) totalTime= profile->totalTime;
    }
  printf("\nCall graph profile (total time %ld ms):\n", (long)(totalTime * msRatio));
  printf("       self+children       self\n");
  printf("cycle    time     %%    time     %% method <cycle>\n");
  floatSamples= (float)totalSamples;
  floatTime= (float)totalTime;
  for (n= 0;  n < profiles.size;  ++n)
    {
      struct profile *profile= sorted[n];
      if (!sorted[n]->active)
	printCallGraphProfileFrom(profile, 0, floatSamples, floatTime, 0);
    }
  free(sorted);
}

static void printExecutionProfile(void)
{
  printFlatProfile();
  printCallContextProfile();
  printCallGraphProfile();
  (void)printExecutionProfile;
}

static void clearExecutionProfile(void)
{
  struct profile *profile= profiles.first, *nextProfile;
  while (profile)
    {
      nextProfile= profile->next;
      struct edge *edge= profile->callees.first, *nextEdge;
      while (edge)
	{
	  nextEdge= edge->nextCallee;
	  free(edge);
	  --numEdges;
	  edge= nextEdge;
	}
      free(profile);
      --numProfiles;
      profile= nextProfile;
    }
  profiles.first= 0;
  profiles.size= 0;
  if (numProfiles != 0) fprintf(stderr, "leaking %ld profiles\n", numProfiles);
  if (numEdges    != 0) fprintf(stderr, "leaking %ld edges\n",    numEdges   );
}

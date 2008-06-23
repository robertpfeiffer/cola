#ifndef __freedline_h
#define __freedline_h

typedef char **(*FreedlineCompletionFunction)(char *text, int start, int end);
typedef char  *(*FreedlineCompletionGenerator)(char *prefix, int state);

extern FreedlineCompletionFunction freedlineCompletionFunction;

extern char  *freedlineHistoryGenerator(char *prefix, int state);
extern char **freedlineCompletionMatches(char *text, int start, int end, FreedlineCompletionGenerator generator);
extern char  *freedline(char *promptOrNull);

extern void   freedlineLoadHistory(char *fileName);
extern void   freedlineSaveHistory(char *fileName);

#endif /* __freedline_h */

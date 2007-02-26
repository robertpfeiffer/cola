#define VM_PROXY_MAJOR 1
#define VM_PROXY_MINOR 5

#include "vmProxy.h"

#define _O(I)		((oop)((I) << 1 | 1))
#define _I(O)		((int)(O) >> 1)
#define VM(S, ARGS...)	((int)_send(s_##S, vm, ## ARGS))

static oop vm= 0;

#define MISSING	printf("MISSING: %s:%d %s\n", __FILE__, __LINE__, __PRETTY_FUNCTION__);  exit(1);  return 0

static int minorVersion(void)								{ return VM_PROXY_MINOR; }
static int majorVersion(void)								{ return VM_PROXY_MAJOR; }
/* InterpreterProxy methodsFor: 'stack access' */
static int pop(int nItems)								{ return VM(pop_, _O(nItems)); }
static int popthenPush(int nItems, int oop)						{ MISSING; }
static int push(int object)								{ MISSING; }
static int pushBool(int trueOrFalse)							{ MISSING; }
static int pushFloat(double f)								{ MISSING; }
static int pushInteger(int integerValue)						{ MISSING; }
static double stackFloatValue(int offset)						{ MISSING; }
static int stackIntegerValue(int offset)						{ MISSING; }
static int stackObjectValue(int offset)							{ MISSING; }

static int stackValue(int offset)							{ return (int)VM(stackValue_, _O(offset)); }

/* InterpreterProxy methodsFor: 'object access' */
static int argumentCountOf(int methodPointer)						{ MISSING; }
static void * arrayValueOf(int oop)							{ MISSING; }
static int byteSizeOf(int objectPointer)						{ return _I(VM(byteSizeOf_, objectPointer)); }
static void * fetchArrayofObject(int fieldIndex, int objectPointer)			{ MISSING; }
static int fetchClassOf(int oop)							{ MISSING; }
static double fetchFloatofObject(int fieldIndex, int objectPointer)			{ MISSING; }

static int fetchIntegerofObject(int fieldIndex, int objectPointer)			{ return _I(VM(fetchInteger_ofObject_, _O(fieldIndex), objectPointer)); }

static int fetchPointerofObject(int fieldIndex, int objectPointer)			{ return VM(fetchPointer_ofObject_, _O(fieldIndex), objectPointer); }

static int fetchWordofObject(int fieldFieldIndex, int oop)				{ MISSING; }
static void * firstFixedField(int oop)							{ MISSING; }
static void * firstIndexableField(int objectPointer)					{ return (void *)VM(firstIndexableField_, objectPointer); }
static int literalofMethod(int offset, int methodPointer)				{ MISSING; }
static int literalCountOf(int methodPointer)						{ MISSING; }

static int methodArgumentCount(void)							{ return _I(VM(methodArgumentCount)); }

static int methodPrimitiveIndex(void)							{ MISSING; }
static int primitiveIndexOf(int methodPointer)						{ MISSING; }
static int sizeOfSTArrayFromCPrimitive(void *cPtr)					{ MISSING; }
static int slotSizeOf(int objectPointer)						{ return _I(VM(slotSizeOf_, objectPointer)); }
static int stObjectat(int array, int fieldIndex)					{ MISSING; }
static int stObjectatput(int array, int fieldIndex, int value)				{ MISSING; }
static int stSizeOf(int oop)								{ MISSING; }
static int storeIntegerofObjectwithValue(int fieldIndex, int oop, int integer)		{ MISSING; }
static int storePointerofObjectwithValue(int fieldIndex, int oop, int valuePointer)	{ MISSING; }
/* InterpreterProxy methodsFor: 'testing' */
static int isKindOf(int oop, char *aString)						{ MISSING; }
static int isMemberOf(int oop, char *aString)						{ MISSING; }
static int isBytes(int oop)								{ MISSING; }
static int isFloatObject(int oop)							{ MISSING; }
static int isIndexable(int oop)								{ MISSING; }
static int isIntegerObject(int objectPointer)						{ MISSING; }
static int isIntegerValue(int intValue)							{ MISSING; }
static int isPointers(int objectPointer)						{ return VM(isPointers_, objectPointer); }
static int isWeak(int oop)								{ MISSING; }
static int isWords(int objectPointer)							{ return VM(isWords_, objectPointer); }
static int isWordsOrBytes(int objectPointer)						{ return VM(isWordsOrBytes_, objectPointer); }
/* InterpreterProxy methodsFor: 'converting' */
static int booleanValueOf(int obj)							{ MISSING; }
static int checkedIntegerValueOf(int intOop)						{ MISSING; }
static int floatObjectOf(double aFloat)							{ MISSING; }
static double floatValueOf(int oop)							{ MISSING; }
static int integerObjectOf(int value)							{ MISSING; }
static int integerValueOf(int oop)							{ MISSING; }
static int positive32BitIntegerFor(int integerValue)					{ MISSING; }
static int positive32BitValueOf(int oop)						{ MISSING; }
/* InterpreterProxy methodsFor: 'special objects' */

static int characterTable(void)								{ return VM(characterTable); }
static int displayObject(void)								{ return VM(displayObject); }
static int falseObject(void)								{ return VM(falseObject); }
static int nilObject(void)								{ return VM(nilObject); }
static int trueObject(void)								{ return VM(trueObject); }


/* InterpreterProxy methodsFor: 'special classes' */
static int classArray(void)								{ MISSING; }
static int classBitmap(void)								{ MISSING; }
static int classByteArray(void)								{ MISSING; }
static int classCharacter(void)								{ MISSING; }
static int classFloat(void)								{ MISSING; }
static int classLargePositiveInteger(void)						{ MISSING; }
static int classPoint(void)								{ MISSING; }
static int classSemaphore(void)								{ MISSING; }
static int classSmallInteger(void)							{ MISSING; }
static int classString(void)								{ MISSING; }
/* InterpreterProxy methodsFor: 'instance creation' */
static int clone(int oop)								{ MISSING; }
static int instantiateClassindexableSize(int classPointer, int size)			{ MISSING; }
static int makePointwithxValueyValue(int xValue, int yValue)				{ MISSING; }
static int popRemappableOop(void)							{ MISSING; }
static int pushRemappableOop(int oop)							{ MISSING; }
/* InterpreterProxy methodsFor: 'other' */
static int becomewith(int array1, int array2)						{ MISSING; }
static int byteSwapped(int w)								{ MISSING; }

static int failed(void)									{ return !!VM(failed); }

static int fullDisplayUpdate(void)							{ MISSING; }
static int fullGC(void)									{ MISSING; }
static int incrementalGC(void)								{ MISSING; }

static int primitiveFail(void)								{ return VM(primitiveFail); }

static int showDisplayBitsLeftTopRightBottom(int aForm, int l, int t, int r, int b)	{ return VM(showDisplayBits_l_t_r_b_, aForm, _O(l), _O(t), _O(r), _O(b)); }
static int signalSemaphoreWithIndex(int semaIndex)					{ MISSING; }
static int success(int aBoolean)							{ MISSING; }
static int superclassOf(int classPointer)						{ MISSING; }
/* InterpreterProxy methodsFor: 'compiler' */
static CompilerHook *compilerHookVector(void)						{ MISSING; }
static int setCompilerInitialized(int initFlag)						{ MISSING; }
/* InterpreterProxy methodsFor: 'BitBlt support' */
static int loadBitBltFrom(int bbOop)							{ MISSING; }
static int copyBits(void)								{ MISSING; }
static int copyBitsFromtoat(int leftX, int rightX, int yValue)				{ MISSING; }
/* New for proxy version 1.3 */
static int classLargeNegativeInteger(void)						{ MISSING; }
static int signed32BitIntegerFor(int integerValue)					{ MISSING; }
static int signed32BitValueOf(int oop)							{ MISSING; }
static int includesBehaviorThatOf(int aClass, int aSuperClass)				{ MISSING; }
static int primitiveMethod (void)							{ MISSING; }
/* InterpreterProxy methodsFor: 'FFI support' */
static int classExternalAddress(void)							{ MISSING; }
static int classExternalData(void)							{ MISSING; }
static int classExternalFunction(void)							{ MISSING; }
static int classExternalLibrary(void)							{ MISSING; }
static int classExternalStructure(void)							{ MISSING; }

static int ioLoadModuleOfLength(int modIndex, int modLength)				{ MISSING; }
static int ioLoadSymbolOfLengthFromModule(int fnIndex, int fnLength, int handle)	{ MISSING; }
static int isInMemory(int address)							{ MISSING; }
static int ioLoadFunctionFrom(char *fnName, char *modName)				{ MISSING; }
static int ioMicroMSecs(void)								{ MISSING; }
static int positive64BitIntegerFor(squeakInt64 integerValue)				{ MISSING; }
static squeakInt64 positive64BitValueOf(int oop)					{ MISSING; }
static int signed64BitIntegerFor(squeakInt64 integerValue)				{ MISSING; }
static squeakInt64 signed64BitValueOf(int oop)						{ MISSING; }

#undef MISSING

static VirtualMachine vmProxy= {
  minorVersion,
  majorVersion,
  /* InterpreterProxy methodsFor: 'stack access' */
  pop,
  popthenPush,
  push,
  pushBool,
  pushFloat,
  pushInteger,
  stackFloatValue,
  stackIntegerValue,
  stackObjectValue,
  stackValue,
  /* InterpreterProxy methodsFor: 'object access' */
  argumentCountOf,
  arrayValueOf,
  byteSizeOf,
  fetchArrayofObject,
  fetchClassOf,
  fetchFloatofObject,
  fetchIntegerofObject,
  fetchPointerofObject,
  fetchWordofObject,
  firstFixedField,
  firstIndexableField,
  literalofMethod,
  literalCountOf,
  methodArgumentCount,
  methodPrimitiveIndex,
  primitiveIndexOf,
  sizeOfSTArrayFromCPrimitive,
  slotSizeOf,
  stObjectat,
  stObjectatput,
  stSizeOf,
  storeIntegerofObjectwithValue,
  storePointerofObjectwithValue,
  /* InterpreterProxy methodsFor: 'testing' */
  isKindOf,
  isMemberOf,
  isBytes,
  isFloatObject,
  isIndexable,
  isIntegerObject,
  isIntegerValue,
  isPointers,
  isWeak,
  isWords,
  isWordsOrBytes,
  /* InterpreterProxy methodsFor: 'converting' */
  booleanValueOf,
  checkedIntegerValueOf,
  floatObjectOf,
  floatValueOf,
  integerObjectOf,
  integerValueOf,
  positive32BitIntegerFor,
  positive32BitValueOf,
  /* InterpreterProxy methodsFor: 'special objects' */
  characterTable,
  displayObject,
  falseObject,
  nilObject,
  trueObject,
  /* InterpreterProxy methodsFor: 'special classes' */
  classArray,
  classBitmap,
  classByteArray,
  classCharacter,
  classFloat,
  classLargePositiveInteger,
  classPoint,
  classSemaphore,
  classSmallInteger,
  classString,
  /* InterpreterProxy methodsFor: 'instance creation' */
  clone,
  instantiateClassindexableSize,
  makePointwithxValueyValue,
  popRemappableOop,
  pushRemappableOop,
  /* InterpreterProxy methodsFor: 'other' */
  becomewith,
  byteSwapped,
  failed,
  fullDisplayUpdate,
  fullGC,
  incrementalGC,
  primitiveFail,
  showDisplayBitsLeftTopRightBottom,
  signalSemaphoreWithIndex,
  success,
  superclassOf,
  /* InterpreterProxy methodsFor: 'compiler' */
  compilerHookVector,
  setCompilerInitialized,
#if VM_PROXY_MINOR > 1
  /* new for proxy 1.2 */
  /* InterpreterProxy methodsFor: 'BitBlt support' */
  loadBitBltFrom,
  copyBits,
  copyBitsFromtoat,
#endif
#if VM_PROXY_MINOR > 2
  /* New for proxy version 1.3 */
  classLargeNegativeInteger,
  signed32BitIntegerFor,
  signed32BitValueOf,
  includesBehaviorThatOf,
  primitiveMethod,
  /* InterpreterProxy methodsFor: 'FFI support' */
  classExternalAddress,
  classExternalData,
  classExternalFunction,
  classExternalLibrary,
  classExternalStructure,
  ioLoadModuleOfLength,
  ioLoadSymbolOfLengthFromModule,
  isInMemory,
#endif
#if VM_PROXY_MINOR > 3
  /* New for proxy 1.4 */
  ioLoadFunctionFrom,
  ioMicroMSecs,
#endif
#if VM_PROXY_MINOR > 4
  /* New for proxy 1.5 */
  /* This is clearly a sub-optimal way to check for the ability to handle 64 bit
   * long long types but it suffices for the moment
   */
#define squeakInt64 long long
  positive64BitIntegerFor,
  positive64BitValueOf,
  signed64BitIntegerFor,
  signed64BitValueOf
#endif
};

static oop getProxy(oop aVM)
{
  vm= aVM;
  return (oop)&vmProxy;
}

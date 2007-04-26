#include "idst.h"

struct t_Object
{
  vtbl_t _vtbl[0];
};

struct t_UndefinedObject
{
  vtbl_t _vtbl[0];
};

struct t_StaticBlock
{
  vtbl_t _vtbl[0];
  oop _function;
  oop _arity;
};

struct t_BlockClosure
{
  vtbl_t _vtbl[0];
  oop _function;
  oop _arity;
  oop receiver;
  oop _state;
  oop outer;
};

struct t_BlockClosureNLR
{
  vtbl_t _vtbl[0];
  oop _function;
  oop _arity;
  oop receiver;
  oop _state;
  oop outer;
  oop _envp;
};

struct t_Magnitude
{
  vtbl_t _vtbl[0];
};

struct t_Number
{
  vtbl_t _vtbl[0];
};

struct t_Integer
{
  vtbl_t _vtbl[0];
};

struct t_SmallInteger
{
  vtbl_t _vtbl[0];
};

struct t_Collection
{
  vtbl_t _vtbl[0];
};

struct t_SequenceableCollection
{
  vtbl_t _vtbl[0];
};

struct t_ArrayedCollection
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_Array
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_ImmutableArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_ByteArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_ImmutableByteArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_String
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t_ImmutableString
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

struct t__object
{
  vtbl_t _vtbl[0];
};

struct t__vtbl
{
  vtbl_t _vtbl[0];
  oop size;
  oop capacity;
  oop _bindings;
  oop delegate;
};

struct t__binding
{
  vtbl_t _vtbl[0];
  oop selector;
  oop _method;
};

static oop l_1= 0;
struct t__selector
{
  vtbl_t _vtbl[0];
  oop size;
  oop _name;
  oop next;
};

static oop l_2= 0;
static oop l_3= 0;
static oop l_4= 0;
static oop l_5= 0;
static oop l_6= 0;
static oop l_7= 0;
static oop l_8= 0;
static oop l_9= 0;
static oop l_10= 0;
static oop l_11= 0;
static oop l_12= 0;
static oop l_13= 0;
static oop l_14= 0;
static oop l_15= 0;
static oop l_16= 0;
static oop l_17= 0;
static oop l_18= 0;
static oop l_19= 0;
static oop l_20= 0;
struct t_Association
{
  vtbl_t _vtbl[0];
  oop key;
  oop value;
};

static oop l_21= 0;
static oop l_22= 0;
static oop l_23= 0;
static oop l_24= 0;
static oop l_25= 0;
static oop l_26= 0;
static oop l_27= 0;
static oop l_28= 0;
static oop l_29= 0;
static oop l_30= 0;
static oop l_32= 0;
static oop l_31= 0;
static oop l_33= 0;
static oop l_34= 0;
static oop l_35= 0;
static oop l_36= 0;
static oop l_37= 0;
static oop l_38= 0;
static oop l_39= 0;
static oop l_40= 0;
static oop l_41= 0;
static oop l_42= 0;
static oop l_43= 0;
static oop l_44= 0;
static oop l_45= 0;
static oop l_46= 0;
static oop l_47= 0;
static oop l_48= 0;
static oop l_49= 0;
static oop l_50= 0;
static oop l_51= 0;
static oop l_52= 0;
static oop l_53= 0;
static oop l_54= 0;
struct t_OrderedCollection
{
  vtbl_t _vtbl[0];
  oop array;
  oop firstIndex;
  oop lastIndex;
};

static oop l_55= 0;
static oop l_56= 0;
static oop l_58= 0;
static oop l_57= 0;
static oop l_59= 0;
static oop l_60= 0;
static oop l_61= 0;
static oop l_62= 0;
static oop l_63= 0;
static oop l_64= 0;
static oop l_65= 0;
static oop l_66= 0;
static oop l_67= 0;
static oop l_68= 0;
static oop l_69= 0;
static oop l_70= 0;
static oop l_71= 0;
static oop l_72= 0;
static oop l_73= 0;
static oop l_74= 0;
static oop l_75= 0;
static oop l_76= 0;
static oop l_77= 0;
static oop l_78= 0;
static oop l_79= 0;
struct t_SortedCollection
{
  vtbl_t _vtbl[0];
  oop array;
  oop firstIndex;
  oop lastIndex;
  oop sortBlock;
};

static oop l_80= 0;
static oop l_81= 0;
static oop l_82= 0;
static oop l_83= 0;
static oop l_84= 0;
static oop l_85= 0;
static oop l_86= 0;
static oop l_87= 0;
static oop l_88= 0;
static oop l_89= 0;
static oop l_90= 0;
static oop l_91= 0;
struct t_Character
{
  vtbl_t _vtbl[0];
  oop value;
};

struct t_CharacterArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

static oop l_92= 0;
static oop l_93= 0;
static oop l_94= 0;
static oop c_23= 0;
static oop l_95= 0;
static oop l_96= 0;
static oop l_97= 0;
static oop l_98= 0;
static oop l_99= 0;
static oop l_100= 0;
static oop l_101= 0;
static oop l_102= 0;
static oop l_103= 0;
static oop l_104= 0;
static oop l_105= 0;
static oop l_106= 0;
static oop l_107= 0;
static oop l_108= 0;
static oop l_109= 0;
static oop l_110= 0;
static oop l_111= 0;
static oop l_112= 0;
static oop l_113= 0;
static oop l_114= 0;
static oop l_115= 0;
static oop l_116= 0;
static oop l_117= 0;
static oop l_118= 0;
static oop l_119= 0;
static oop l_120= 0;
static oop l_121= 0;
static oop l_122= 0;
static oop l_123= 0;
static oop l_124= 0;
static oop l_125= 0;
static oop l_126= 0;
static oop l_127= 0;
static oop l_128= 0;
static oop l_129= 0;
static oop l_130= 0;
static oop l_131= 0;
static oop l_132= 0;
static oop l_133= 0;
static oop l_134= 0;
static oop l_135= 0;
static oop l_136= 0;
static oop l_137= 0;
static oop l_138= 0;
static oop l_139= 0;
static oop l_140= 0;
static oop l_141= 0;
static oop l_142= 0;
static oop l_143= 0;
static oop l_144= 0;
static oop l_145= 0;
static oop l_146= 0;
static oop l_147= 0;
static oop l_148= 0;
static oop l_149= 0;
static oop l_150= 0;
static oop l_151= 0;
static oop l_152= 0;
static oop l_153= 0;
static oop l_154= 0;
static oop l_155= 0;
static oop l_156= 0;
static oop l_157= 0;
static oop l_158= 0;
static oop l_159= 0;
static oop l_160= 0;
static oop l_161= 0;
static oop l_162= 0;
static oop l_163= 0;
static oop l_164= 0;
static oop l_165= 0;
static oop l_166= 0;
static oop l_167= 0;
static oop l_168= 0;
static oop l_169= 0;
static oop l_170= 0;
static oop l_171= 0;
static oop l_172= 0;
static oop l_173= 0;
static oop l_174= 0;
static oop l_175= 0;
static oop l_176= 0;
static oop l_177= 0;
static oop l_178= 0;
static oop l_179= 0;
static oop l_180= 0;
static oop l_181= 0;
static oop l_182= 0;
static oop l_183= 0;
static oop l_184= 0;
static oop l_185= 0;
static oop l_186= 0;
static oop l_187= 0;
static oop l_188= 0;
static oop l_189= 0;
static oop l_190= 0;
static oop l_191= 0;
static oop l_192= 0;
static oop l_193= 0;
static oop l_194= 0;
static oop l_195= 0;
static oop l_196= 0;
static oop l_197= 0;
static oop l_198= 0;
static oop l_199= 0;
static oop l_200= 0;
static oop l_201= 0;
static oop l_202= 0;
static oop l_203= 0;
static oop l_204= 0;
static oop l_205= 0;
static oop l_206= 0;
static oop l_207= 0;
static oop l_208= 0;
static oop l_209= 0;
static oop l_210= 0;
static oop l_211= 0;
static oop l_212= 0;
static oop l_213= 0;
static oop l_214= 0;
static oop l_215= 0;
static oop l_216= 0;
static oop l_217= 0;
static oop l_218= 0;
static oop l_219= 0;
static oop l_220= 0;
static oop l_221= 0;
static oop l_222= 0;
static oop l_223= 0;
static oop l_224= 0;
static oop l_225= 0;
static oop l_226= 0;
static oop l_227= 0;
static oop l_228= 0;
static oop l_229= 0;
static oop l_230= 0;
static oop l_231= 0;
static oop l_232= 0;
static oop l_233= 0;
static oop l_234= 0;
static oop l_235= 0;
static oop l_236= 0;
static oop l_237= 0;
static oop l_238= 0;
static oop l_239= 0;
static oop l_240= 0;
static oop l_241= 0;
static oop l_242= 0;
static oop l_243= 0;
static oop l_244= 0;
static oop l_245= 0;
static oop l_246= 0;
static oop l_247= 0;
static oop l_248= 0;
static oop l_249= 0;
static oop l_250= 0;
static oop l_251= 0;
static oop l_252= 0;
static oop l_253= 0;
static oop l_254= 0;
static oop l_255= 0;
static oop l_256= 0;
static oop l_257= 0;
static oop l_258= 0;
static oop l_259= 0;
static oop l_260= 0;
static oop l_261= 0;
static oop l_262= 0;
static oop l_263= 0;
static oop l_264= 0;
static oop l_265= 0;
static oop l_266= 0;
static oop l_267= 0;
static oop l_268= 0;
static oop l_269= 0;
static oop l_270= 0;
static oop l_271= 0;
static oop l_272= 0;
static oop l_273= 0;
static oop l_274= 0;
static oop l_275= 0;
static oop l_276= 0;
static oop l_277= 0;
static oop l_278= 0;
static oop l_279= 0;
static oop l_280= 0;
static oop l_281= 0;
static oop l_282= 0;
static oop l_283= 0;
static oop l_284= 0;
static oop l_285= 0;
static oop l_286= 0;
static oop l_287= 0;
static oop l_288= 0;
static oop l_289= 0;
static oop l_290= 0;
static oop l_291= 0;
static oop l_292= 0;
static oop l_293= 0;
static oop l_294= 0;
static oop l_295= 0;
static oop l_296= 0;
static oop l_297= 0;
static oop l_298= 0;
static oop l_299= 0;
static oop l_300= 0;
static oop l_301= 0;
static oop l_302= 0;
static oop l_303= 0;
static oop l_304= 0;
static oop l_305= 0;
static oop l_306= 0;
static oop l_307= 0;
static oop l_308= 0;
static oop l_309= 0;
static oop l_310= 0;
static oop l_311= 0;
static oop l_312= 0;
static oop l_313= 0;
static oop l_314= 0;
static oop l_315= 0;
static oop l_316= 0;
static oop l_317= 0;
static oop l_318= 0;
static oop l_319= 0;
static oop l_320= 0;
static oop l_321= 0;
static oop l_322= 0;
static oop l_323= 0;
static oop l_324= 0;
static oop l_325= 0;
static oop l_326= 0;
static oop l_327= 0;
static oop l_328= 0;
static oop l_329= 0;
static oop l_330= 0;
static oop l_331= 0;
static oop l_332= 0;
static oop l_333= 0;
static oop l_334= 0;
static oop l_335= 0;
static oop l_336= 0;
static oop l_337= 0;
static oop l_338= 0;
static oop l_339= 0;
static oop l_340= 0;
static oop l_341= 0;
static oop l_342= 0;
static oop l_343= 0;
static oop l_344= 0;
static oop l_345= 0;
static oop l_346= 0;
static oop l_347= 0;
static oop l_348= 0;
static oop l_349= 0;
static oop l_350= 0;
static oop l_351= 0;
static oop l_352= 0;
static oop l_353= 0;
static oop l_354= 0;
static oop *_l_354[256]= {
  &l_98,
  &l_99,
  &l_100,
  &l_101,
  &l_102,
  &l_103,
  &l_104,
  &l_105,
  &l_106,
  &l_107,
  &l_108,
  &l_109,
  &l_110,
  &l_111,
  &l_112,
  &l_113,
  &l_114,
  &l_115,
  &l_116,
  &l_117,
  &l_118,
  &l_119,
  &l_120,
  &l_121,
  &l_122,
  &l_123,
  &l_124,
  &l_125,
  &l_126,
  &l_127,
  &l_128,
  &l_129,
  &l_130,
  &l_131,
  &l_132,
  &l_133,
  &l_134,
  &l_135,
  &l_136,
  &l_137,
  &l_138,
  &l_139,
  &l_140,
  &l_141,
  &l_142,
  &l_143,
  &l_144,
  &l_145,
  &l_146,
  &l_147,
  &l_148,
  &l_149,
  &l_150,
  &l_151,
  &l_152,
  &l_153,
  &l_154,
  &l_155,
  &l_156,
  &l_157,
  &l_158,
  &l_159,
  &l_160,
  &l_161,
  &l_162,
  &l_163,
  &l_164,
  &l_165,
  &l_166,
  &l_167,
  &l_168,
  &l_169,
  &l_170,
  &l_171,
  &l_172,
  &l_173,
  &l_174,
  &l_175,
  &l_176,
  &l_177,
  &l_178,
  &l_179,
  &l_180,
  &l_181,
  &l_182,
  &l_183,
  &l_184,
  &l_185,
  &l_186,
  &l_187,
  &l_188,
  &l_189,
  &l_190,
  &l_191,
  &l_192,
  &l_193,
  &l_194,
  &l_195,
  &l_196,
  &l_197,
  &l_198,
  &l_199,
  &l_200,
  &l_201,
  &l_202,
  &l_203,
  &l_204,
  &l_205,
  &l_206,
  &l_207,
  &l_208,
  &l_209,
  &l_210,
  &l_211,
  &l_212,
  &l_213,
  &l_214,
  &l_215,
  &l_216,
  &l_217,
  &l_218,
  &l_219,
  &l_220,
  &l_221,
  &l_222,
  &l_223,
  &l_224,
  &l_225,
  &l_226,
  &l_227,
  &l_228,
  &l_229,
  &l_230,
  &l_231,
  &l_232,
  &l_233,
  &l_234,
  &l_235,
  &l_236,
  &l_237,
  &l_238,
  &l_239,
  &l_240,
  &l_241,
  &l_242,
  &l_243,
  &l_244,
  &l_245,
  &l_246,
  &l_247,
  &l_248,
  &l_249,
  &l_250,
  &l_251,
  &l_252,
  &l_253,
  &l_254,
  &l_255,
  &l_256,
  &l_257,
  &l_258,
  &l_259,
  &l_260,
  &l_261,
  &l_262,
  &l_263,
  &l_264,
  &l_265,
  &l_266,
  &l_267,
  &l_268,
  &l_269,
  &l_270,
  &l_271,
  &l_272,
  &l_273,
  &l_274,
  &l_275,
  &l_276,
  &l_277,
  &l_278,
  &l_279,
  &l_280,
  &l_281,
  &l_282,
  &l_283,
  &l_284,
  &l_285,
  &l_286,
  &l_287,
  &l_288,
  &l_289,
  &l_290,
  &l_291,
  &l_292,
  &l_293,
  &l_294,
  &l_295,
  &l_296,
  &l_297,
  &l_298,
  &l_299,
  &l_300,
  &l_301,
  &l_302,
  &l_303,
  &l_304,
  &l_305,
  &l_306,
  &l_307,
  &l_308,
  &l_309,
  &l_310,
  &l_311,
  &l_312,
  &l_313,
  &l_314,
  &l_315,
  &l_316,
  &l_317,
  &l_318,
  &l_319,
  &l_320,
  &l_321,
  &l_322,
  &l_323,
  &l_324,
  &l_325,
  &l_326,
  &l_327,
  &l_328,
  &l_329,
  &l_330,
  &l_331,
  &l_332,
  &l_333,
  &l_334,
  &l_335,
  &l_336,
  &l_337,
  &l_338,
  &l_339,
  &l_340,
  &l_341,
  &l_342,
  &l_343,
  &l_344,
  &l_345,
  &l_346,
  &l_347,
  &l_348,
  &l_349,
  &l_350,
  &l_351,
  &l_352,
  &l_353,
};
static oop l_355= 0;
static oop l_356= 0;
static oop l_357= 0;
static oop l_358= 0;
static oop l_359= 0;
static oop l_360= 0;
static oop l_361= 0;
static oop l_362= 0;
static oop l_363= 0;
static oop l_364= 0;
static oop l_365= 0;
static oop l_366= 0;
static oop l_367= 0;
static oop l_368= 0;
static oop l_369= 0;
static oop l_370= 0;
static oop l_371= 0;
static oop l_372= 0;
static oop l_373= 0;
static oop l_374= 0;
static oop l_375= 0;
static oop l_376= 0;
static oop l_377= 0;
static oop l_378= 0;
static oop l_379= 0;
static oop l_380= 0;
static oop l_381= 0;
static oop l_382= 0;
static oop l_383= 0;
static oop l_384= 0;
static oop l_385= 0;
static oop l_386= 0;
static oop l_387= 0;
static oop l_388= 0;
static oop l_389= 0;
static oop l_390= 0;
static oop l_391= 0;
static oop l_392= 0;
struct t_WordArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

static oop l_393= 0;
static oop l_394= 0;
static oop l_395= 0;
struct t_ImmutableWordArray
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

static oop l_396= 0;
static oop l_397= 0;
static oop l_398= 0;
static oop l_399= 0;
static oop l_400= 0;
static oop l_401= 0;
static oop l_402= 0;
static oop l_403= 0;
static oop l_404= 0;
static oop l_405= 0;
static oop c_26= 0;
static oop l_406= 0;
static oop l_407= 0;
static oop l_408= 0;
static oop l_409= 0;
static oop l_410= 0;
static oop l_411= 0;
static oop l_412= 0;
static oop l_413= 0;
static oop l_414= 0;
static oop l_415= 0;
static oop l_416= 0;
static oop l_417= 0;
static oop l_418= 0;
static oop l_419= 0;
static oop l_420= 0;
static oop l_421= 0;
static oop l_422= 0;
static oop l_423= 0;
static oop l_424= 0;
static oop l_425= 0;
static oop l_426= 0;
static oop l_427= 0;
static oop l_428= 0;
static oop l_429= 0;
static oop l_430= 0;
static oop l_431= 0;
static oop l_432= 0;
static oop l_433= 0;
static oop l_434= 0;
static oop l_435= 0;
static oop l_436= 0;
static oop l_437= 0;
static oop l_438= 0;
static oop l_439= 0;
static oop l_440= 0;
static oop l_441= 0;
static oop l_442= 0;
static oop l_443= 0;
static oop l_444= 0;
static oop l_445= 0;
static oop l_446= 0;
static oop l_447= 0;
static oop l_448= 0;
static oop l_449= 0;
static oop l_450= 0;
static oop l_451= 0;
static oop l_452= 0;
static oop l_453= 0;
static oop l_454= 0;
static oop l_455= 0;
struct t_Set
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_456= 0;
static oop l_457= 0;
static oop l_458= 0;
static oop l_459= 0;
static oop l_460= 0;
static oop l_461= 0;
static oop l_462= 0;
static oop l_463= 0;
static oop l_464= 0;
static oop l_465= 0;
static oop l_466= 0;
static oop l_467= 0;
static oop l_468= 0;
static oop l_469= 0;
static oop l_470= 0;
static oop l_471= 0;
static oop l_472= 0;
struct t_IdentitySet
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_473= 0;
static oop l_474= 0;
static oop l_475= 0;
static oop l_476= 0;
struct t_Dictionary
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_477= 0;
static oop l_478= 0;
static oop l_480= 0;
static oop l_481= 0;
static oop l_479= 0;
struct t_IdentityDictionary
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_482= 0;
static oop l_483= 0;
static oop l_484= 0;
static oop l_485= 0;
struct t_Symbol
{
  vtbl_t _vtbl[0];
  oop size;
  oop _elements;
};

static oop l_486= 0;
static oop l_487= 0;
struct t_SymbolTable
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_488= 0;
struct t_SelectorTable
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

struct t_Stream
{
  vtbl_t _vtbl[0];
};

static oop l_489= 0;
struct t_PositionableStream
{
  vtbl_t _vtbl[0];
  oop collection;
  oop position;
  oop readLimit;
};

static oop l_490= 0;
static oop l_491= 0;
static oop l_492= 0;
static oop l_493= 0;
static oop l_494= 0;
struct t_ReadStream
{
  vtbl_t _vtbl[0];
  oop collection;
  oop position;
  oop readLimit;
};

static oop l_495= 0;
struct t_WriteStream
{
  vtbl_t _vtbl[0];
  oop collection;
  oop position;
  oop readLimit;
  oop writeLimit;
};

static oop l_496= 0;
static oop l_497= 0;
static oop l_498= 0;
static oop l_499= 0;
static oop l_500= 0;
static oop l_501= 0;
static oop l_502= 0;
static oop l_503= 0;
static oop l_504= 0;
static oop l_505= 0;
static oop l_506= 0;
static oop l_507= 0;
static oop l_508= 0;
static oop l_509= 0;
static oop l_510= 0;
static oop l_511= 0;
static oop l_512= 0;
struct t_Smalltalk
{
  vtbl_t _vtbl[0];
};

static oop l_513= 0;
static oop l_514= 0;
struct t_GetOpt
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
  oop defaultBlock;
};

static oop c_69= 0;
static oop l_515= 0;
static oop l_516= 0;
static oop l_517= 0;
static oop l_519= 0;
static oop l_518= 0;
static oop l_520= 0;
static oop l_521= 0;
static oop l_522= 0;
static oop l_523= 0;
static oop l_524= 0;
static oop l_525= 0;
static oop l_526= 0;
static oop l_527= 0;
static oop l_528= 0;
static oop l_529= 0;
static oop l_530= 0;
static oop l_531= 0;
struct t_CompilerOptions
{
  vtbl_t _vtbl[0];
  oop searchPaths;
  oop mainFlag;
};

struct t_Scanner
{
  vtbl_t _vtbl[0];
  oop charTable;
  oop charEscapes;
  oop input;
  oop c;
  oop token;
  oop type;
  oop includeStack;
  oop options;
  oop prevHash;
  oop fileName;
  oop lineNumber;
  oop headerFlag;
};

struct t_Parser
{
  vtbl_t _vtbl[0];
  oop charTable;
  oop charEscapes;
  oop input;
  oop c;
  oop token;
  oop type;
  oop includeStack;
  oop options;
  oop prevHash;
  oop fileName;
  oop lineNumber;
  oop headerFlag;
};

struct t_Compiler
{
  vtbl_t _vtbl[0];
  oop charTable;
  oop charEscapes;
  oop input;
  oop c;
  oop token;
  oop type;
  oop includeStack;
  oop options;
  oop prevHash;
  oop fileName;
  oop lineNumber;
  oop headerFlag;
  oop program;
  oop translationUnit;
};

struct t_Scope
{
  vtbl_t _vtbl[0];
  oop level;
  oop environment;
  oop imports;
  oop exports;
  oop parent;
  oop block;
  oop exportSelf;
  oop exportOuter;
  oop exportNLR;
  oop minTemp;
  oop maxTemp;
  oop nTemps;
  oop literals;
  oop blocks;
};

struct t_TranslationUnit
{
  vtbl_t _vtbl[0];
  oop environment;
  oop externals;
  oop classes;
  oop selectors;
  oop outputStream;
};

struct t_Variable
{
  vtbl_t _vtbl[0];
};

struct t_NamedVariable
{
  vtbl_t _vtbl[0];
  oop name;
  oop mangledName;
};

struct t_GlobalVariable
{
  vtbl_t _vtbl[0];
  oop name;
  oop mangledName;
};

struct t_SelfVariable
{
  vtbl_t _vtbl[0];
  oop name;
  oop mangledName;
};

struct t_ReceiverVariable
{
  vtbl_t _vtbl[0];
  oop name;
  oop mangledName;
  oop class;
};

struct t_LocalVariable
{
  vtbl_t _vtbl[0];
  oop name;
  oop mangledName;
  oop isExported;
  oop level;
  oop offset;
};

struct t_RemoteReceiverVariable
{
  vtbl_t _vtbl[0];
  oop receiverVariable;
};

struct t_RemoteVariable
{
  vtbl_t _vtbl[0];
  oop level;
  oop offset;
};

struct t_ParseNode
{
  vtbl_t _vtbl[0];
  oop location;
};

struct t_ValueNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
};

struct t_BlockReturnNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
};

struct t_ReturnNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop level;
};

struct t_LiteralNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_SymbolNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_StringNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_IntegerNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_CharacterNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_ArrayNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_WordArrayNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_ByteArrayNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop value;
  oop tag;
};

struct t_VariableNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop name;
  oop variable;
};

struct t_AssignmentNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop variable;
  oop value;
};

struct t_SendNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop receiver;
  oop selector;
  oop mangled;
  oop arguments;
  oop cascade;
  oop supered;
  oop macro;
};

struct t_TemplateNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop text;
};

struct t_PrimitiveNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop code;
};

struct t_ExternDeclarationNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop names;
};

struct t_IncludeNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop name;
};

struct t_ImportNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop names;
};

struct t_ExportNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop names;
};

struct t_RequireNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop names;
};

struct t_ClassNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop name;
  oop mangledName;
  oop typeName;
  oop base;
  oop slots;
};

struct t_ExternalClassNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop classNode;
};

struct t_SequenceNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop temporaries;
  oop statements;
  oop literals;
  oop scope;
};

struct t_BlockNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop temporaries;
  oop statements;
  oop literals;
  oop scope;
  oop arguments;
  oop variadic;
  oop tag;
};

struct t_MethodNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop temporaries;
  oop statements;
  oop literals;
  oop scope;
  oop arguments;
  oop variadic;
  oop tag;
  oop class;
  oop selector;
};

struct t_ExecNode
{
  vtbl_t _vtbl[0];
  oop location;
  oop temporaries;
  oop statements;
  oop literals;
  oop scope;
};

static oop l_532= 0;
static oop l_533= 0;
static oop l_534= 0;
static oop l_535= 0;
static oop l_536= 0;
static oop l_537= 0;
static oop l_538= 0;
static oop l_539= 0;
static oop l_540= 0;
static oop l_541= 0;
static oop l_542= 0;
static oop l_543= 0;
static oop l_544= 0;
static oop l_546= 0;
static oop l_547= 0;
static oop l_549= 0;
static oop l_550= 0;
static oop l_545= 0;
static oop l_548= 0;
static oop l_551= 0;
static oop l_552= 0;
static oop l_553= 0;
struct t_LiteralNodeTag
{
  vtbl_t _vtbl[0];
};

static oop l_554= 0;
static oop l_555= 0;
static oop l_556= 0;
static oop l_557= 0;
static oop l_558= 0;
static oop l_559= 0;
static oop l_560= 0;
static oop l_561= 0;
static oop l_562= 0;
static oop l_563= 0;
static oop l_564= 0;
static oop l_565= 0;
static oop l_566= 0;
static oop l_567= 0;
static oop l_568= 0;
static oop l_569= 0;
static oop l_576= 0;
static oop l_570= 0;
static oop l_571= 0;
static oop l_572= 0;
static oop l_573= 0;
static oop l_574= 0;
static oop l_575= 0;
static oop l_577= 0;
static oop l_578= 0;
static oop l_579= 0;
static oop l_580= 0;
static oop l_581= 0;
static oop l_582= 0;
static oop l_583= 0;
static oop l_584= 0;
static oop l_585= 0;
static oop l_586= 0;
static oop l_587= 0;
static oop l_588= 0;
static oop l_589= 0;
static oop l_590= 0;
static oop l_591= 0;
static oop l_592= 0;
static oop l_593= 0;
static oop l_594= 0;
static oop l_595= 0;
static oop l_596= 0;
static oop l_597= 0;
static oop l_598= 0;
static oop l_599= 0;
static oop l_600= 0;
static oop l_603= 0;
static oop l_601= 0;
static oop l_602= 0;
static oop l_604= 0;
static oop l_605= 0;
static oop l_606= 0;
static oop l_607= 0;
static oop l_608= 0;
static oop l_609= 0;
static oop l_610= 0;
static oop l_611= 0;
static oop l_612= 0;
static oop l_613= 0;
static oop l_614= 0;
static oop l_615= 0;
static oop l_616= 0;
static oop l_617= 0;
static oop l_618= 0;
static oop l_619= 0;
static oop l_620= 0;
static oop l_621= 0;
static oop l_622= 0;
static oop l_625= 0;
static oop l_623= 0;
static oop l_624= 0;
static oop l_626= 0;
static oop l_627= 0;
static oop l_628= 0;
static oop l_629= 0;
static oop l_630= 0;
static oop l_631= 0;
static oop l_633= 0;
static oop l_632= 0;
static oop l_634= 0;
static oop l_635= 0;
static oop l_636= 0;
static oop l_637= 0;
static oop l_638= 0;
static oop l_639= 0;
static oop l_640= 0;
static oop l_641= 0;
static oop l_642= 0;
static oop l_643= 0;
static oop l_644= 0;
static oop l_645= 0;
static oop l_646= 0;
static oop l_647= 0;
static oop l_648= 0;
static oop l_649= 0;
static oop l_650= 0;
static oop l_651= 0;
static oop l_652= 0;
struct t_MacroEncoders
{
  vtbl_t _vtbl[0];
  oop tally;
  oop array;
};

static oop l_653= 0;
static oop l_654= 0;
static oop l_655= 0;
static oop l_656= 0;
static oop l_657= 0;
static oop l_658= 0;
static oop l_659= 0;
static oop l_660= 0;
static oop l_661= 0;
static oop l_662= 0;
static oop l_663= 0;
static oop l_664= 0;
static oop l_665= 0;
static oop l_666= 0;
static oop l_667= 0;
static oop l_668= 0;
static oop l_669= 0;
static oop l_670= 0;
static oop l_671= 0;
static oop l_672= 0;
static oop l_673= 0;
static oop l_674= 0;
static oop l_675= 0;
static oop l_676= 0;
static oop l_677= 0;
static oop l_678= 0;
static oop l_679= 0;
static oop l_680= 0;
static oop l_681= 0;
static oop l_682= 0;
static oop l_683= 0;
static oop l_684= 0;
static oop l_685= 0;
static oop l_686= 0;
static oop l_687= 0;
static oop l_688= 0;
static oop l_689= 0;
static oop l_690= 0;
static oop l_691= 0;
static oop l_692= 0;
static oop l_693= 0;
static oop l_694= 0;
static oop l_695= 0;
static oop l_696= 0;
static oop l_697= 0;
static oop l_698= 0;
static oop l_699= 0;
static oop l_700= 0;
static oop l_701= 0;
static oop l_702= 0;
static oop l_703= 0;
static oop l_704= 0;
static oop l_705= 0;
static oop l_706= 0;
static oop l_707= 0;
static oop l_708= 0;
static oop l_709= 0;
static oop l_710= 0;
static oop l_711= 0;
static oop l_712= 0;
static oop l_713= 0;
static oop l_714= 0;
static oop l_715= 0;
static oop l_716= 0;
static oop l_717= 0;
static oop l_718= 0;
static oop l_719= 0;
static oop l_720= 0;
static oop l_721= 0;
static oop l_722= 0;
static oop l_723= 0;
static oop l_724= 0;
static oop l_725= 0;
static oop l_726= 0;
static oop l_727= 0;
static oop l_728= 0;
static oop l_729= 0;
static oop l_730= 0;
static oop l_731= 0;
static oop l_732= 0;
static oop l_733= 0;
static oop l_734= 0;
static oop l_735= 0;
static oop l_736= 0;
static oop l_737= 0;
static oop l_738= 0;
static oop l_739= 0;
static oop l_740= 0;
static oop l_741= 0;
static oop l_742= 0;
static oop l_743= 0;
static oop l_744= 0;
static oop l_745= 0;
static oop l_746= 0;
static oop l_747= 0;
static oop l_748= 0;
static oop l_749= 0;
static oop l_750= 0;
static oop l_751= 0;
static oop l_752= 0;
static oop l_753= 0;
static oop l_754= 0;
static oop l_755= 0;
static oop l_756= 0;
static oop l_757= 0;
static oop l_758= 0;
static oop l_759= 0;
static oop l_760= 0;
static oop l_761= 0;
static oop l_762= 0;
static oop l_763= 0;
static oop l_764= 0;
static oop l_765= 0;
static oop l_766= 0;
static oop l_767= 0;
static oop l_768= 0;
static oop l_769= 0;
static oop l_770= 0;
static oop l_771= 0;
static oop l_772= 0;
static oop l_773= 0;
static oop l_774= 0;
static oop l_775= 0;
static oop l_776= 0;
static oop l_777= 0;
static oop l_778= 0;
static oop l_779= 0;
static oop l_780= 0;
static oop l_781= 0;
static oop l_782= 0;
static oop l_783= 0;
static oop l_784= 0;
static oop l_785= 0;
static oop l_786= 0;
static oop l_787= 0;
static oop l_788= 0;
static oop l_789= 0;
static oop l_790= 0;
static oop l_791= 0;
static oop l_792= 0;
static oop l_793= 0;
static oop l_794= 0;
static oop l_795= 0;
static oop l_796= 0;
static oop l_797= 0;
static oop l_798= 0;
static oop l_799= 0;
static oop l_800= 0;
static oop l_801= 0;
static oop l_802= 0;
static oop l_803= 0;
static oop l_804= 0;
static oop l_805= 0;
static oop l_806= 0;
static oop l_807= 0;
static oop l_808= 0;
static oop l_809= 0;
static oop l_810= 0;
static oop l_811= 0;
static oop l_812= 0;
static oop l_813= 0;
static oop l_814= 0;
static oop l_815= 0;
static oop l_816= 0;
static oop l_817= 0;
static oop l_818= 0;
static oop l_819= 0;
static oop l_820= 0;
static oop l_821= 0;
static oop l_822= 0;
static oop l_823= 0;
static oop l_824= 0;
static oop l_825= 0;
static oop l_826= 0;
static oop l_827= 0;
static oop l_828= 0;
static oop l_829= 0;
static oop l_830= 0;
static oop l_831= 0;
static oop l_832= 0;
static oop l_833= 0;
static oop l_834= 0;
static oop l_835= 0;
static oop l_836= 0;
static oop l_837= 0;
static oop l_838= 0;
static oop l_839= 0;
static oop l_840= 0;
static oop l_841= 0;
static oop l_842= 0;
static oop l_843= 0;
static oop l_844= 0;
static oop l_845= 0;
static oop l_846= 0;
static oop l_847= 0;
static oop l_848= 0;
static oop l_849= 0;
static oop l_850= 0;
static oop l_851= 0;
static oop l_852= 0;
static oop l_853= 0;
static oop l_854= 0;
static oop l_855= 0;
static oop l_856= 0;
static oop l_857= 0;
static oop l_858= 0;
static oop l_859= 0;
static oop l_860= 0;
static oop l_861= 0;
static oop l_862= 0;
static oop l_863= 0;
static oop l_864= 0;
static oop l_865= 0;
static oop l_866= 0;
static oop l_867= 0;
static oop l_868= 0;
static oop l_869= 0;
static oop l_870= 0;
static oop l_871= 0;
static oop l_872= 0;
static oop l_873= 0;
static oop l_874= 0;
static oop l_875= 0;
static oop l_876= 0;
static oop l_877= 0;
static oop l_878= 0;
static oop l_879= 0;
static oop l_880= 0;
static oop l_881= 0;
static oop l_882= 0;
static oop l_883= 0;
static oop l_884= 0;
static oop l_885= 0;
static oop l_886= 0;
static oop l_887= 0;
static oop l_888= 0;
static oop l_889= 0;
static oop l_890= 0;
static oop l_891= 0;
static oop l_892= 0;
static oop l_893= 0;
static oop l_894= 0;
static oop l_895= 0;
static oop l_896= 0;
static oop l_897= 0;
static oop l_898= 0;
static oop l_899= 0;
static oop l_900= 0;
static oop l_901= 0;
static oop l_902= 0;
static oop l_903= 0;
static oop l_904= 0;
static oop l_905= 0;
static oop l_906= 0;
static oop l_907= 0;
static oop l_908= 0;
static oop l_909= 0;
static oop l_910= 0;
static oop l_911= 0;
static oop l_912= 0;
static oop l_913= 0;
static oop l_914= 0;
static oop l_915= 0;
static oop l_916= 0;
static oop l_917= 0;
static oop l_918= 0;
static oop l_919= 0;
static oop l_920= 0;
static oop l_921= 0;
static oop l_922= 0;
static oop l_923= 0;
static oop l_924= 0;
static oop l_925= 0;
static oop l_926= 0;
static oop l_927= 0;
static oop l_928= 0;
static oop l_929= 0;
static oop l_930= 0;
static oop l_931= 0;
static oop l_932= 0;
static oop l_933= 0;
static oop l_934= 0;
static oop l_935= 0;
static oop l_936= 0;
static oop l_937= 0;
static oop l_938= 0;
static oop l_939= 0;
static oop l_940= 0;
static oop l_941= 0;
static oop l_942= 0;
static oop l_943= 0;
static oop l_944= 0;
static oop l_945= 0;
static oop l_946= 0;
static oop l_947= 0;
static oop l_948= 0;
static oop l_949= 0;
static oop l_950= 0;
static oop l_951= 0;
static oop l_952= 0;
static oop l_953= 0;
static oop l_954= 0;
static oop l_955= 0;
static oop l_956= 0;
static oop l_957= 0;
static oop l_958= 0;
static oop l_959= 0;
static oop l_960= 0;
static oop l_961= 0;
static oop l_962= 0;
static oop l_963= 0;
static oop l_964= 0;
static oop l_965= 0;
static oop l_966= 0;
static oop l_967= 0;
static oop l_968= 0;
static oop l_969= 0;
static oop l_970= 0;
static oop l_971= 0;
static oop l_972= 0;
static oop l_973= 0;
static oop l_974= 0;
static oop l_975= 0;
static oop l_976= 0;
static oop l_977= 0;
static oop l_978= 0;
static oop l_979= 0;
static oop l_980= 0;
static oop l_981= 0;
static oop l_982= 0;
static oop l_983= 0;
static oop l_984= 0;
static oop l_985= 0;
static oop l_986= 0;
static oop l_987= 0;
static oop l_988= 0;
static oop l_989= 0;
static oop l_990= 0;
static oop l_991= 0;
static oop l_992= 0;
static oop l_993= 0;
static oop l_994= 0;
static oop l_995= 0;
static oop l_996= 0;
static oop l_997= 0;
static oop l_998= 0;
static oop l_999= 0;
static oop l_1000= 0;
static oop l_1001= 0;
static oop l_1002= 0;
static oop l_1003= 0;
static oop l_1004= 0;
static oop l_1005= 0;
static oop l_1006= 0;
static oop l_1007= 0;
static oop l_1008= 0;
static oop l_1009= 0;
static oop l_1010= 0;
static oop l_1011= 0;
static oop l_1012= 0;
static oop l_1013= 0;
static oop l_1014= 0;
static oop l_1015= 0;
static oop l_1016= 0;
static oop l_1017= 0;
static oop l_1018= 0;
static oop l_1020= 0;
static oop l_1019= 0;
static oop l_1021= 0;
static oop l_1022= 0;
static oop l_1023= 0;
static oop l_1025= 0;
static oop l_1026= 0;
static oop l_1027= 0;
static oop l_1024= 0;
static oop l_1028= 0;
static oop l_1029= 0;
static oop l_1030= 0;
static oop l_1031= 0;
static oop l_1032= 0;
static oop l_1035= 0;
static oop l_1036= 0;
static oop l_1037= 0;
static oop l_1039= 0;
static oop l_1040= 0;
static oop l_1033= 0;
static oop l_1034= 0;
static oop l_1038= 0;
struct t_BlockNodeTag
{
  vtbl_t _vtbl[0];
};

static oop l_1041= 0;
static oop l_1042= 0;
static oop l_1043= 0;
static oop l_1044= 0;
static oop l_1045= 0;
static oop l_1046= 0;
static oop l_1047= 0;
static oop l_1048= 0;
static oop l_1050= 0;
static oop l_1051= 0;
static oop l_1052= 0;
static oop l_1053= 0;
static oop l_1054= 0;
static oop l_1058= 0;
static oop l_1049= 0;
static oop l_1055= 0;
static oop l_1056= 0;
static oop l_1057= 0;
static oop l_1059= 0;
static oop l_1060= 0;
static oop l_1061= 0;
static oop l_1062= 0;
static oop l_1063= 0;
static oop l_1064= 0;
static oop l_1065= 0;
static oop l_1066= 0;
static oop l_1067= 0;
static oop l_1068= 0;
static oop l_1069= 0;
static oop l_1070= 0;
static oop l_1071= 0;
static oop l_1072= 0;
static oop l_1073= 0;
static oop l_1074= 0;
static oop l_1075= 0;
static oop l_1076= 0;
static oop l_1077= 0;
static oop l_1078= 0;
static oop l_1079= 0;
static oop l_1080= 0;
static oop l_1081= 0;
static oop l_1082= 0;
static oop l_1083= 0;
static oop l_1084= 0;
static oop l_1085= 0;
static oop l_1086= 0;
static oop l_1087= 0;
static oop l_1088= 0;
static oop l_1089= 0;
static oop l_1090= 0;
static oop l_1091= 0;
static oop l_1092= 0;
static oop l_1093= 0;
static oop l_1094= 0;
static oop l_1095= 0;
static oop l_1096= 0;
static oop l_1097= 0;
static oop l_1098= 0;
static oop l_1101= 0;
static oop l_1099= 0;
static oop l_1100= 0;
static oop l_1102= 0;
static oop l_1103= 0;
static oop l_1104= 0;
static oop l_1105= 0;
static oop l_1107= 0;
static oop l_1108= 0;
static oop l_1109= 0;
static oop l_1110= 0;
static oop l_1111= 0;
static oop l_1112= 0;
static oop l_1113= 0;
static oop l_1117= 0;
static oop l_1118= 0;
static oop l_1106= 0;
static oop l_1114= 0;
static oop l_1115= 0;
static oop l_1116= 0;
static oop l_1119= 0;
static oop l_1120= 0;
static oop l_1121= 0;
static oop l_1122= 0;
static oop l_1123= 0;
static oop l_1124= 0;
static oop l_1125= 0;
static oop l_1126= 0;
static oop l_1127= 0;
static oop l_1128= 0;
static oop l_1129= 0;
static oop l_1130= 0;
static oop l_1131= 0;
static oop l_1132= 0;
static oop l_1133= 0;
static oop l_1134= 0;
static oop l_1135= 0;
static oop l_1136= 0;
static oop l_1137= 0;
static oop l_1138= 0;
static oop l_1139= 0;
static oop l_1140= 0;
static oop l_1141= 0;
static oop l_1142= 0;
static oop l_1143= 0;
static oop l_1144= 0;
static oop l_1145= 0;
static oop l_1146= 0;
static oop l_1147= 0;
static oop l_1148= 0;
static oop l_1149= 0;
static oop l_1150= 0;
static oop l_1151= 0;
static oop l_1152= 0;
static oop l_1153= 0;
static oop l_1154= 0;
static oop l_1155= 0;
static oop l_1156= 0;
static oop l_1157= 0;
static oop l_1158= 0;
static oop l_1159= 0;
static oop l_1160= 0;
static oop l_1161= 0;
static oop l_1162= 0;
static oop l_1163= 0;
static oop l_1164= 0;
static oop l_1165= 0;
static oop l_1166= 0;
static oop l_1167= 0;
static oop l_1168= 0;
static oop l_1169= 0;
static oop l_1170= 0;
static oop l_1171= 0;
static oop l_1174= 0;
static oop l_1175= 0;
static oop l_1172= 0;
static oop l_1173= 0;
static oop l_1176= 0;
static oop l_1177= 0;
static oop l_1178= 0;
static oop l_1181= 0;
static oop l_1179= 0;
static oop l_1180= 0;
static oop l_1182= 0;
static oop l_1183= 0;
static oop l_1184= 0;
static oop l_1185= 0;
static oop l_1186= 0;
static oop l_1187= 0;
static oop l_1188= 0;
static oop l_1189= 0;
static oop l_1190= 0;
static oop l_1191= 0;
static oop l_1192= 0;
static oop l_1193= 0;
static oop l_1194= 0;
static oop l_1195= 0;
static oop l_1196= 0;
static oop l_1197= 0;
static oop l_1198= 0;
static oop l_1199= 0;
static oop l_1200= 0;
static oop l_1201= 0;
static oop l_1202= 0;
static oop l_1203= 0;
static oop l_1204= 0;
static oop l_1205= 0;
static oop l_1206= 0;
static oop l_1207= 0;
static oop l_1208= 0;
static oop l_1209= 0;
static oop l_1210= 0;
static oop l_1211= 0;
static oop l_1212= 0;
static oop l_1213= 0;
static oop l_1214= 0;
static oop l_1215= 0;
static oop l_1216= 0;
static oop l_1217= 0;
static oop l_1218= 0;
static oop l_1219= 0;
static oop l_1220= 0;
static oop l_1221= 0;
static oop l_1222= 0;
static oop l_1223= 0;
static oop l_1224= 0;
static oop l_1225= 0;
static oop l_1226= 0;
static oop l_1227= 0;
static oop l_1228= 0;
static oop l_1229= 0;
static oop l_1230= 0;
static oop l_1231= 0;
static oop l_1232= 0;
static oop l_1233= 0;
static oop l_1234= 0;
static oop l_1236= 0;
static oop l_1237= 0;
static oop l_1239= 0;
static oop l_1240= 0;
static oop l_1235= 0;
static oop l_1238= 0;
struct t_CompilerOutputStream
{
  vtbl_t _vtbl[0];
  oop collection;
  oop position;
  oop readLimit;
  oop writeLimit;
};

static oop l_1241= 0;
static oop l_1242= 0;
static oop l_1243= 0;
static oop l_1244= 0;
static oop l_1245= 0;
static oop l_1246= 0;
static oop l_1247= 0;
static oop l_1248= 0;
static oop c_124= 0;
static oop l_1249= 0;
static oop l_1250= 0;
static oop l_1251= 0;
static oop l_1252= 0;
static oop l_1253= 0;
static oop l_1254= 0;
static oop l_1255= 0;
static oop l_1256= 0;
static oop l_1257= 0;
static oop l_1258= 0;
static oop l_1259= 0;
static oop l_1260= 0;
static oop l_1261= 0;
static oop l_1262= 0;
static oop l_1263= 0;
static oop l_1264= 0;
static oop l_1265= 0;
static oop l_1266= 0;
static oop l_1267= 0;
static oop l_1268= 0;
static oop l_1269= 0;
static oop l_1270= 0;
static oop l_1271= 0;
struct t_ScannerContext
{
  vtbl_t _vtbl[0];
  oop name;
  oop line;
  oop input;
  oop header;
};

static oop l_1272= 0;
static oop l_1273= 0;
static oop l_1274= 0;
static oop l_1275= 0;
static oop l_1276= 0;
static oop l_1277= 0;
static oop l_1278= 0;
static oop l_1279= 0;
static oop l_1280= 0;
static oop l_1281= 0;
static oop l_1282= 0;
static oop l_1283= 0;
static oop l_1284= 0;
static oop l_1285= 0;
static oop l_1286= 0;
static oop l_1287= 0;
static oop l_1288= 0;
static oop l_1289= 0;
static oop l_1290= 0;
static oop l_1291= 0;
static oop l_1292= 0;
static oop l_1293= 0;
static oop l_1294= 0;
static oop l_1295= 0;
static oop l_1296= 0;
static oop l_1297= 0;
static oop l_1298= 0;
static oop l_1299= 0;
static oop l_1300= 0;
static oop l_1301= 0;
static oop l_1302= 0;
static oop l_1303= 0;
static oop l_1304= 0;
static oop l_1305= 0;
static oop l_1306= 0;
static oop l_1307= 0;
static oop l_1308= 0;
static oop l_1309= 0;
static oop l_1310= 0;
static oop l_1311= 0;
static oop l_1312= 0;
static oop l_1313= 0;
static oop l_1314= 0;
static oop l_1315= 0;
static oop l_1316= 0;
static oop l_1317= 0;
static oop l_1318= 0;
static oop l_1319= 0;
static oop l_1320= 0;
static oop l_1321= 0;
static oop l_1322= 0;
static oop l_1323= 0;
static oop l_1325= 0;
static oop l_1324= 0;
static oop l_1326= 0;
static oop l_1327= 0;
static oop l_1328= 0;
static oop l_1329= 0;
static oop l_1330= 0;
static oop l_1331= 0;
static oop l_1332= 0;
static oop l_1333= 0;
static oop l_1334= 0;
static oop l_1335= 0;
static oop l_1336= 0;
static oop l_1337= 0;
static oop l_1338= 0;
static oop l_1339= 0;
static oop l_1340= 0;
static oop l_1341= 0;
static oop l_1342= 0;
static oop l_1343= 0;
static oop l_1344= 0;
static oop l_1345= 0;
static oop l_1346= 0;
static oop l_1347= 0;
static oop l_1348= 0;
static oop l_1349= 0;
static oop l_1350= 0;
static oop l_1351= 0;
static oop l_1352= 0;
static oop l_1353= 0;
static oop l_1354= 0;
static oop l_1355= 0;
static oop l_1356= 0;
static oop l_1357= 0;
static oop l_1358= 0;
static oop l_1359= 0;
static oop l_1360= 0;
static oop l_1361= 0;
static oop l_1362= 0;
static oop l_1363= 0;
static oop l_1364= 0;
static oop l_1365= 0;
static oop l_1366= 0;
static oop l_1367= 0;
static oop l_1368= 0;
static oop l_1369= 0;
static oop l_1370= 0;
static oop l_1371= 0;
static oop l_1373= 0;
static oop l_1374= 0;
static oop l_1375= 0;
static oop l_1376= 0;
static oop l_1377= 0;
static oop l_1378= 0;
static oop l_1379= 0;
static oop l_1380= 0;
static oop l_1381= 0;
static oop l_1382= 0;
static oop l_1383= 0;
static oop l_1372= 0;
static oop l_1384= 0;
static oop l_1385= 0;
static oop l_1386= 0;
static oop l_1387= 0;
static oop l_1388= 0;
static oop l_1389= 0;
static oop l_1390= 0;
static oop l_1391= 0;
static oop l_1392= 0;
static oop l_1393= 0;
static oop l_1394= 0;
static oop l_1395= 0;
static oop l_1396= 0;
static oop l_1397= 0;
static oop *_l_1397[3]= {
  &l_1394,
  &l_1395,
  &l_1396,
};
static oop l_1399= 0;
static oop l_1400= 0;
static oop l_1401= 0;
static oop l_1398= 0;
static oop l_1402= 0;
static oop l_1403= 0;
static oop l_1404= 0;
static oop l_1405= 0;
static oop l_1406= 0;
static oop l_1407= 0;
static oop l_1408= 0;
static oop l_1409= 0;
static oop l_1410= 0;
static oop l_1411= 0;
static oop l_1412= 0;
static oop l_1413= 0;
static oop l_1414= 0;
static oop l_1415= 0;
static oop l_1416= 0;
static oop *_l_1416[4]= {
  &l_1412,
  &l_1413,
  &l_1414,
  &l_1415,
};
static oop l_1418= 0;
static oop l_1419= 0;
static oop l_1420= 0;
static oop l_1421= 0;
static oop l_1422= 0;
static oop l_1417= 0;
static oop l_1423= 0;
static oop l_1424= 0;
static oop l_1425= 0;
static oop l_1428= 0;
static oop l_1429= 0;
static oop l_1430= 0;
static oop l_1431= 0;
static oop l_1432= 0;
static oop l_1426= 0;
static oop l_1427= 0;
static oop l_1433= 0;
static oop l_1434= 0;
static oop l_1435= 0;
static oop l_1436= 0;
static oop l_1437= 0;
static oop l_1438= 0;
static oop l_1439= 0;
static oop l_1440= 0;
static oop l_1441= 0;
static oop l_1442= 0;
static oop l_1443= 0;
static oop l_1444= 0;
static oop l_1445= 0;
static oop l_1446= 0;
static oop l_1447= 0;
static oop l_1448= 0;
static oop l_1449= 0;
static oop l_1450= 0;
static oop l_1451= 0;
static oop l_1452= 0;
static oop l_1453= 0;
static oop l_1454= 0;
static oop l_1455= 0;
static oop l_1456= 0;
static oop l_1457= 0;
static oop l_1458= 0;
static oop l_1459= 0;
static oop l_1460= 0;
static oop l_1461= 0;
static oop l_1462= 0;
static oop l_1463= 0;
static oop l_1464= 0;
static oop l_1465= 0;
static oop l_1466= 0;
static oop l_1467= 0;
static oop l_1468= 0;
static oop l_1469= 0;
static oop l_1470= 0;
static oop l_1471= 0;
static oop l_1472= 0;
static oop l_1473= 0;
static oop l_1474= 0;
static oop l_1475= 0;
static oop l_1476= 0;
static oop l_1477= 0;
static oop l_1478= 0;
static oop l_1479= 0;
static oop l_1480= 0;
static oop l_1481= 0;
static oop l_1482= 0;
static oop l_1483= 0;
static oop l_1484= 0;
static oop l_1485= 0;
static oop l_1486= 0;
static oop l_1487= 0;
static oop l_1488= 0;
static oop l_1489= 0;
static oop l_1490= 0;
static oop l_1491= 0;
static oop l_1492= 0;
static oop l_1493= 0;
static oop l_1494= 0;
static oop l_1495= 0;
static oop l_1496= 0;
static oop l_1497= 0;
static oop l_1498= 0;
static oop l_1499= 0;
static oop l_1500= 0;
static oop l_1501= 0;
static oop l_1502= 0;
static oop l_1503= 0;
static oop l_1504= 0;
static oop l_1505= 0;
static oop l_1506= 0;
static oop l_1507= 0;
static oop l_1508= 0;
static oop l_1509= 0;
static oop l_1510= 0;
static oop l_1511= 0;
static oop l_1512= 0;
static oop l_1513= 0;
static oop l_1514= 0;
static oop l_1515= 0;
static oop l_1516= 0;
static oop l_1517= 0;
static oop l_1518= 0;
static oop l_1519= 0;
static oop l_1520= 0;
static oop l_1523= 0;
static oop l_1521= 0;
static oop l_1522= 0;
static oop l_1524= 0;
static oop l_1525= 0;
static oop l_1526= 0;
static oop l_1527= 0;
static oop l_1530= 0;
static oop l_1531= 0;
static oop l_1532= 0;
static oop l_1533= 0;
static oop l_1535= 0;
static oop l_1536= 0;
static oop l_1537= 0;
static oop l_1538= 0;
static oop l_1539= 0;
static oop l_1540= 0;
static oop l_1541= 0;
static oop l_1528= 0;
static oop l_1529= 0;
static oop l_1534= 0;
static oop l_1542= 0;
static oop l_1543= 0;
static oop l_1544= 0;
static oop l_1545= 0;
static oop l_1546= 0;
static oop l_1548= 0;
static oop l_1549= 0;
static oop l_1550= 0;
static oop l_1551= 0;
static oop l_1552= 0;
static oop l_1547= 0;
static oop v_Array= 0;
static oop v_ArrayNode= 0;
static oop v_ArrayedCollection= 0;
static oop v_AssignmentNode= 0;
static oop v_Association= 0;
static oop v_BlockClosure= 0;
static oop v_BlockClosureNLR= 0;
static oop v_BlockNode= 0;
static oop v_BlockNodeTag= 0;
static oop v_BlockReturnNode= 0;
static oop v_ByteArray= 0;
static oop v_ByteArrayNode= 0;
static oop v_Character= 0;
static oop v_CharacterArray= 0;
static oop v_CharacterNode= 0;
static oop v_ClassNode= 0;
static oop v_Collection= 0;
static oop v_Compiler= 0;
static oop v_CompilerOptions= 0;
static oop v_CompilerOutputStream= 0;
static oop v_Dictionary= 0;
static oop v_ExecNode= 0;
static oop v_ExportNode= 0;
static oop v_ExternDeclarationNode= 0;
static oop v_ExternalClassNode= 0;
static oop v_GetOpt= 0;
static oop v_GlobalVariable= 0;
static oop v_IdentityDictionary= 0;
static oop v_IdentitySet= 0;
static oop v_ImmutableArray= 0;
static oop v_ImmutableByteArray= 0;
static oop v_ImmutableString= 0;
static oop v_ImmutableWordArray= 0;
static oop v_ImportNode= 0;
static oop v_IncludeNode= 0;
static oop v_Integer= 0;
static oop v_IntegerNode= 0;
static oop v_LiteralNode= 0;
static oop v_LiteralNodeTag= 0;
static oop v_LocalVariable= 0;
static oop v_MacroEncoders= 0;
static oop v_Magnitude= 0;
static oop v_MethodNode= 0;
static oop v_NamedVariable= 0;
static oop v_Number= 0;
static oop v_Object= 0;
static oop v_OrderedCollection= 0;
static oop v_ParseNode= 0;
static oop v_Parser= 0;
static oop v_PositionableStream= 0;
static oop v_PrimitiveNode= 0;
static oop v_ReadStream= 0;
static oop v_ReceiverVariable= 0;
static oop v_RemoteReceiverVariable= 0;
static oop v_RemoteVariable= 0;
static oop v_RequireNode= 0;
static oop v_ReturnNode= 0;
static oop v_Scanner= 0;
static oop v_ScannerContext= 0;
static oop v_Scope= 0;
static oop v_SelectorTable= 0;
static oop v_SelfVariable= 0;
static oop v_SendNode= 0;
static oop v_SequenceNode= 0;
static oop v_SequenceableCollection= 0;
static oop v_Set= 0;
static oop v_SmallInteger= 0;
static oop v_Smalltalk= 0;
static oop v_SortedCollection= 0;
static oop v_StaticBlock= 0;
static oop v_Stream= 0;
static oop v_String= 0;
static oop v_StringNode= 0;
static oop v_Symbol= 0;
static oop v_SymbolNode= 0;
static oop v_SymbolTable= 0;
static oop v_TemplateNode= 0;
static oop v_TranslationUnit= 0;
static oop v_UndefinedObject= 0;
static oop v_ValueNode= 0;
static oop v_Variable= 0;
static oop v_VariableNode= 0;
static oop v_WordArray= 0;
static oop v_WordArrayNode= 0;
static oop v_WriteStream= 0;
static oop v__binding= 0;
static oop v__object= 0;
static oop v__selector= 0;
static oop v__vtbl= 0;
static oop v_false= 0;
static oop v_nil= 0;
static oop v_true= 0;
static sel_t s__2a= 0;
static sel_t s__2b= 0;
static sel_t s__2c= 0;
static sel_t s__2d= 0;
static sel_t s__2f_2f= 0;
static sel_t s__3c= 0;
static sel_t s__3c_3d= 0;
static sel_t s__3d= 0;
static sel_t s__3d_3d= 0;
static sel_t s__3e= 0;
static sel_t s__3e_3d= 0;
static sel_t s__5c_5c= 0;
static sel_t s__5fbeNilType= 0;
static sel_t s__5fbeTaggedType= 0;
static sel_t s__5fcString= 0;
static sel_t s__5fclone= 0;
static sel_t s__5fclone_= 0;
static sel_t s__5fdebugName= 0;
static sel_t s__5fdelegated= 0;
static sel_t s__5felements= 0;
static sel_t s__5fentry__5farity_= 0;
static sel_t s__5fentry__5farity_receiver_state_envp_= 0;
static sel_t s__5fentry__5farity_receiver_state_outer_= 0;
static sel_t s__5ferror_= 0;
static sel_t s__5fidentityHash= 0;
static sel_t s__5fintegerValue= 0;
static sel_t s__5fintern_= 0;
static sel_t s__5fmemcmp_with_length_= 0;
static sel_t s__5fmethod= 0;
static sel_t s__5fmethodAt_put_= 0;
static sel_t s__5fmethod_= 0;
static sel_t s__5fnewPointers_= 0;
static sel_t s__5fosErrorString_= 0;
static sel_t s__5fperform_= 0;
static sel_t s__5fperform_with_= 0;
static sel_t s__5frealloc_size_= 0;
static sel_t s__5fsize_value_= 0;
static sel_t s__5fsizeof= 0;
static sel_t s__5fstringValue= 0;
static sel_t s__5fvalue_= 0;
static sel_t s__5fvtbl= 0;
static sel_t s__5fvtbl_= 0;
static sel_t s__7e_3d= 0;
static sel_t s__7e_7e= 0;
static sel_t s_abort= 0;
static sel_t s_absolutePathName= 0;
static sel_t s_addAll_= 0;
static sel_t s_addArgument_= 0;
static sel_t s_addBlock_= 0;
static sel_t s_addCascade_= 0;
static sel_t s_addFirst_= 0;
static sel_t s_addKeyword_= 0;
static sel_t s_addLast_= 0;
static sel_t s_addNode_extern_= 0;
static sel_t s_addStatement_= 0;
static sel_t s_addTemporary_= 0;
static sel_t s_add_= 0;
static sel_t s_allocate_= 0;
static sel_t s_and_= 0;
static sel_t s_applyOption_to_= 0;
static sel_t s_applyOption_to_with_= 0;
static sel_t s_argumentAt_= 0;
static sel_t s_argumentCount= 0;
static sel_t s_arguments= 0;
static sel_t s_arity= 0;
static sel_t s_asArray= 0;
static sel_t s_asByteArray= 0;
static sel_t s_asInteger= 0;
static sel_t s_asSortedCollection= 0;
static sel_t s_asSortedCollection_= 0;
static sel_t s_asString= 0;
static sel_t s_asSymbol= 0;
static sel_t s_asciiValue= 0;
static sel_t s_asciiValue_= 0;
static sel_t s_assert= 0;
static sel_t s_assert_= 0;
static sel_t s_associationsDo_= 0;
static sel_t s_atAllPut_= 0;
static sel_t s_atAll_put_= 0;
static sel_t s_atEnd= 0;
static sel_t s_atNewIndex_put_= 0;
static sel_t s_at_= 0;
static sel_t s_at_ifAbsent_= 0;
static sel_t s_at_put_= 0;
static sel_t s_base= 0;
static sel_t s_baseName= 0;
static sel_t s_basicValue_= 0;
static sel_t s_beNilType= 0;
static sel_t s_beSelf= 0;
static sel_t s_beTaggedType= 0;
static sel_t s_beVariadic= 0;
static sel_t s_beginsWith_= 0;
static sel_t s_between_and_= 0;
static sel_t s_bindingAt_= 0;
static sel_t s_bindingAt_put_= 0;
static sel_t s_bitAnd_= 0;
static sel_t s_bitOr_= 0;
static sel_t s_bitXor_= 0;
static sel_t s_byteAt_= 0;
static sel_t s_byteAt_put_= 0;
static sel_t s_bytesFree= 0;
static sel_t s_cannotReturn_= 0;
static sel_t s_cascade= 0;
static sel_t s_class= 0;
static sel_t s_collect_= 0;
static sel_t s_collection= 0;
static sel_t s_compare_= 0;
static sel_t s_compile_from_to_withOptions_= 0;
static sel_t s_contents= 0;
static sel_t s_copyFrom_= 0;
static sel_t s_copyFrom_to_= 0;
static sel_t s_cr= 0;
static sel_t s_cr_= 0;
static sel_t s_debugName= 0;
static sel_t s_declareClass_= 0;
static sel_t s_declareGlobal_= 0;
static sel_t s_declareIn_= 0;
static sel_t s_declareLiteral_= 0;
static sel_t s_declareLocal_= 0;
static sel_t s_declareSelector_= 0;
static sel_t s_declareState_= 0;
static sel_t s_declare_as_= 0;
static sel_t s_default_= 0;
static sel_t s_delegate= 0;
static sel_t s_delegate_= 0;
static sel_t s_delegated= 0;
static sel_t s_delimited_= 0;
static sel_t s_digitValue= 0;
static sel_t s_digitValue_= 0;
static sel_t s_directoryName= 0;
static sel_t s_doWithIndex_= 0;
static sel_t s_do_= 0;
static sel_t s_emptyCheck= 0;
static sel_t s_encodeAdd_= 0;
static sel_t s_encodeAnd_= 0;
static sel_t s_encodeBinary_= 0;
static sel_t s_encodeBitAnd_= 0;
static sel_t s_encodeBitOr_= 0;
static sel_t s_encodeBitXor_= 0;
static sel_t s_encodeBlock_= 0;
static sel_t s_encodeCascade_location_= 0;
static sel_t s_encodeDiv_= 0;
static sel_t s_encodeEQ_= 0;
static sel_t s_encodeGE_= 0;
static sel_t s_encodeGT_= 0;
static sel_t s_encodeID_= 0;
static sel_t s_encodeIfFalseIfTrue_= 0;
static sel_t s_encodeIfFalse_= 0;
static sel_t s_encodeIfTrueIfFalse_= 0;
static sel_t s_encodeIfTrue_= 0;
static sel_t s_encodeIn_= 0;
static sel_t s_encodeLE_= 0;
static sel_t s_encodeLT_= 0;
static sel_t s_encodeLvalue_= 0;
static sel_t s_encodeMacro_= 0;
static sel_t s_encodeMod_= 0;
static sel_t s_encodeMul_= 0;
static sel_t s_encodeNE_= 0;
static sel_t s_encodeNI_= 0;
static sel_t s_encodeOpen_= 0;
static sel_t s_encodeOr_= 0;
static sel_t s_encodeSequence_= 0;
static sel_t s_encodeSub_= 0;
static sel_t s_encodeValue_= 0;
static sel_t s_encodeWhileFalseArg_= 0;
static sel_t s_encodeWhileFalse_= 0;
static sel_t s_encodeWhileTrueArg_= 0;
static sel_t s_encodeWhileTrue_= 0;
static sel_t s_encode_= 0;
static sel_t s_ensureReturn= 0;
static sel_t s_errorCannotModify= 0;
static sel_t s_errorEmptyCollection= 0;
static sel_t s_errorImproperStore_= 0;
static sel_t s_errorKeyNotFound= 0;
static sel_t s_errorNonIntegerIndex_= 0;
static sel_t s_errorSubscriptBounds_= 0;
static sel_t s_error_= 0;
static sel_t s_exportFrom_= 0;
static sel_t s_exportNLR= 0;
static sel_t s_exportOuter= 0;
static sel_t s_exportSelf= 0;
static sel_t s_exportedTo_= 0;
static sel_t s_exports= 0;
static sel_t s_external_= 0;
static sel_t s_ff= 0;
static sel_t s_findElementOrNil_= 0;
static sel_t s_findFile_= 0;
static sel_t s_first= 0;
static sel_t s_firstToken_= 0;
static sel_t s_flattened= 0;
static sel_t s_flushCache= 0;
static sel_t s_forGobble_= 0;
static sel_t s_forTopLevel_= 0;
static sel_t s_freeTemp= 0;
static sel_t s_freeTemps_= 0;
static sel_t s_fromString_= 0;
static sel_t s_fullCheck= 0;
static sel_t s_garbageCollect= 0;
static sel_t s_genAdd_= 0;
static sel_t s_genAnd_= 0;
static sel_t s_genBitAnd_= 0;
static sel_t s_genBitOr_= 0;
static sel_t s_genBitXor_= 0;
static sel_t s_genByte_= 0;
static sel_t s_genCascade_= 0;
static sel_t s_genDeclarationIn_= 0;
static sel_t s_genDefinition_= 0;
static sel_t s_genDefinitions= 0;
static sel_t s_genDefinitions_= 0;
static sel_t s_genDiv_= 0;
static sel_t s_genEQ_= 0;
static sel_t s_genFull_= 0;
static sel_t s_genGE_= 0;
static sel_t s_genGT_= 0;
static sel_t s_genID_= 0;
static sel_t s_genIfFalse_= 0;
static sel_t s_genIfTrueIfFalse_= 0;
static sel_t s_genIfTrue_= 0;
static sel_t s_genImplementationIn_= 0;
static sel_t s_genImplementation_= 0;
static sel_t s_genImplementations_= 0;
static sel_t s_genInitialisationIn_= 0;
static sel_t s_genInitialisation_= 0;
static sel_t s_genInitialisations= 0;
static sel_t s_genInitialisations_= 0;
static sel_t s_genLE_= 0;
static sel_t s_genLT_= 0;
static sel_t s_genLvalue_= 0;
static sel_t s_genMod_= 0;
static sel_t s_genMul_= 0;
static sel_t s_genNE_= 0;
static sel_t s_genNI_= 0;
static sel_t s_genNLR_= 0;
static sel_t s_genOr_= 0;
static sel_t s_genSequence_= 0;
static sel_t s_genStatic_= 0;
static sel_t s_genSub_= 0;
static sel_t s_genWhileFalseArg_= 0;
static sel_t s_genWhileFalse_= 0;
static sel_t s_genWhileTrueArg_= 0;
static sel_t s_genWhileTrue_= 0;
static sel_t s_genWord_= 0;
static sel_t s_gen_= 0;
static sel_t s_gobble_= 0;
static sel_t s_grow= 0;
static sel_t s_growSize= 0;
static sel_t s_hash= 0;
static sel_t s_header= 0;
static sel_t s_hex2= 0;
static sel_t s_hex8= 0;
static sel_t s_identityHash= 0;
static sel_t s_ifFalse_= 0;
static sel_t s_ifTrue_= 0;
static sel_t s_ifTrue_ifFalse_= 0;
static sel_t s_include_= 0;
static sel_t s_includesKey_= 0;
static sel_t s_includes_= 0;
static sel_t s_indexForInserting_= 0;
static sel_t s_initialise= 0;
static sel_t s_inject_into_= 0;
static sel_t s_innerScopeFor_= 0;
static sel_t s_input= 0;
static sel_t s_insert_before_= 0;
static sel_t s_intern_= 0;
static sel_t s_isBlockNode= 0;
static sel_t s_isByteArray= 0;
static sel_t s_isClassNode= 0;
static sel_t s_isDigit= 0;
static sel_t s_isEmpty= 0;
static sel_t s_isExported= 0;
static sel_t s_isExternDeclarationNode= 0;
static sel_t s_isExternDeclatationNode= 0;
static sel_t s_isInteger= 0;
static sel_t s_isKindOf_= 0;
static sel_t s_isLetter= 0;
static sel_t s_isMemberOf_= 0;
static sel_t s_isMethod= 0;
static sel_t s_isNamedVariable= 0;
static sel_t s_isNil= 0;
static sel_t s_isOpenBlock= 0;
static sel_t s_isPrimitiveNode= 0;
static sel_t s_isReadableFile= 0;
static sel_t s_isRemoteVariable= 0;
static sel_t s_isReturnNode= 0;
static sel_t s_isSendNode= 0;
static sel_t s_isSmallInteger= 0;
static sel_t s_isStatic= 0;
static sel_t s_isString= 0;
static sel_t s_isVariableNode= 0;
static sel_t s_is_5fselector= 0;
static sel_t s_key= 0;
static sel_t s_key_= 0;
static sel_t s_key_value_= 0;
static sel_t s_keys= 0;
static sel_t s_keysAndSortedValuesDo_= 0;
static sel_t s_keysAndValuesDo_= 0;
static sel_t s_keysDo_= 0;
static sel_t s_last= 0;
static sel_t s_lastStatement= 0;
static sel_t s_level= 0;
static sel_t s_level_offset_= 0;
static sel_t s_like_= 0;
static sel_t s_line= 0;
static sel_t s_list= 0;
static sel_t s_list_= 0;
static sel_t s_literalClass= 0;
static sel_t s_literalSelector= 0;
static sel_t s_location= 0;
static sel_t s_lookupClass_= 0;
static sel_t s_lookupClass_ifAbsent_= 0;
static sel_t s_lookupFree_= 0;
static sel_t s_lookupSelector_= 0;
static sel_t s_lookup_= 0;
static sel_t s_lookup_ifAbsent_= 0;
static sel_t s_mainFlag= 0;
static sel_t s_mainFlag_= 0;
static sel_t s_makeRoomAtFirst= 0;
static sel_t s_makeRoomAtLast= 0;
static sel_t s_mangleSelector_= 0;
static sel_t s_mangleSlot_= 0;
static sel_t s_mangleVariable_= 0;
static sel_t s_mangledName= 0;
static sel_t s_max_= 0;
static sel_t s_min_= 0;
static sel_t s_min_max_= 0;
static sel_t s_name= 0;
static sel_t s_negated= 0;
static sel_t s_new= 0;
static sel_t s_newSelector_method_= 0;
static sel_t s_newTemp= 0;
static sel_t s_new_= 0;
static sel_t s_newln= 0;
static sel_t s_next= 0;
static sel_t s_nextExportOffset= 0;
static sel_t s_nextPutAll_= 0;
static sel_t s_nextPut_= 0;
static sel_t s_next_= 0;
static sel_t s_nl= 0;
static sel_t s_nl_= 0;
static sel_t s_noCheckAdd_= 0;
static sel_t s_not= 0;
static sel_t s_notEmpty= 0;
static sel_t s_notImplemented_= 0;
static sel_t s_notNil= 0;
static sel_t s_noteExportNLR= 0;
static sel_t s_noteExportOuter= 0;
static sel_t s_noteExportSelf= 0;
static sel_t s_note_= 0;
static sel_t s_octal3= 0;
static sel_t s_offset= 0;
static sel_t s_on_= 0;
static sel_t s_or_= 0;
static sel_t s_osError= 0;
static sel_t s_osErrorString= 0;
static sel_t s_osErrorString_= 0;
static sel_t s_outputStream= 0;
static sel_t s_parent= 0;
static sel_t s_parse= 0;
static sel_t s_parseArgument_with_= 0;
static sel_t s_parseArray= 0;
static sel_t s_parseArrayLiteral= 0;
static sel_t s_parseBinary= 0;
static sel_t s_parseBlock= 0;
static sel_t s_parseBlockParameters_= 0;
static sel_t s_parseByteArray= 0;
static sel_t s_parseClass_= 0;
static sel_t s_parseDeclaration= 0;
static sel_t s_parseExec= 0;
static sel_t s_parseExpression= 0;
static sel_t s_parseExtern= 0;
static sel_t s_parseLiteralP= 0;
static sel_t s_parseMethod_= 0;
static sel_t s_parseOption_with_= 0;
static sel_t s_parsePrimary= 0;
static sel_t s_parseSequence_= 0;
static sel_t s_parseTemporaries_= 0;
static sel_t s_parseUnary= 0;
static sel_t s_parseWordArray= 0;
static sel_t s_parse_= 0;
static sel_t s_parse_startingAt_= 0;
static sel_t s_pastEndPut_= 0;
static sel_t s_peek= 0;
static sel_t s_perform_= 0;
static sel_t s_perform_with_= 0;
static sel_t s_positionError= 0;
static sel_t s_position_= 0;
static sel_t s_primitiveFailed= 0;
static sel_t s_print= 0;
static sel_t s_printDigitOn_= 0;
static sel_t s_printElementsOn_= 0;
static sel_t s_printNameOn_= 0;
static sel_t s_printOn_= 0;
static sel_t s_printOn_indent_= 0;
static sel_t s_printString= 0;
static sel_t s_print_= 0;
static sel_t s_println= 0;
static sel_t s_quit= 0;
static sel_t s_reSort= 0;
static sel_t s_readFromFileNamed_= 0;
static sel_t s_readFromFileNamed_ifError_= 0;
static sel_t s_readFrom_base_= 0;
static sel_t s_readStream= 0;
static sel_t s_refute= 0;
static sel_t s_refute_= 0;
static sel_t s_removeFirst= 0;
static sel_t s_removeLast= 0;
static sel_t s_repeat= 0;
static sel_t s_replaceFrom_to_with_startingAt_= 0;
static sel_t s_reset= 0;
static sel_t s_resetTemps= 0;
static sel_t s_resetToStart= 0;
static sel_t s_return_= 0;
static sel_t s_scan= 0;
static sel_t s_scanCharacter= 0;
static sel_t s_scanEscape= 0;
static sel_t s_scanFor_= 0;
static sel_t s_scanKeywords= 0;
static sel_t s_scanOctal= 0;
static sel_t s_searchPaths= 0;
static sel_t s_second= 0;
static sel_t s_selector= 0;
static sel_t s_setCollection_= 0;
static sel_t s_shouldNotImplement= 0;
static sel_t s_size= 0;
static sel_t s_sizeof= 0;
static sel_t s_skip_= 0;
static sel_t s_slots= 0;
static sel_t s_sortBlock_= 0;
static sel_t s_space= 0;
static sel_t s_space_= 0;
static sel_t s_species= 0;
static sel_t s_string_= 0;
static sel_t s_subclassResponsibility= 0;
static sel_t s_subclassResponsibility_= 0;
static sel_t s_supered_= 0;
static sel_t s_tab= 0;
static sel_t s_tab_= 0;
static sel_t s_tag= 0;
static sel_t s_tempCount= 0;
static sel_t s_third= 0;
static sel_t s_timesRepeat_= 0;
static sel_t s_to_do_= 0;
static sel_t s_tokenised_= 0;
static sel_t s_typeName= 0;
static sel_t s_value= 0;
static sel_t s_value_= 0;
static sel_t s_value_value_= 0;
static sel_t s_warnBlockReceiver= 0;
static sel_t s_whileFalse_= 0;
static sel_t s_whileTrue_= 0;
static sel_t s_withClass_selector_arguments_= 0;
static sel_t s_withCode_= 0;
static sel_t s_withElements_= 0;
static sel_t s_withName_= 0;
static sel_t s_withName_base_slots_= 0;
static sel_t s_withName_line_input_header_= 0;
static sel_t s_withName_mangledName_= 0;
static sel_t s_withName_mangledName_class_= 0;
static sel_t s_withName_mangledName_level_= 0;
static sel_t s_withNames_= 0;
static sel_t s_withParent_block_= 0;
static sel_t s_withReceiver_selector_= 0;
static sel_t s_withStatement_= 0;
static sel_t s_withText_= 0;
static sel_t s_withValue_= 0;
static sel_t s_withVariable_= 0;
static sel_t s_withVariable_value_= 0;
static sel_t s_with_= 0;
static sel_t s_with_do_= 0;
static sel_t s_wordAt_= 0;
static sel_t s_wordAt_put_= 0;
static sel_t s_writeStream= 0;
static sel_t s_writeToFileNamed_= 0;
static sel_t s_writeToFileNamed_ifError_= 0;
static sel_t s_xBinary= 0;
static sel_t s_xBrace= 0;
static sel_t s_xCharacter= 0;
static sel_t s_xColon= 0;
static sel_t s_xComment= 0;
static sel_t s_xDigit= 0;
static sel_t s_xDot= 0;
static sel_t s_xIllegal= 0;
static sel_t s_xLetter= 0;
static sel_t s_xPunctuator= 0;
static sel_t s_xSign= 0;
static sel_t s_xString= 0;
static sel_t s_yourself= 0;

static int   Object__5fsizeof(oop self) { return sizeof(struct t_Object); }
static char *Object__5fdebugName(oop self) { return "Object"; }

static int   UndefinedObject__5fsizeof(oop self) { return sizeof(struct t_UndefinedObject); }
static char *UndefinedObject__5fdebugName(oop self) { return "UndefinedObject"; }

static int   StaticBlock__5fsizeof(oop self) { return sizeof(struct t_StaticBlock); }
static char *StaticBlock__5fdebugName(oop self) { return "StaticBlock"; }

static int   BlockClosure__5fsizeof(oop self) { return sizeof(struct t_BlockClosure); }
static char *BlockClosure__5fdebugName(oop self) { return "BlockClosure"; }

static int   BlockClosureNLR__5fsizeof(oop self) { return sizeof(struct t_BlockClosureNLR); }
static char *BlockClosureNLR__5fdebugName(oop self) { return "BlockClosureNLR"; }

static int   Magnitude__5fsizeof(oop self) { return sizeof(struct t_Magnitude); }
static char *Magnitude__5fdebugName(oop self) { return "Magnitude"; }

static int   Number__5fsizeof(oop self) { return sizeof(struct t_Number); }
static char *Number__5fdebugName(oop self) { return "Number"; }

static int   Integer__5fsizeof(oop self) { return sizeof(struct t_Integer); }
static char *Integer__5fdebugName(oop self) { return "Integer"; }

static int   SmallInteger__5fsizeof(oop self) { return sizeof(struct t_SmallInteger); }
static char *SmallInteger__5fdebugName(oop self) { return "SmallInteger"; }

static int   Collection__5fsizeof(oop self) { return sizeof(struct t_Collection); }
static char *Collection__5fdebugName(oop self) { return "Collection"; }

static int   SequenceableCollection__5fsizeof(oop self) { return sizeof(struct t_SequenceableCollection); }
static char *SequenceableCollection__5fdebugName(oop self) { return "SequenceableCollection"; }

static int   ArrayedCollection__5fsizeof(oop self) { return sizeof(struct t_ArrayedCollection); }
static char *ArrayedCollection__5fdebugName(oop self) { return "ArrayedCollection"; }

static int   Array__5fsizeof(oop self) { return sizeof(struct t_Array); }
static char *Array__5fdebugName(oop self) { return "Array"; }

static int   ImmutableArray__5fsizeof(oop self) { return sizeof(struct t_ImmutableArray); }
static char *ImmutableArray__5fdebugName(oop self) { return "ImmutableArray"; }

static int   ByteArray__5fsizeof(oop self) { return sizeof(struct t_ByteArray); }
static char *ByteArray__5fdebugName(oop self) { return "ByteArray"; }

static int   ImmutableByteArray__5fsizeof(oop self) { return sizeof(struct t_ImmutableByteArray); }
static char *ImmutableByteArray__5fdebugName(oop self) { return "ImmutableByteArray"; }

static int   String__5fsizeof(oop self) { return sizeof(struct t_String); }
static char *String__5fdebugName(oop self) { return "String"; }

static int   ImmutableString__5fsizeof(oop self) { return sizeof(struct t_ImmutableString); }
static char *ImmutableString__5fdebugName(oop self) { return "ImmutableString"; }

static oop Object__s__5fclone_(oop self, oop v__size)
{
 {
  oop _1;
   return _clone(self, (long)v__size) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s__5fclone(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= self;
  _2= _bind(_2, s__5fsizeof)(_2);
  _1= _bind(_1, s__5fclone_)(_1, _2);
  return _1;
 }
}

static oop SmallInteger__s__5fvalue_(oop self, oop v__value)
{
 {
  oop _1;
   return _integerObject((long)v__value); 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop SmallInteger__s__5fintegerValue(oop self)
{
 {
  oop _1;
   return (oop)_integerValue(self); 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop String__s__5fvalue_(oop self, oop v__value)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  {
      struct t_String *this= (struct t_String *)self;
      long size= strlen((char *)v__value);
      this->size= _integerObject(size);
      this->_elements= _newBytes(size);
      memcpy(this->_elements, v__value, size);
    }
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop String__s__5fstringValue(oop self)
{
 {
  oop _1;
  
  return ((struct t_String *)self)->_elements;

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop String__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t_ArrayedCollection *)self)->size;
  return _1;
 }
}

static oop Object__s_newln(oop self)
{
 {
  oop _1;
   printf("\n");  fflush(stdout);  fflush(stderr);  return 0; 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s_println(oop self)
{
 {
  oop _1;
  _1= self;
  _bind(_1, s_print)(_1);
  _1= _bind(_1, s_newln)(_1);
  _1= self;
  return _1;
 }
}

static oop Object__s_print(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_debugName)(_1);
  _1= _bind(_1, s_print)(_1);
  _1= self;
  return _1;
 }
}

static oop Object__s_debugName(oop self)
{
 {
  oop _1, _2;
  _1= v_String;
  _2= self;
  _2= _bind(_2, s__5fdebugName)(_2);
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop UndefinedObject__s__5fdebugName(oop self)
{
 {
  oop _1;
   return (oop)"nil"; 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop SmallInteger__s_print(oop self)
{
 {
  oop _1;
   printf("%ld", (long)self >> 1);  return 0; 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop String__s_print(oop self)
{
 {
  oop _1;
  
  struct t_String *this= (struct t_String *)self;
  long size= _integerValue(this->size);
  char *elements= (char *)this->_elements;
  int i;
  for (i= 0;  i < size;  ++i)
    if (isprint(elements[i]) || ('\n' == elements[i]) || ('\t' == elements[i]))
      putchar(elements[i]);
    else
      printf("\\%03o", elements[i]);
  return 0;

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static int   _object__5fsizeof(oop self) { return sizeof(struct t__object); }
static char *_object__5fdebugName(oop self) { return "_object"; }

static oop _object__s__5fdebugName(oop self)
{
 {
  oop _1;
   return (oop)"_object" 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fsizeof(oop self)
{
 {
  oop _1;
   return (oop)sizeof(struct t__object) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fvtbl(oop self)
{
 {
  oop _1;
   return (oop)(self->_vtbl[-1]) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fvtbl_(oop self, oop v_vt)
{
 {
  oop _1;
   return (oop)(self->_vtbl[-1]= (vtbl_t)v_vt) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static int   _vtbl__5fsizeof(oop self) { return sizeof(struct t__vtbl); }
static char *_vtbl__5fdebugName(oop self) { return "_vtbl"; }

static oop _vtbl__s__5fdebugName(oop self)
{
 {
  oop _1;
   return (oop)"_vtbl" 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s__5fsizeof(oop self)
{
 {
  oop _1;
   return (oop)sizeof(struct t__vtbl) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_delegate(oop self)
{
 {
  oop _1;
  _1= ((struct t__vtbl *)self)->delegate;
  return _1;
 }
}

static oop _vtbl__s_delegate_(oop self, oop v_vtbl)
{
 {
  oop _1;
  _1= v_vtbl;
  ((struct t__vtbl *)self)->delegate= _1;
  return _1;
 }
}

static oop _vtbl__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t__vtbl *)self)->size;
  return _1;
 }
}

static oop _vtbl__s_bindingAt_(oop self, oop v_index)
{
 {
  oop _1;
  
      struct t__vtbl *this= (struct t__vtbl *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return ((oop *)(this->_bindings))[_integerValue(v_index)];
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop _vtbl__s_bindingAt_put_(oop self, oop v_index, oop v_aBinding)
{
 {
  oop _1;
  
      struct t__vtbl *this= (struct t__vtbl *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return ((oop *)(this->_bindings))[_integerValue(v_index)]= v_aBinding;
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static int   _binding__5fsizeof(oop self) { return sizeof(struct t__binding); }
static char *_binding__5fdebugName(oop self) { return "_binding"; }

static oop _binding__s__5fdebugName(oop self)
{
 {
  oop _1;
   return (oop)"_binding" 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _binding__s__5fsizeof(oop self)
{
 {
  oop _1;
   return (oop)sizeof(struct t__binding) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _binding__s_selector(oop self)
{
 {
  oop _1;
  _1= ((struct t__binding *)self)->selector;
  return _1;
 }
}

static oop _binding__s__5fmethod(oop self)
{
 {
  oop _1;
  _1= ((struct t__binding *)self)->_method;
  return _1;
 }
}

static oop _binding__s__5fmethod_(oop self, oop v__meth)
{
 {
  oop _1;
  _1= v__meth;
  ((struct t__binding *)self)->_method= _1;
  return _1;
 }
}

static int   _selector__5fsizeof(oop self) { return sizeof(struct t__selector); }
static char *_selector__5fdebugName(oop self) { return "_selector"; }

static oop _selector__s__5fdebugName(oop self)
{
 {
  oop _1;
   return (oop)"_selector" 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s__5fsizeof(oop self)
{
 {
  oop _1;
   return (oop)sizeof(struct t__selector) 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t__selector *)self)->size;
  return _1;
 }
}

static oop _selector__s_name(oop self)
{
 {
  oop _1, _2;
  _1= v_String;
  _2= ((struct t__selector *)self)->_name;
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop _selector__s_next(oop self)
{
 {
  oop _1;
  _1= ((struct t__selector *)self)->next;
  return _1;
 }
}

static oop _selector__s_next_(oop self, oop v_sel)
{
 {
  oop _1;
  _1= v_sel;
  ((struct t__selector *)self)->next= _1;
  return _1;
 }
}

static oop _object__s_sizeof(oop self)
{
 {
  oop _1, _2;
  _1= v_SmallInteger;
  _2= self;
  _2= _bind(_2, s__5fsizeof)(_2);
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop _object__s__5fnewPointers_(oop self, oop v_size)
{
 {
  oop _1;
  
  return _newPointers(_integerValue(v_size));

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fclone_(oop self, oop v__size)
{
 {
  oop _1;
  
  vtbl_t *clone= (vtbl_t *)_newPointers(sizeof(vtbl_t) + (long)v__size);
  *clone= self->_vtbl[-1];
  return (oop)(clone + 1);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fclone(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= self;
  _2= _bind(_2, s__5fsizeof)(_2);
  _1= _bind(_1, s__5fclone_)(_1, _2);
  return _1;
 }
}

static oop _object__s__5fdelegated(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_nil;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v__object;
 }
  } else {
 {
  _2= self;
 }
  } _1= _2;
  _1= _bind(_1, s__5fvtbl)(_1);
  _1= _bind(_1, s_delegated)(_1);
  _2= v_nil;
  _1= _bind(_1, s_allocate_)(_1, _2);
  return _1;
 }
}

static oop _vtbl__s_delegated(oop self)
{
 {
  oop v_parent;
  oop _1, _2, _3;
  _1= self;
  v_parent= _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= l_3;
  ((struct t__vtbl *)self)->size= _1;
  _1= l_4;
  ((struct t__vtbl *)self)->capacity= _1;
  _1= v__object;
  _2= v__binding;
  _2= _bind(_2, s_sizeof)(_2);
  _3= ((struct t__vtbl *)self)->capacity;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _1= _bind(_1, s__5fnewPointers_)(_1, _2);
  ((struct t__vtbl *)self)->_bindings= _1;
  _1= v_parent;
  ((struct t__vtbl *)self)->delegate= _1;
  
#    if (VTBL_CACHE)
#     error: redefine _vtbl() to include the additional slots for the selector cache!
      vtbl->cache = array_new(0);	/* a sparse array mapping selector index -> method */
      vtbl->next  = vtbl_List;		/* push the new vtbl onto the vtbl list */
      vtbl_List   = (vtbl_t)self;
#    endif
    
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_allocate_(oop self, oop v__size)
{
 {
  oop _1;
  
  vtbl_t *chunk= (vtbl_t *)_newPointers(sizeof(vtbl_t) + (long)v__size);
  *chunk= (vtbl_t)self;
  return (oop)(chunk + 1);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_beNilType(oop self)
{
 {
  oop _1;
   vtbl_Nil= (vtbl_t)self 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_beTaggedType(oop self)
{
 {
  oop _1;
   vtbl_Tagged= (vtbl_t)self 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s__5fbeNilType(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fvtbl)(_1);
  _1= _bind(_1, s_beNilType)(_1);
  _1= self;
  return _1;
 }
}

static oop _object__s__5fbeTaggedType(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fvtbl)(_1);
  _1= _bind(_1, s_beTaggedType)(_1);
  _1= self;
  return _1;
 }
}

static oop _object__s__5frealloc_size_(oop self, oop v__pointer, oop v_size)
{
 {
  oop _1;
  
  return _realloc(v__pointer, _integerValue(v_size));

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_grow(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t__vtbl *)self)->capacity;
  _2= l_5;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) * _integerValue(_2));
  else
    _1= _bind(_1, s__2a)(_1, _2);
  ((struct t__vtbl *)self)->capacity= _1;
  _1= v__object;
  _2= ((struct t__vtbl *)self)->_bindings;
  _3= v__binding;
  _3= _bind(_3, s_sizeof)(_3);
  _4= ((struct t__vtbl *)self)->capacity;
  if (_areIntegerObjects(_3, _4))
    _3= _integerObject(_integerValue(_3) * _integerValue(_4));
  else
    _3= _bind(_3, s__2a)(_3, _4);
  _1= _bind(_1, s__5frealloc_size_)(_1, _2, _3);
  ((struct t__vtbl *)self)->_bindings= _1;
  _1= self;
  return _1;
 }
}

static oop _binding__s_newSelector_method_(oop self, oop v_aSelector, oop v__aMethod)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_aSelector;
  ((struct t__binding *)self)->selector= _1;
  _1= v__aMethod;
  ((struct t__binding *)self)->_method= _1;
  _1= self;
  return _1;
 }
}

static oop _vtbl__s_at_put_(oop self, oop v_aSelector, oop v__aMethod)
{
 {
  oop v_index;
  oop v_done;
  oop _1, _2, _3, _4, _5, _6;
  _1= l_6;
  v_index= _1;
  _1= v_nil;
  v_done= _1;
  for (;;) {
 {
  _1= v_index;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= v_done;
  _3= v_nil;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  oop v_binding;
  _1= self;
  _2= v_index;
  _1= _bind(_1, s_bindingAt_)(_1, _2);
  v_binding= _1;
  _1= v_binding;
  _1= _bind(_1, s_selector)(_1);
  _2= v_aSelector;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_binding;
  _3= v__aMethod;
  _2= _bind(_2, s__5fmethod_)(_2, _3);
  v_done= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= v_index;
  _2= l_7;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_index= _1;
 }
  };
  _1= v_done;
  if (!_1) {
 {
  _2= ((struct t__vtbl *)self)->size;
  _3= ((struct t__vtbl *)self)->capacity;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= self;
  _3= _bind(_3, s_grow)(_3);
 }
  _2= _3;
  } else _2= 0;
  _2= ((struct t__vtbl *)self)->size;
  _3= l_8;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t__vtbl *)self)->size= _2;
  _2= self;
  _3= ((struct t__vtbl *)self)->size;
  _4= l_9;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  _4= v__binding;
  _5= v_aSelector;
  _6= v__aMethod;
  _4= _bind(_4, s_newSelector_method_)(_4, _5, _6);
  _2= _bind(_2, s_bindingAt_put_)(_2, _3, _4);
 }
  _1= _2;
  } else _1= 0;
  _1= v__aMethod;
  return _1;
 }
}

static oop _vtbl__s_at_(oop self, oop v_aSelector)
{
 {
  oop v_index;
  oop v_found;
  oop _1, _2, _3;
  _1= l_10;
  v_index= _1;
  _1= v_nil;
  v_found= _1;
  for (;;) {
 {
  _1= v_index;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= v_found;
  _3= v_nil;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  oop v_binding;
  _1= self;
  _2= v_index;
  _1= _bind(_1, s_bindingAt_)(_1, _2);
  v_binding= _1;
  _1= v_binding;
  _1= _bind(_1, s_selector)(_1);
  _2= v_aSelector;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_binding;
  _2= _bind(_2, s__5fmethod)(_2);
  v_found= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= v_index;
  _2= l_11;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_index= _1;
 }
  };
  _1= v_found;
  return _1;
 }
}

static oop _object__s__5fmethodAt_put_(oop self, oop v_aSelector, oop v__aMethod)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s__5fvtbl)(_1);
  _2= v_aSelector;
  _3= v__aMethod;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop _vtbl__s_flushCache(oop self)
{
 {
  oop _1;
  
  flushCache();    /* flushes all method caches (global, vtbl, inline, whatever...) */

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s__5fvalue_(oop self, oop v__cString)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  {
      struct t__selector *this= (struct t__selector *)self;
      char *string= (char *)v__cString;
      long size= strlen(string);
      this->size=  _integerObject(size);
      this->_name= _newBytes(size + 1);
      memcpy(this->_name, string, size);
      ((char *)this->_name)[size]= '\0';
      this->next= 0;
    }
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _object__s_is_5fselector(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop _selector__s_is_5fselector(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop _selector__s__5fstringValue(oop self)
{
 {
  oop _1;
  _1= ((struct t__selector *)self)->_name;
  return _1;
 }
}

static oop _selector__s__5fcString(oop self)
{
 {
  oop _1;
  _1= ((struct t__selector *)self)->_name;
  return _1;
 }
}

static oop _object__s__5fmemcmp_with_length_(oop self, oop v_b1, oop v_b2, oop v_len)
{
 {
  oop _1;
  
  return _integerObject((long)memcmp(v_b1, v_b2, _integerValue(v_len)));

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s__3d(oop self, oop v_aSelectorOrString)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= ((struct t__selector *)self)->size;
  _2= v_aSelectorOrString;
  _2= _bind(_2, s_size)(_2);
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v__object;
  _3= ((struct t__selector *)self)->_name;
  _4= v_aSelectorOrString;
  _4= _bind(_4, s__5fstringValue)(_4);
  _5= ((struct t__selector *)self)->size;
  _2= _bind(_2, s__5fmemcmp_with_length_)(_2, _3, _4, _5);
  _3= l_12;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  return _1;
 }
}

static oop _selector__s_list(oop self)
{
 {
  oop _1;
   return (oop)(_sel_List); 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s_list_(oop self, oop v_sel)
{
 {
  oop _1;
   return (oop)(_sel_List= (sel_t)v_sel); 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop _selector__s_intern_(oop self, oop v_aSelectorOrString)
{
 {
  oop v_selector;
  oop v_found;
  oop _1, _2, _3, _4;
  _1= v__selector;
  _1= _bind(_1, s_list)(_1);
  v_selector= _1;
  _1= v_nil;
  v_found= _1;
  for (;;) {
 {
  _1= v_selector;
  _2= v_nil;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (_1) break;
 {
  _1= v_selector;
  _2= v_aSelectorOrString;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_selector;
  v_found= _2;
  _2= v_nil;
  v_selector= _2;
 }
  } else {
 {
  _2= v_selector;
  _2= _bind(_2, s_next)(_2);
  v_selector= _2;
 }
  } _1= _2;
 }
  };
  _1= v_found;
  _2= v_nil;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_aSelectorOrString;
  _2= _bind(_2, s_is_5fselector)(_2);
  if (_2) {
 {
  _3= v_aSelectorOrString;
 }
  } else {
 {
  _3= self;
  _4= v_aSelectorOrString;
  _4= _bind(_4, s__5fcString)(_4);
  _3= _bind(_3, s__5fvalue_)(_3, _4);
 }
  } _2= _3;
  v_selector= _2;
  _2= v_selector;
  _3= self;
  _3= _bind(_3, s_list)(_3);
  _2= _bind(_2, s_next_)(_2, _3);
  _2= self;
  _3= v_selector;
  _2= _bind(_2, s_list_)(_2, _3);
 }
  } else {
 {
  _2= v_found;
  v_selector= _2;
 }
  } _1= _2;
  _1= v_selector;
  return _1;
 }
}

static oop _selector__s__5fintern_(oop self, oop v__cString)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v__selector;
  _3= v__cString;
  _2= _bind(_2, s__5fvalue_)(_2, _3);
  _1= _bind(_1, s_intern_)(_1, _2);
  return _1;
 }
}

static oop _vtbl__s_lookup_(oop self, oop v_aSelector)
{
 {
  oop _1;
  
  struct t__vtbl *this= (struct t__vtbl *)self;
  while (this)
    {
      struct t__binding **alist= (struct t__binding **)this->_bindings;
      int i, j= _integerValue(this->size);
      for (i= 0;  i < j;  ++i, ++alist)
	if (v_aSelector == (*alist)->selector)
	  return (*alist)->_method;
      this= (struct t__vtbl *)this->delegate;
    }
  return 0;

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s_new(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  _1= _bind(_1, s_initialise)(_1);
  return _1;
 }
}

static oop Object__s_initialise(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_yourself(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_species(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_isNil(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop Object__s_notNil(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop Object__s__5fidentityHash(oop self)
{
 {
  oop _1;
  
  return (oop)((unsigned long)self >> 4);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s_identityHash(oop self)
{
 {
  oop _1, _2;
  _1= v_SmallInteger;
  _2= self;
  _2= _bind(_2, s__5fidentityHash)(_2);
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop Object__s_hash(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_identityHash)(_1);
  return _1;
 }
}

static oop Object__s__3d_3d(oop self, oop v_anObject)
{
 {
  oop _1;
  
  return self == v_anObject ? v_true : v_false;

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s__7e_7e(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_anObject;
  _1= (_1 == _2) ? v_true : v_false;
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop Object__s__3d(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_anObject;
  _1= (_1 == _2) ? v_true : v_false;
  return _1;
 }
}

static oop Object__s__7e_3d(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_anObject;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop Object__s_not(oop self)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop Object__s_ifTrue_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop Object__s_and_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop Object__s_ifFalse_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop Object__s_or_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_assert(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_refute(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_13;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s_assert_(oop self, oop v_aBlock)
{
 {
  oop _1;
  #ifndef NDEBUG //
  ; _1= 0;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  _1= _bind(_1, s_assert)(_1);
  #endif //
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s_refute_(oop self, oop v_aBlock)
{
 {
  oop _1;
  #ifndef NDEBUG //
  ; _1= 0;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  _1= _bind(_1, s_refute)(_1);
  #endif //
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_1(oop _self)
{
 {
  oop _1;
  _1= v_true;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Object__s_isKindOf_(oop self, oop v_parentObject)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_vtbl;
  oop v_parentVtbl;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s__5fvtbl)(_1);
  v_vtbl= _1;
  _1= v_parentObject;
  _1= _bind(_1, s__5fvtbl)(_1);
  v_parentVtbl= _1;
  for (;;) {
 {
  _1= v_vtbl;
  _1= _bind(_1, s_notNil)(_1);
 }
  if (!_1) break;
 {
  _1= v_vtbl;
  _2= v_parentVtbl;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_1, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= v_vtbl;
  _1= _bind(_1, s_delegate)(_1);
  v_vtbl= _1;
 }
  };
  _1= v_false;
  return _1;
 }
}

static oop Object__s_isMemberOf_(oop self, oop v_siblingObject)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s__5fvtbl)(_1);
  _2= v_siblingObject;
  _2= _bind(_2, s__5fvtbl)(_2);
  _1= (_1 == _2) ? v_true : v_false;
  return _1;
 }
}

static oop Object__s_printString(oop self)
{
 {
  oop _1, _2;
  _1= v_String;
  _2= l_14;
  _1= _bind(_1, s_new_)(_1, _2);
  _1= _bind(_1, s_writeStream)(_1);
  _2= self;
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_contents)(_1);
  return _1;
 }
}

static oop Object__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= self;
  _2= _bind(_2, s_debugName)(_2);
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s__5ferror_(oop self, oop v__reasonString)
{
 {
  oop _1;
  
  fprintf(stderr, "%s\n", (char *)v__reasonString);
  exit(1);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Object__s_error_(oop self, oop v_reasonString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_reasonString;
  _2= _bind(_2, s__5fcString)(_2);
  _1= _bind(_1, s__5ferror_)(_1, _2);
  return _1;
 }
}

static oop Object__s_subclassResponsibility(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= self;
  _2= _bind(_2, s_debugName)(_2);
  _3= l_15;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop Object__s_subclassResponsibility_(oop self, oop v_selector)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= self;
  _2= _bind(_2, s_debugName)(_2);
  _3= l_16;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_selector;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop Object__s_shouldNotImplement(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_17;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop Object__s_primitiveFailed(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_18;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop UndefinedObject__s_isNil(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop UndefinedObject__s_notNil(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop UndefinedObject__s_not(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop UndefinedObject__s_ifTrue_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop UndefinedObject__s_and_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop UndefinedObject__s_ifFalse_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop UndefinedObject__s_or_(oop self, oop v_aBlock)
{
 {
  oop _1;
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop UndefinedObject__s_assert(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_19;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop UndefinedObject__s_refute(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop StaticBlock__s__5fentry__5farity_(oop self, oop v_f, oop v_a)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_f;
  ((struct t_StaticBlock *)self)->_function= _1;
  _1= v_a;
  ((struct t_StaticBlock *)self)->_arity= _1;
  _1= self;
  return _1;
 }
}

static oop StaticBlock__s_arity(oop self)
{
 {
  oop _1;
  
  return _integerObject((long)((struct t_StaticBlock *)self)->_arity);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop StaticBlock__s_value(oop self)
{
 {
  oop _1;
  
      if (0 == (long)((struct t_BlockClosure *)self)->_arity)
        return ((oop (*)(oop))(((struct t_BlockClosure *)self)->_function))(self);
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop StaticBlock__s_value_(oop self, oop v_a)
{
 {
  oop _1;
  
      if (1 == (long)((struct t_BlockClosure *)self)->_arity)
        return ((oop (*)(oop, oop))(((struct t_BlockClosure *)self)->_function))(self, v_a);
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop StaticBlock__s_value_value_(oop self, oop v_a, oop v_b)
{
 {
  oop _1;
  
      if (2 == (long)((struct t_BlockClosure *)self)->_arity)
        return ((oop (*)(oop, oop, oop))(((struct t_BlockClosure *)self)->_function))(self, v_a, v_b);
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop StaticBlock__s_repeat(oop self)
{
 {
  oop _1;
  for (;;) {
 {
  _1= v_true;
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_value)(_1);
 }
  };
  _1= self;
  return _1;
 }
}

static oop BlockClosure__s__5fentry__5farity_receiver_state_outer_(oop self, oop v_f, oop v_a, oop v_r, oop v_s, oop v_o)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_f;
  ((struct t_StaticBlock *)self)->_function= _1;
  _1= v_a;
  ((struct t_StaticBlock *)self)->_arity= _1;
  _1= v_r;
  ((struct t_BlockClosure *)self)->receiver= _1;
  _1= v_s;
  ((struct t_BlockClosure *)self)->_state= _1;
  _1= v_o;
  ((struct t_BlockClosure *)self)->outer= _1;
  _1= self;
  return _1;
 }
}

static oop BlockClosureNLR__s__5fentry__5farity_receiver_state_envp_(oop self, oop v_f, oop v_a, oop v_r, oop v_s, oop v_e)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_f;
  ((struct t_StaticBlock *)self)->_function= _1;
  _1= v_a;
  ((struct t_StaticBlock *)self)->_arity= _1;
  _1= v_r;
  ((struct t_BlockClosure *)self)->receiver= _1;
  _1= v_s;
  ((struct t_BlockClosure *)self)->_state= _1;
  _1= v_nil;
  ((struct t_BlockClosure *)self)->outer= _1;
  _1= v_e;
  ((struct t_BlockClosureNLR *)self)->_envp= _1;
  _1= self;
  return _1;
 }
}

static oop BlockClosureNLR__s_cannotReturn_(oop self, oop v_anObject)
{
 {
  oop _1;
  _1= l_20;
  _1= _bind(_1, s_println)(_1);
   abort(); 
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop BlockClosureNLR__s_return_(oop self, oop v_anObject)
{
 {
  oop _1;
  
  _nlReturn(self, ((struct t_BlockClosureNLR *)self)->_envp, v_anObject);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static int   Association__5fsizeof(oop self) { return sizeof(struct t_Association); }
static char *Association__5fdebugName(oop self) { return "Association"; }

static oop Association__s_key_value_(oop self, oop v_keyObject, oop v_valueObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_keyObject;
  ((struct t_Association *)self)->key= _1;
  _1= v_valueObject;
  ((struct t_Association *)self)->value= _1;
  _1= self;
  return _1;
 }
}

static oop Association__s_key(oop self)
{
 {
  oop _1;
  _1= ((struct t_Association *)self)->key;
  return _1;
 }
}

static oop Association__s_value(oop self)
{
 {
  oop _1;
  _1= ((struct t_Association *)self)->value;
  return _1;
 }
}

static oop Association__s_key_(oop self, oop v_keyObject)
{
 {
  oop _1;
  _1= v_keyObject;
  ((struct t_Association *)self)->key= _1;
  _1= self;
  return _1;
 }
}

static oop Association__s_value_(oop self, oop v_valueObject)
{
 {
  oop _1;
  _1= v_valueObject;
  ((struct t_Association *)self)->value= _1;
  _1= self;
  return _1;
 }
}

static oop Association__s_hash(oop self)
{
 {
  oop _1;
  _1= ((struct t_Association *)self)->key;
  _1= _bind(_1, s_hash)(_1);
  return _1;
 }
}

static oop Association__s__3d(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= ((struct t_Association *)self)->key;
  _2= v_anObject;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop Collection__s_new(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_21;
  _1= _bind(_1, s_new_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_with_(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  _2= v_anObject;
  _bind(_1, s_add_)(_1, _2);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static oop Collection__s_emptyCheck(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_errorEmptyCollection)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Collection__s_isEmpty(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= l_22;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop Collection__s_notEmpty(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop b_2(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_element;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_addAll_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= v_aCollection;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_2, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= v_aCollection;
  return _1;
 }
}

static oop b_4(oop _self)
{
 {
  oop _1;
  _1= v_true;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_3(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= v_element;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_4, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_includes_(oop self, oop v_anObject)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_anObject;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_3, 1, self, _state, &_env);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= v_false;
  return _1;
 }
}

static oop Collection__s_do_(oop self, oop v_unaryBlock)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  _1= self;
  return _1;
 }
}

static oop b_5(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_element;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= l_24;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[1]= _1;
  return _1;
 }
}

static oop Collection__s_doWithIndex_(oop self, oop v_binaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_binaryBlock;
 {
  oop _1, _2;
  _1= l_23;
  _state[1]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_5, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_6(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= v_element;
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  return _1;
 }
}

static oop Collection__s_inject_into_(oop self, oop v_initialValue, oop v_binaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_binaryBlock;
 {
  oop _1, _2;
  _1= v_initialValue;
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_6, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static oop b_7(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _3= v_element;
  _2= _bind(_2, s_value_)(_2, _3);
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_collect_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_unaryBlock;
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _1= _bind(_1, s_new)(_1);
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_7, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static oop b_8(oop _self, oop v_element, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_index;
  _3= v_element;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Collection__s_asArray(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_Array;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_8, 2, self, _state, 0);
  _1= _bind(_1, s_doWithIndex_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static oop Collection__s_errorEmptyCollection(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_25;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_errorCannotModify(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_26;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop Collection__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _bind(_1, s_printNameOn_)(_1, _2);
  _2= v_aStream;
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Collection__s_printNameOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_Object, s_printOn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_9(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_element;
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_space)(_1);
  return _1;
 }
}

static oop Collection__s_printElementsOn_(oop self, oop v_aStream)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aStream;
 {
  oop _1, _2, _3;
  _1= _state[0];
  _2= l_27;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_9, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= _state[0];
  _3= l_28;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= l_29;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_10(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  if (_1) {
 {
  _2= v_false;
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _2;
 }
  } else {
 {
  _2= l_31;
  _2= _bind(_2, s_print)(_2);
 }
  } _1= _2;
  _1= v_element;
  _1= _bind(_1, s_print)(_1);
  return _1;
 }
}

static oop Collection__s_print(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= self;
  _1= _rebind(v_Object, s_print)(_1);
  _1= l_30;
  _1= _bind(_1, s_print)(_1);
  _1= v_true;
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_10, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= l_32;
  _1= _bind(_1, s_print)(_1);
  _1= self;
  return _1;
 }
}

static oop SequenceableCollection__s_with_(oop self, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_33;
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_34;
  _3= v_anObject;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static oop b_11(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_index;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s_atAllPut_(oop self, oop v_anObject)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_anObject;
 {
  oop _1, _2, _3;
  _1= l_35;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_36;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_11, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop b_12(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_index;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s_atAll_put_(oop self, oop v_indices, oop v_anObject)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_anObject;
 {
  oop _1, _2;
  _1= v_indices;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_12, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceableCollection__s_first(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_37;
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_second(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_38;
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_third(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_39;
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_last(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_40;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop b_13(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_do_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unaryBlock;
 {
  oop _1, _2, _3;
  _1= l_41;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_42;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_13, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop b_14(oop _self, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _4= v_index;
  _3= _bind(_3, s_at_)(_3, _4);
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s_with_do_(oop self, oop v_aCollection, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_aCollection;
  _state[0]= v_unaryBlock;
 {
  oop _1, _2, _3;
  _1= l_43;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_44;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_14, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop b_15(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _3= v_index;
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s_doWithIndex_(oop self, oop v_binaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_binaryBlock;
 {
  oop _1, _2, _3;
  _1= l_45;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_46;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_15, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop b_16(oop _self, oop v_element, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_index;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _4= v_element;
  _3= _bind(_3, s_value_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s_collect_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_unaryBlock;
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_16, 2, self, _state, 0);
  _1= _bind(_1, s_doWithIndex_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static oop SequenceableCollection__s_errorSubscriptBounds_(oop self, oop v_index)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_47;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_errorImproperStore_(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_48;
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_replaceFrom_to_with_startingAt_(oop self, oop v_start, oop v_stop, oop v_replacement, oop v_repStart)
{
 {
  oop _1, _2, _3, _4;
  for (;;) {
 {
  _1= v_start;
  _2= v_stop;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
 }
  if (!_1) break;
 {
  _1= self;
  _2= v_start;
  _3= v_replacement;
  _4= v_repStart;
  _3= _bind(_3, s_at_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= v_start;
  _2= l_49;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_start= _1;
  _1= v_repStart;
  _2= l_50;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_repStart= _1;
 }
  };
  _1= self;
  return _1;
 }
}

static oop SequenceableCollection__s_copyFrom_to_(oop self, oop v_start, oop v_stop)
{
 {
  oop v_newSize;
  oop _1, _2, _3, _4, _5;
  _1= v_stop;
  _2= v_start;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  v_newSize= _1;
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _2= v_newSize;
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_51;
  _3= v_newSize;
  _4= self;
  _5= v_start;
  _1= _bind(_1, s_replaceFrom_to_with_startingAt_)(_1, _2, _3, _4, _5);
  return _1;
 }
}

static oop SequenceableCollection__s_copyFrom_(oop self, oop v_start)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_start;
  _3= self;
  _3= _bind(_3, s_size)(_3);
  _1= _bind(_1, s_copyFrom_to_)(_1, _2, _3);
  return _1;
 }
}

static oop SequenceableCollection__s__2c(oop self, oop v_aCollection)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= v_aCollection;
  _3= _bind(_3, s_size)(_3);
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_52;
  _3= self;
  _3= _bind(_3, s_size)(_3);
  _4= self;
  _5= l_53;
  _bind(_1, s_replaceFrom_to_with_startingAt_)(_1, _2, _3, _4, _5);
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= self;
  _3= _bind(_3, s_size)(_3);
  _4= v_aCollection;
  _4= _bind(_4, s_size)(_4);
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _4= v_aCollection;
  _5= l_54;
  _1= _bind(_1, s_replaceFrom_to_with_startingAt_)(_1, _2, _3, _4, _5);
  return _1;
 }
}

static oop b_17(oop _self)
{
 {
  oop _1;
  _1= v_false;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_19(oop _self)
{
 {
  oop _1;
  _1= v_false;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_18(oop _self, oop v_x, oop v_y)
{
 {
  oop _1, _2;
  _1= v_x;
  _2= v_y;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_19, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_ifFalse_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s__3d(oop self, oop v_aCollection)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= v_aCollection;
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_17, 0, self, 0, &_env);
  _1= _bind(_1, s_ifFalse_)(_1, _2);
  _1= self;
  _2= v_aCollection;
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_18, 2, self, 0, &_env);
  _1= _bind(_1, s_with_do_)(_1, _2, _3);
  _1= v_true;
  return _1;
 }
}

static int   OrderedCollection__5fsizeof(oop self) { return sizeof(struct t_OrderedCollection); }
static char *OrderedCollection__5fdebugName(oop self) { return "OrderedCollection"; }

static oop OrderedCollection__s_new_(oop self, oop v_size)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= self;
  _2= v_Array;
  _3= v_size;
  _2= _bind(_2, s_new_)(_2, _3);
  _1= _bind(_1, s_setCollection_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_20(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_species)(_1);
  _2= l_57;
  _1= _bind(_1, s_new_)(_1, _2);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_21(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _1= _bind(_1, s_addLast_)(_1, _2);
  _1= l_59;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  return _1;
 }
}

static oop OrderedCollection__s_copyFrom_to_(oop self, oop v_startIndex, oop v_endIndex)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_printString)(_1);
  _2= l_55;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_startIndex;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _2= l_56;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_endIndex;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= v_endIndex;
  _2= v_startIndex;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 <= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c_3d)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_20, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _2= v_endIndex;
  _3= v_startIndex;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= v_startIndex;
  _2= v_endIndex;
  _3= l_58;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_21, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= _state[0];
  return _1;
 }
}

static oop OrderedCollection__s_reset(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_OrderedCollection *)self)->array;
  _1= _bind(_1, s_size)(_1);
  _2= l_60;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) / _integerValue(_2));
  else
    _1= _bind(_1, s__2f_2f)(_1, _2);
  ((struct t_OrderedCollection *)self)->firstIndex= _1;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  ((struct t_OrderedCollection *)self)->lastIndex= _1;
  _1= self;
  return _1;
 }
}

static oop OrderedCollection__s_setCollection_(oop self, oop v_anArray)
{
 {
  oop _1;
  _1= v_anArray;
  ((struct t_OrderedCollection *)self)->array= _1;
  _1= self;
  _1= _bind(_1, s_reset)(_1);
  _1= self;
  return _1;
 }
}

static oop OrderedCollection__s_growSize(oop self)
{
 {
  oop _1, _2, _3;
  _1= l_61;
  _2= ((struct t_OrderedCollection *)self)->array;
  _2= _bind(_2, s_size)(_2);
  _3= l_62;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_max_)(_1, _2);
  return _1;
 }
}

static oop OrderedCollection__s_makeRoomAtFirst(oop self)
{
 {
  oop _1, _2, _3, _4, _5, _6;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= l_63;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_OrderedCollection *)self)->array;
  _2= _bind(_2, s_size)(_2);
  ((struct t_OrderedCollection *)self)->lastIndex= _2;
  ((struct t_OrderedCollection *)self)->firstIndex= _2;
 }
  } else {
 {
  oop v_count;
  oop v_newSize;
  oop v_newArray;
  oop v_in;
  oop v_out;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  v_count= _2;
  _2= v_count;
  _3= self;
  _3= _bind(_3, s_growSize)(_3);
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  v_newSize= _2;
  _2= v_Array;
  _3= v_newSize;
  _2= _bind(_2, s_new_)(_2, _3);
  v_newArray= _2;
  _2= v_newSize;
  v_out= _2;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  v_in= _2;
  for (;;) {
 {
  _2= v_in;
  _3= ((struct t_OrderedCollection *)self)->firstIndex;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
 }
  if (!_2) break;
 {
  _2= v_newArray;
  _3= v_out;
  _4= l_64;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  v_out= _3;
  _4= ((struct t_OrderedCollection *)self)->array;
  _5= v_in;
  _6= l_65;
  if (_areIntegerObjects(_5, _6))
    _5= (oop)((long)_5 - (long)_6 + 1);
  else
    _5= _bind(_5, s__2d)(_5, _6);
  v_in= _5;
  _4= _bind(_4, s_at_)(_4, _5);
  _2= _bind(_2, s_at_put_)(_2, _3, _4);
 }
  };
  _2= v_newArray;
  ((struct t_OrderedCollection *)self)->array= _2;
  _2= v_newSize;
  ((struct t_OrderedCollection *)self)->lastIndex= _2;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  _3= v_count;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  ((struct t_OrderedCollection *)self)->firstIndex= _2;
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop OrderedCollection__s_makeRoomAtLast(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= l_66;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= l_67;
  ((struct t_OrderedCollection *)self)->lastIndex= _2;
  ((struct t_OrderedCollection *)self)->firstIndex= _2;
 }
  } else {
 {
  oop v_newArray;
  oop v_inOut;
  _2= v_Array;
  _3= ((struct t_OrderedCollection *)self)->array;
  _3= _bind(_3, s_size)(_3);
  _4= self;
  _4= _bind(_4, s_growSize)(_4);
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _2= _bind(_2, s_new_)(_2, _3);
  v_newArray= _2;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  v_inOut= _2;
  for (;;) {
 {
  _2= v_inOut;
  _3= ((struct t_OrderedCollection *)self)->lastIndex;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 < (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c)(_2, _3);
 }
  if (!_2) break;
 {
  _2= v_newArray;
  _3= v_inOut;
  _4= ((struct t_OrderedCollection *)self)->array;
  _5= v_inOut;
  _4= _bind(_4, s_at_)(_4, _5);
  _2= _bind(_2, s_at_put_)(_2, _3, _4);
  _2= v_inOut;
  _3= l_68;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  v_inOut= _2;
 }
  };
  _2= v_newArray;
  ((struct t_OrderedCollection *)self)->array= _2;
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop OrderedCollection__s_addFirst_(oop self, oop v_newObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  _2= l_69;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_makeRoomAtFirst)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= l_70;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  ((struct t_OrderedCollection *)self)->firstIndex= _2;
  _3= v_newObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop OrderedCollection__s_addLast_(oop self, oop v_newObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_OrderedCollection *)self)->lastIndex;
  _2= ((struct t_OrderedCollection *)self)->array;
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_makeRoomAtLast)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  _3= v_newObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= ((struct t_OrderedCollection *)self)->lastIndex;
  _2= l_71;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_OrderedCollection *)self)->lastIndex= _1;
  _1= v_newObject;
  return _1;
 }
}

static oop OrderedCollection__s_add_(oop self, oop v_newObject)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_newObject;
  _1= _bind(_1, s_addLast_)(_1, _2);
  return _1;
 }
}

static oop OrderedCollection__s_removeFirst(oop self)
{
 {
  oop v_firstObject;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_emptyCheck)(_1);
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _1= _bind(_1, s_at_)(_1, _2);
  v_firstObject= _1;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= v_nil;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  _2= l_72;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_OrderedCollection *)self)->firstIndex= _1;
  _1= v_firstObject;
  return _1;
 }
}

static oop OrderedCollection__s_removeLast(oop self)
{
 {
  oop v_lastObject;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_emptyCheck)(_1);
  _1= ((struct t_OrderedCollection *)self)->lastIndex;
  _2= l_73;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  ((struct t_OrderedCollection *)self)->lastIndex= _1;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  _1= _bind(_1, s_at_)(_1, _2);
  v_lastObject= _1;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  _3= v_nil;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= v_lastObject;
  return _1;
 }
}

static oop OrderedCollection__s_at_(oop self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= v_index;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop OrderedCollection__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= v_index;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop OrderedCollection__s_size(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_OrderedCollection *)self)->lastIndex;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  return _1;
 }
}

static oop OrderedCollection__s_insert_before_(oop self, oop v_anObject, oop v_spotIndex)
{
 {
  oop _1, _2, _3, _4, _5, _6;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  _2= l_74;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  oop v_delta;
  _2= v_spotIndex;
  _3= ((struct t_OrderedCollection *)self)->firstIndex;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  v_delta= _2;
  _2= self;
  _2= _bind(_2, s_makeRoomAtFirst)(_2);
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= v_delta;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  v_spotIndex= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  _2= l_75;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  ((struct t_OrderedCollection *)self)->firstIndex= _1;
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= ((struct t_OrderedCollection *)self)->firstIndex;
  _3= v_spotIndex;
  _4= l_76;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  _4= ((struct t_OrderedCollection *)self)->array;
  _5= ((struct t_OrderedCollection *)self)->firstIndex;
  _6= l_77;
  if (_areIntegerObjects(_5, _6))
    _5= (oop)((long)_5 + (long)_6 - 1);
  else
    _5= _bind(_5, s__2b)(_5, _6);
  _1= _bind(_1, s_replaceFrom_to_with_startingAt_)(_1, _2, _3, _4, _5);
  _1= ((struct t_OrderedCollection *)self)->array;
  _2= v_spotIndex;
  _3= l_78;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= v_anObject;
  return _1;
 }
}

static oop b_22(oop _self, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _3= ((struct t_OrderedCollection *)((struct t_BlockClosure *)_self)->receiver)->array;
  _4= v_index;
  _3= _bind(_3, s_at_)(_3, _4);
  _2= _bind(_2, s_value_)(_2, _3);
  _1= _bind(_1, s_addLast_)(_1, _2);
  return _1;
 }
}

static oop OrderedCollection__s_collect_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_unaryBlock;
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_species)(_1);
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  _2= ((struct t_OrderedCollection *)self)->lastIndex;
  _3= l_79;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_22, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= _state[0];
  return _1;
 }
}

static int   SortedCollection__5fsizeof(oop self) { return sizeof(struct t_SortedCollection); }
static char *SortedCollection__5fdebugName(oop self) { return "SortedCollection"; }

static oop SortedCollection__s_new_(oop self, oop v_size)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_size;
  _1= _rebind(v_OrderedCollection, s_new_)(_1, _2);
  self= _1;
  _1= v_nil;
  ((struct t_SortedCollection *)self)->sortBlock= _1;
  _1= self;
  return _1;
 }
}

static oop SortedCollection__s_sortBlock_(oop self, oop v_binaryBlock)
{
 {
  oop _1, _2;
  _1= v_binaryBlock;
  ((struct t_SortedCollection *)self)->sortBlock= _1;
  _1= self;
  _1= _bind(_1, s_notEmpty)(_1);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_reSort)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop SortedCollection__s_addFirst_(oop self, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_shouldNotImplement)(_1);
  return _1;
 }
}

static oop SortedCollection__s_addLast_(oop self, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_shouldNotImplement)(_1);
  return _1;
 }
}

static oop SortedCollection__s_insert_before_(oop self, oop v_anObject, oop v_index)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_shouldNotImplement)(_1);
  return _1;
 }
}

static oop SortedCollection__s_add_(oop self, oop v_newObject)
{
 {
  oop _1, _2, _3, _4;
  _1= self;
  _2= v_newObject;
  _3= self;
  _4= v_newObject;
  _3= _bind(_3, s_indexForInserting_)(_3, _4);
  _1= _rebind(v_OrderedCollection, s_insert_before_)(_1, _2, _3);
  return _1;
 }
}

static oop SortedCollection__s_indexForInserting_(oop self, oop v_newObject)
{
 {
  oop v_index;
  oop v_low;
  oop v_high;
  oop _1, _2, _3, _4;
  _1= ((struct t_OrderedCollection *)self)->firstIndex;
  v_low= _1;
  _1= ((struct t_OrderedCollection *)self)->lastIndex;
  _2= l_80;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  v_high= _1;
  _1= ((struct t_SortedCollection *)self)->sortBlock;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  for (;;) {
 {
  _2= v_low;
  _3= v_high;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
 }
  if (_2) break;
 {
  _2= v_high;
  _3= v_low;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _3= l_81;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) / _integerValue(_3));
  else
    _2= _bind(_2, s__2f_2f)(_2, _3);
  v_index= _2;
  _2= ((struct t_OrderedCollection *)self)->array;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _3= v_newObject;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 <= (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c_3d)(_2, _3);
  if (_2) {
 {
  _3= v_index;
  _4= l_82;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  v_low= _3;
 }
  } else {
 {
  _3= v_index;
  _4= l_83;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  v_high= _3;
 }
  } _2= _3;
 }
  };
 }
  } else {
 {
  for (;;) {
 {
  _2= v_low;
  _3= v_high;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
 }
  if (_2) break;
 {
  _2= v_high;
  _3= v_low;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _3= l_84;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) / _integerValue(_3));
  else
    _2= _bind(_2, s__2f_2f)(_2, _3);
  v_index= _2;
  _2= ((struct t_SortedCollection *)self)->sortBlock;
  _3= ((struct t_OrderedCollection *)self)->array;
  _4= v_index;
  _3= _bind(_3, s_at_)(_3, _4);
  _4= v_newObject;
  _2= _bind(_2, s_value_value_)(_2, _3, _4);
  if (_2) {
 {
  _3= v_index;
  _4= l_85;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  v_low= _3;
 }
  } else {
 {
  _3= v_index;
  _4= l_86;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  v_high= _3;
 }
  } _2= _3;
 }
  };
 }
  } _1= _2;
  _1= v_low;
  return _1;
 }
}

static oop Collection__s_asSortedCollection_(oop self, oop v_binarySortBlock)
{
 {
  oop _1, _2;
  _1= v_SortedCollection;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _2= v_binarySortBlock;
  _bind(_1, s_sortBlock_)(_1, _2);
  _2= self;
  _bind(_1, s_addAll_)(_1, _2);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static oop Collection__s_asSortedCollection(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_nil;
  _1= _bind(_1, s_asSortedCollection_)(_1, _2);
  return _1;
 }
}

static oop ArrayedCollection__s__5fsize_value_(oop self, oop v__size, oop v__value)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  
      ((struct t_Array *)self)->size= _integerObject((long)v__size);
      ((struct t_Array *)self)->_elements= (oop)v__value;
    
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop ArrayedCollection__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t_ArrayedCollection *)self)->size;
  return _1;
 }
}

static oop ArrayedCollection__s__5felements(oop self)
{
 {
  oop _1;
  _1= ((struct t_ArrayedCollection *)self)->_elements;
  return _1;
 }
}

static oop Array__s__5fsize_value_(oop self, oop v__size, oop v__value)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  {
      struct t_Array *this= (struct t_Array *)self;
      int i;
      this->size= _integerObject((long)v__size);
      this->_elements= _newPointers(sizeof(oop) * (long)v__size);
      for (i= 0;  i < (long)v__size;  ++i)
        ((oop *)this->_elements)[i]= *(((oop **)v__value)[i]);
    }
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Array__s_new_(oop self, oop v_newSize)
{
 {
  oop v_array;
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  v_array= _1;
  
      if (_isIntegerObject(v_newSize))
      {
        struct t_Array *array= (struct t_Array *)v_array;
        array->size= v_newSize;
	array->_elements= (oop)_newPointers(sizeof(oop) * _integerValue(v_newSize));
	return v_array;
      }
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop Array__s_at_(oop self, oop v_index)
{
 {
  oop _1, _2, _3;
  
      struct t_Array *this= (struct t_Array *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return ((oop *)this->_elements)[_integerValue(v_index)];
    
  ; _1= 0;
  _1= v_index;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorSubscriptBounds_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorNonIntegerIndex_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop Array__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3;
  
      struct t_Array *this= (struct t_Array *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return ((oop *)this->_elements)[_integerValue(v_index)]= v_anObject;
    
  ; _1= 0;
  _1= v_index;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorSubscriptBounds_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorNonIntegerIndex_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop Array__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_87;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  _2= v_aStream;
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ImmutableArray__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableArray__s_species(oop self)
{
 {
  oop _1;
  _1= v_Array;
  return _1;
 }
}

static oop Magnitude__s__3c(oop self, oop v_aMagnitude)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  return _1;
 }
}

static oop Magnitude__s__3c_3d(oop self, oop v_aMagnitude)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_aMagnitude;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (!_1) {
 {
  _2= self;
  _3= v_aMagnitude;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  return _1;
 }
}

static oop Magnitude__s__3d(oop self, oop v_aMagnitude)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  return _1;
 }
}

static oop Magnitude__s_hash(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  return _1;
 }
}

static oop Magnitude__s__3e_3d(oop self, oop v_aMagnitude)
{
 {
  oop _1, _2, _3;
  _1= v_aMagnitude;
  _2= self;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (!_1) {
 {
  _2= v_aMagnitude;
  _3= self;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  return _1;
 }
}

static oop Magnitude__s__3e(oop self, oop v_aMagnitude)
{
 {
  oop _1, _2;
  _1= v_aMagnitude;
  _2= self;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  return _1;
 }
}

static oop Magnitude__s_between_and_(oop self, oop v_min, oop v_max)
{
 {
  oop _1, _2, _3;
  _1= v_min;
  _2= self;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 <= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c_3d)(_1, _2);
  if (_1) {
 {
  _2= self;
  _3= v_max;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 <= (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c_3d)(_2, _3);
 }
  _1= _2;
  }
  return _1;
 }
}

static oop Magnitude__s_max_(oop self, oop v_aMagnitude)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aMagnitude;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= v_aMagnitude;
 }
  } else {
 {
  _2= self;
 }
  } _1= _2;
  return _1;
 }
}

static oop Magnitude__s_min_(oop self, oop v_aMagnitude)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aMagnitude;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= self;
 }
  } else {
 {
  _2= v_aMagnitude;
 }
  } _1= _2;
  return _1;
 }
}

static oop Magnitude__s_min_max_(oop self, oop v_aMagnitude, oop v_anotherMagnitude)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aMagnitude;
  _1= _bind(_1, s_min_)(_1, _2);
  _2= v_anotherMagnitude;
  _1= _bind(_1, s_max_)(_1, _2);
  return _1;
 }
}

static oop Number__s_negated(oop self)
{
 {
  oop _1, _2;
  _1= l_88;
  _2= self;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  return _1;
 }
}

static oop Object__s_isInteger(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop Integer__s_isInteger(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop Object__s_isSmallInteger(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop SmallInteger__s_isSmallInteger(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop SmallInteger__s__2b(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return _integerObject(_integerValue(self) + _integerValue(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__2d(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return _integerObject(_integerValue(self) - _integerValue(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__2a(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return _integerObject(_integerValue(self) * _integerValue(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__2f_2f(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return _integerObject(_integerValue(self) / _integerValue(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__5c_5c(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return _integerObject(_integerValue(self) % _integerValue(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s_bitAnd_(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (oop)((unsigned long)(self) & (unsigned long)(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s_bitOr_(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (oop)((unsigned long)self | (unsigned long)(v_anInteger));
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s_bitXor_(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (oop)(((unsigned long)(self) ^ (unsigned long)(v_anInteger)) | 1);
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__3c(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (_integerValue(self) < _integerValue(v_anInteger)) ? v_true : v_false;
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__3c_3d(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (_integerValue(self) <= _integerValue(v_anInteger)) ? v_true : v_false;
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_println)(_1);
  _1= v_anInteger;
  _1= _bind(_1, s_println)(_1);
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__3d(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (oop)((self == v_anInteger) ? v_true : v_false);
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__3e_3d(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (_integerValue(self) >= _integerValue(v_anInteger)) ? v_true : v_false;
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s__3e(oop self, oop v_anInteger)
{
 {
  oop _1;
  
      assert(_isIntegerObject(self));
      if ((long)v_anInteger & 1)
	return (_integerValue(self) > _integerValue(v_anInteger)) ? v_true : v_false;
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop SmallInteger__s_to_do_(oop self, oop v_maxValue, oop v_unaryBlock)
{
 {
  oop v_value;
  oop _1, _2;
   assert(_isIntegerObject(self)); 
  ; _1= 0;
  _1= self;
  v_value= _1;
  for (;;) {
 {
  _1= v_value;
  _2= v_maxValue;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 <= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c_3d)(_1, _2);
 }
  if (!_1) break;
 {
  _1= v_unaryBlock;
  _2= v_value;
  _1= _bind(_1, s_value_)(_1, _2);
  _1= v_value;
  _2= l_89;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_value= _1;
 }
  };
  _1= self;
  return _1;
 }
}

static oop SmallInteger__s_timesRepeat_(oop self, oop v_aBlock)
{
 {
  oop v_count;
  oop _1, _2;
  _1= self;
  v_count= _1;
  for (;;) {
 {
  _1= v_count;
  _2= l_90;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  v_count= _1;
  _2= l_91;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 >= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e_3d)(_1, _2);
 }
  if (!_1) break;
 {
  _1= v_aBlock;
  _1= _bind(_1, s_value)(_1);
 }
  };
  _1= self;
  return _1;
 }
}

static int   Character__5fsizeof(oop self) { return sizeof(struct t_Character); }
static char *Character__5fdebugName(oop self) { return "Character"; }

static oop Character__s_basicValue_(oop self, oop v_anInteger)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_anInteger;
  ((struct t_Character *)self)->value= _1;
  _1= self;
  return _1;
 }
}

static int   CharacterArray__5fsizeof(oop self) { return sizeof(struct t_CharacterArray); }
static char *CharacterArray__5fdebugName(oop self) { return "CharacterArray"; }

static oop Character__s_value_(oop self, oop v_anInteger)
{
 {
  oop _1, _2;
  _1= v_CharacterArray;
  _2= v_anInteger;
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop Character__s_asciiValue_(oop self, oop v_anInteger)
{
 {
  oop _1, _2;
  _1= v_CharacterArray;
  _2= v_anInteger;
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop Character__s__5fvalue_(oop self, oop v__value)
{
 {
  oop v_anInteger;
  oop _1, _2;
   v_anInteger= _integerObject((long)v__value); 
  ; _1= 0;
  _1= self;
  _2= v_anInteger;
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop Character__s_value(oop self)
{
 {
  oop _1;
  _1= ((struct t_Character *)self)->value;
  return _1;
 }
}

static oop Character__s_asciiValue(oop self)
{
 {
  oop _1;
  _1= ((struct t_Character *)self)->value;
  return _1;
 }
}

static oop b_23(oop _self, oop v_value)
{
 {
  oop _1, _2, _3, _4;
  _1= v_CharacterArray;
  _2= v_value;
  _3= v_Character;
  _4= v_value;
  _3= _bind(_3, s_basicValue_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop CharacterArray__s_initialise(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_92;
  _1= _bind(_1, s_new_)(_1, _2);
  v_CharacterArray= _1;
  _1= l_93;
  _2= l_94;
  _3= c_23;
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop Character__s_digitValue_(oop self, oop v_anInteger)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_anInteger;
  _3= l_95;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 < (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c)(_2, _3);
  if (_2) {
 {
  _3= l_96;
 }
  } else {
 {
  _3= l_97;
 }
  } _2= _3;
  _3= v_anInteger;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop Character__s_digitValue(oop self)
{
 {
  oop _1, _2;
  _1= l_354;
  _2= self;
  _2= _bind(_2, s_asciiValue)(_2);
  _1= _bind(_1, s_at_)(_1, _2);
  return _1;
 }
}

static oop Character__s_tab(oop self)
{
 {
  oop _1;
  _1= l_355;
  return _1;
 }
}

static oop Character__s_nl(oop self)
{
 {
  oop _1;
  _1= l_356;
  return _1;
 }
}

static oop Character__s_ff(oop self)
{
 {
  oop _1;
  _1= l_357;
  return _1;
 }
}

static oop Character__s_cr(oop self)
{
 {
  oop _1;
  _1= l_358;
  return _1;
 }
}

static oop Character__s_space(oop self)
{
 {
  oop _1;
  _1= l_359;
  return _1;
 }
}

static oop Character__s_isLetter(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= self;
  _2= l_360;
  _3= l_361;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (!_1) {
 {
  _2= self;
  _3= l_362;
  _4= l_363;
  _2= _bind(_2, s_between_and_)(_2, _3, _4);
 }
  _1= _2;
  }
  return _1;
 }
}

static oop Character__s_isDigit(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_364;
  _3= l_365;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  return _1;
 }
}

static oop Character__s_hash(oop self)
{
 {
  oop _1;
  _1= ((struct t_Character *)self)->value;
  return _1;
 }
}

static oop Character__s__3c(oop self, oop v_aCharacter)
{
 {
  oop _1, _2;
  _1= ((struct t_Character *)self)->value;
  _2= v_aCharacter;
  _2= _bind(_2, s_asciiValue)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  return _1;
 }
}

static oop Character__s__3d(oop self, oop v_aCharacter)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aCharacter;
  _1= (_1 == _2) ? v_true : v_false;
  return _1;
 }
}

static oop Character__s_asInteger(oop self)
{
 {
  oop _1;
  _1= ((struct t_Character *)self)->value;
  return _1;
 }
}

static oop Character__s_asString(oop self)
{
 {
  oop _1, _2;
  _1= v_String;
  _2= self;
  _1= _bind(_1, s_with_)(_1, _2);
  return _1;
 }
}

static oop Character__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_aStream;
  _2= l_366;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _2= l_367;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= v_aStream;
  _3= l_368;
  _bind(_2, s_nextPut_)(_2, _3);
  _3= v_Character;
  _4= self;
  _4= _bind(_4, s_asciiValue)(_4);
  _5= l_369;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_370;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_2, s_nextPut_)(_2, _3);
  _3= v_Character;
  _4= self;
  _4= _bind(_4, s_asciiValue)(_4);
  _5= l_371;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_372;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_2, s_nextPut_)(_2, _3);
  _3= v_Character;
  _4= self;
  _4= _bind(_4, s_asciiValue)(_4);
  _5= l_373;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_374;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } else {
 {
  _2= v_aStream;
  _3= self;
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop Character__s_print(oop self)
{
 {
  oop _1;
  
  struct t_Character *this= (struct t_Character *)self;
  int value= _integerValue(this->value);
  switch (value)
    {
    case  0: printf("$\\0");   break;
    case  7: printf("$\\a");   break;
    case  8: printf("$\\b");   break;
    case  9: printf("$\\t");   break;
    case 10: printf("$\\n");   break;
    case 11: printf("$\\v");   break;
    case 12: printf("$\\f");   break;
    case 13: printf("$\\r");   break;
    case 27: printf("$\\e");   break;
    case 92: printf("$\\\\");  break;
    default:
      if (isprint(value))
        printf("$%c", value);
      else
        printf("$\\%03o", value);
      break;
    }

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Integer__s_printDigitOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= l_375;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (!_1) {
 {
  _2= self;
  _3= l_376;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) / _integerValue(_3));
  else
    _2= _bind(_2, s__2f_2f)(_2, _3);
  _3= v_aStream;
  _2= _bind(_2, s_printDigitOn_)(_2, _3);
  _2= v_aStream;
  _3= v_Character;
  _4= self;
  _5= l_377;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Integer__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= l_378;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= v_aStream;
  _3= l_379;
  _2= _bind(_2, s_nextPut_)(_2, _3);
  _2= self;
  _2= _bind(_2, s_negated)(_2);
  _3= v_aStream;
  _2= _bind(_2, s_printOn_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= l_380;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) / _integerValue(_3));
  else
    _2= _bind(_2, s__2f_2f)(_2, _3);
  _3= v_aStream;
  _2= _bind(_2, s_printDigitOn_)(_2, _3);
  _2= v_aStream;
  _3= v_Character;
  _4= self;
  _5= l_381;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop Integer__s_readFrom_base_(oop self, oop v_aStream, oop v_base)
{
 {
  oop v_negative;
  oop v_value;
  oop _1, _2, _3, _4;
  _1= v_false;
  v_negative= _1;
  _1= l_382;
  v_value= _1;
  _1= v_aStream;
  _1= _bind(_1, s_peek)(_1);
  _2= l_383;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_aStream;
  _3= l_384;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  } else {
 {
  _2= v_aStream;
  _2= _bind(_2, s_peek)(_2);
  _3= l_385;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
  if (_2) {
 {
  _3= v_negative;
  _3= _bind(_3, s_not)(_3);
  v_negative= _3;
  _3= v_aStream;
  _4= l_386;
  _3= _bind(_3, s_skip_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
 }
  } _1= _2;
  for (;;) {
 {
  _1= v_aStream;
  _1= _bind(_1, s_atEnd)(_1);
 }
  if (_1) break;
 {
  oop v_digit;
  _1= v_aStream;
  _1= _bind(_1, s_next)(_1);
  v_digit= _1;
  _1= v_digit;
  _2= l_387;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_value;
  _3= l_388;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 < (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c)(_2, _3);
  if (_2) {
 {
  _3= self;
  _4= l_389;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= v_value;
  v_base= _2;
  _2= l_390;
  v_value= _2;
 }
  } else {
 {
  _2= v_digit;
  _2= _bind(_2, s_digitValue)(_2);
  v_digit= _2;
  _2= v_digit;
  _3= l_391;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 < (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c)(_2, _3);
  if (!_2) {
 {
  _3= v_digit;
  _4= v_base;
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 >= (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3e_3d)(_3, _4);
 }
  _2= _3;
  }
  if (_2) {
 {
  _3= self;
  _4= l_392;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= v_value;
  _3= v_base;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _3= v_digit;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  v_value= _2;
 }
  } _1= _2;
 }
  };
  _1= v_negative;
  if (_1) {
 {
  _2= v_value;
  _2= _bind(_2, s_negated)(_2);
 }
  } else {
 {
  _2= v_value;
 }
  } _1= _2;
  return _1;
 }
}

static int   WordArray__5fsizeof(oop self) { return sizeof(struct t_WordArray); }
static char *WordArray__5fdebugName(oop self) { return "WordArray"; }

static oop WordArray__s_new_(oop self, oop v_newSize)
{
 {
  oop v_array;
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  v_array= _1;
  
      if (_isIntegerObject(v_newSize))
      {
        struct t_WordArray *array= (struct t_WordArray *)v_array;
        array->size= v_newSize;
	array->_elements= (oop)_newBytes(sizeof(long) * _integerValue(v_newSize));
	return v_array;
      }
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop WordArray__s_wordAt_(oop self, oop v_index)
{
 {
  oop _1, _2, _3;
  
      struct t_WordArray *this= (struct t_WordArray *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return _integerObject(((long *)this->_elements)[_integerValue(v_index)]);
    
  ; _1= 0;
  _1= v_index;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorSubscriptBounds_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorNonIntegerIndex_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop WordArray__s_at_(oop self, oop v_index)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_index;
  _1= _bind(_1, s_wordAt_)(_1, _2);
  return _1;
 }
}

static oop WordArray__s_wordAt_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3, _4;
  
      struct t_Array *this= (struct t_Array *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size) && _isIntegerObject(v_anObject))
        {
          ((long *)this->_elements)[_integerValue(v_index)]= _integerValue(v_anObject);
          return v_anObject;
        }
    
  ; _1= 0;
  _1= v_anObject;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= v_index;
  _2= _bind(_2, s_isInteger)(_2);
  if (_2) {
 {
  _3= self;
  _4= v_index;
  _3= _bind(_3, s_errorSubscriptBounds_)(_3, _4);
 }
  } else {
 {
  _3= self;
  _4= v_index;
  _3= _bind(_3, s_errorNonIntegerIndex_)(_3, _4);
 }
  } _2= _3;
 }
  } else {
 {
  _2= self;
  _3= v_anObject;
  _2= _bind(_2, s_errorImproperStore_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop WordArray__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_index;
  _3= v_anObject;
  _1= _bind(_1, s_wordAt_put_)(_1, _2, _3);
  return _1;
 }
}

static oop b_24(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_element;
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_space)(_1);
  return _1;
 }
}

static oop WordArray__s_printOn_(oop self, oop v_aStream)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aStream;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _1= _bind(_1, s_printNameOn_)(_1, _2);
  _1= _state[0];
  _2= l_393;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_24, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= _state[0];
  _3= l_394;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= l_395;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static int   ImmutableWordArray__5fsizeof(oop self) { return sizeof(struct t_ImmutableWordArray); }
static char *ImmutableWordArray__5fdebugName(oop self) { return "ImmutableWordArray"; }

static oop ImmutableWordArray__s_wordAt_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableWordArray__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableWordArray__s_species(oop self)
{
 {
  oop _1;
  _1= v_WordArray;
  return _1;
 }
}

static oop Object__s_isByteArray(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop ByteArray__s_isByteArray(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop ByteArray__s_new_(oop self, oop v_newSize)
{
 {
  oop v_array;
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  v_array= _1;
  
      if (_isIntegerObject(v_newSize))
      {
        struct t_Array *array= (struct t_Array *)v_array;
        array->size= v_newSize;
	array->_elements= (oop)_newBytes(_integerValue(v_newSize));
	return v_array;
      }
    
  ; _1= 0;
  _1= self;
  _1= _bind(_1, s_primitiveFailed)(_1);
  return _1;
 }
}

static oop ByteArray__s_byteAt_(oop self, oop v_index)
{
 {
  oop _1, _2, _3;
  
      struct t_Array *this= (struct t_Array *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size))
        return _integerObject((long)(((unsigned char *)this->_elements)[_integerValue(v_index)]));
    
  ; _1= 0;
  _1= v_index;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorSubscriptBounds_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_errorNonIntegerIndex_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop ByteArray__s_at_(oop self, oop v_index)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_index;
  _1= _bind(_1, s_byteAt_)(_1, _2);
  return _1;
 }
}

static oop ByteArray__s_byteAt_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3, _4;
  
      struct t_Array *this= (struct t_Array *)self;
      if (_isIntegerObject(v_index) && ((unsigned long)v_index < (unsigned long)this->size)
	  && _isIntegerObject(v_anObject) && ((unsigned long)v_anObject < (unsigned long)_integerObject(256)))
        {
          ((unsigned char *)this->_elements)[_integerValue(v_index)]= _integerValue(v_anObject);
          return v_anObject;
        }
    
  ; _1= 0;
  _1= v_anObject;
  _1= _bind(_1, s_isInteger)(_1);
  if (_1) {
 {
  _2= v_anObject;
  _3= l_396;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 >= (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e_3d)(_2, _3);
  if (_2) {
 {
  _3= v_anObject;
  _4= l_397;
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 <= (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3c_3d)(_3, _4);
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= v_index;
  _2= _bind(_2, s_isInteger)(_2);
  if (_2) {
 {
  _3= self;
  _4= v_index;
  _3= _bind(_3, s_errorSubscriptBounds_)(_3, _4);
 }
  } else {
 {
  _3= self;
  _4= v_index;
  _3= _bind(_3, s_errorNonIntegerIndex_)(_3, _4);
 }
  } _2= _3;
 }
  } else {
 {
  _2= self;
  _3= v_anObject;
  _2= _bind(_2, s_errorImproperStore_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop ByteArray__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_index;
  _3= v_anObject;
  _1= _bind(_1, s_byteAt_put_)(_1, _2, _3);
  return _1;
 }
}

static oop ByteArray__s_replaceFrom_to_with_startingAt_(oop self, oop v_start, oop v_stop, oop v_replacement, oop v_repStart)
{
 {
  oop v_length;
  oop v_repEnd;
  oop _1, _2, _3, _4, _5, _6;
  _1= v_stop;
  _2= v_start;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  v_length= _1;
  _1= v_repStart;
  _2= v_length;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_repEnd= _1;
  _1= v_replacement;
  _1= _bind(_1, s_isByteArray)(_1);
  if (_1) {
 {
  _2= v_start;
  _3= l_398;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 >= (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e_3d)(_2, _3);
  if (_2) {
 {
  _3= v_length;
  _4= l_399;
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 >= (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3e_3d)(_3, _4);
  if (_3) {
 {
  _4= v_stop;
  _5= self;
  _5= _bind(_5, s_size)(_5);
  if (_areIntegerObjects(_4, _5))
    _4= ((long)_4 <= (long)_5) ? v_true : v_false;
  else
    _4= _bind(_4, s__3c_3d)(_4, _5);
  if (_4) {
 {
  _5= v_repEnd;
  _6= v_replacement;
  _6= _bind(_6, s_size)(_6);
  if (_areIntegerObjects(_5, _6))
    _5= ((long)_5 <= (long)_6) ? v_true : v_false;
  else
    _5= _bind(_5, s__3c_3d)(_5, _6);
 }
  _4= _5;
  }
 }
  _3= _4;
  }
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  if (_1) {
 {
   memmove(((char *)((struct t_ByteArray *)self)->_elements) + _integerValue(v_start),
	               ((char *)((struct t_ByteArray *)v_replacement)->_elements) + _integerValue(v_repStart),
                       _integerValue(v_length)) 
  ; _2= 0;
 }
  } else {
 {
  _2= self;
  _3= v_start;
  _4= v_stop;
  _5= v_replacement;
  _6= v_repStart;
  _2= _rebind(v_ArrayedCollection, s_replaceFrom_to_with_startingAt_)(_2, _3, _4, _5, _6);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_25(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_element;
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_space)(_1);
  return _1;
 }
}

static oop ByteArray__s_printOn_(oop self, oop v_aStream)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aStream;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _1= _bind(_1, s_printNameOn_)(_1, _2);
  _1= _state[0];
  _2= l_400;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_25, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= _state[0];
  _3= l_401;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= l_402;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ImmutableByteArray__s_byteAt_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableByteArray__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableByteArray__s_species(oop self)
{
 {
  oop _1;
  _1= v_ByteArray;
  return _1;
 }
}

static oop Object__s_isString(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop String__s_isString(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop String__s_at_(oop self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= v_Character;
  _2= self;
  _3= v_index;
  _2= _bind(_2, s_byteAt_)(_2, _3);
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop String__s_at_put_(oop self, oop v_index, oop v_aCharacter)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_index;
  _3= v_aCharacter;
  _3= _bind(_3, s_asciiValue)(_3);
  _1= _bind(_1, s_byteAt_put_)(_1, _2, _3);
  _1= v_aCharacter;
  return _1;
 }
}

static oop String__s_compare_(oop self, oop v_aString)
{
 {
  oop v_chars;
  oop v_len;
  oop v_answer;
  oop _1, _2;
  _1= v_aString;
  _1= _bind(_1, s__5fstringValue)(_1);
  v_chars= _1;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= v_aString;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_min_)(_1, _2);
  v_len= _1;
  {
      struct t_String *this= (struct t_String *)self;
      long answer= memcmp((char *)this->_elements, (char *)v_chars, (size_t)_integerValue(v_len));
      if (!answer)
        {
          struct t_String *other= (struct t_String *)v_aString;
          answer= (unsigned long)this->size < (unsigned long)other->size ? -1 : (this->size == other->size ? 0 : 1);
        }
      v_answer= _integerObject(answer);
    }
  ; _1= 0;
  _1= v_answer;
  return _1;
 }
}

static oop b_26(oop _self, oop v_hash, oop v_char)
{
 {
  oop _1, _2;
  _1= v_hash;
  _2= l_404;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)(((long)_1 & (long)_2) | 1);
  else
    _1= _bind(_1, s_bitAnd_)(_1, _2);
  _2= l_405;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) * _integerValue(_2));
  else
    _1= _bind(_1, s__2a)(_1, _2);
  _2= v_char;
  _2= _bind(_2, s_asciiValue)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  return _1;
 }
}

static oop String__s_hash(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_403;
  _3= c_26;
  _1= _bind(_1, s_inject_into_)(_1, _2, _3);
  return _1;
 }
}

static oop String__s__3c(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_compare_)(_1, _2);
  _2= l_406;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  return _1;
 }
}

static oop String__s__3c_3d(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_compare_)(_1, _2);
  _2= l_407;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 <= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c_3d)(_1, _2);
  return _1;
 }
}

static oop String__s__3d(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_compare_)(_1, _2);
  _2= l_408;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop String__s__3e_3d(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_compare_)(_1, _2);
  _2= l_409;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 >= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e_3d)(_1, _2);
  return _1;
 }
}

static oop String__s__3e(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_compare_)(_1, _2);
  _2= l_410;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  return _1;
 }
}

static oop b_27(oop _self)
{
 {
  oop _1;
  _1= v_false;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_29(oop _self)
{
 {
  oop _1;
  _1= v_false;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_28(oop _self, oop v_index)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_index;
  _1= _bind(_1, s_at_)(_1, _2);
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_29, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_ifFalse_)(_1, _2);
  return _1;
 }
}

static oop String__s_beginsWith_(oop self, oop v_prefix)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_prefix;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= _state[0];
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_27, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= l_411;
  _2= _state[0];
  _2= _bind(_2, s_size)(_2);
  _3= l_412;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_28, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= v_true;
  return _1;
 }
}

static oop String__s__5fcString(oop self)
{
 {
  oop _1;
  
  struct t_String *this= (struct t_String *)self;
  int size= _integerValue(this->size);
  char *elements= (char *)this->_elements;
  char *cString= (char *)_newBytes(size + 1);
  memcpy(cString, elements, size);
  cString[size]= '\0';
  return (oop)cString;

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_30(oop _self, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_index;
  _3= ((struct t_BlockClosure *)_self)->receiver;
  _4= v_index;
  _3= _bind(_3, s_byteAt_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop String__s_asByteArray(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3;
  _1= v_ByteArray;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= l_413;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _3= l_414;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_30, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= _state[0];
  return _1;
 }
}

static oop String__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_415;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= self;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_416;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ImmutableString__s_at_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_errorCannotModify)(_1);
  return _1;
 }
}

static oop ImmutableString__s_species(oop self)
{
 {
  oop _1;
  _1= v_String;
  return _1;
 }
}

static oop Integer__s_hex2(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_String;
  _2= l_417;
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_418;
  _3= v_Character;
  _4= self;
  _5= l_419;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_420;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_421;
  _3= v_Character;
  _4= self;
  _5= l_422;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static oop Integer__s_hex8(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_String;
  _2= l_423;
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_424;
  _3= v_Character;
  _4= self;
  _5= l_425;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_426;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_427;
  _3= v_Character;
  _4= self;
  _5= l_428;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_429;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_430;
  _3= v_Character;
  _4= self;
  _5= l_431;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_432;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_433;
  _3= v_Character;
  _4= self;
  _5= l_434;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_435;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_436;
  _3= v_Character;
  _4= self;
  _5= l_437;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_438;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_439;
  _3= v_Character;
  _4= self;
  _5= l_440;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_441;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_442;
  _3= v_Character;
  _4= self;
  _5= l_443;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_444;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_445;
  _3= v_Character;
  _4= self;
  _5= l_446;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static oop Integer__s_octal3(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_String;
  _2= l_447;
  _1= _bind(_1, s_new_)(_1, _2);
  _2= l_448;
  _3= v_Character;
  _4= self;
  _5= l_449;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_450;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_451;
  _3= v_Character;
  _4= self;
  _5= l_452;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) / _integerValue(_5));
  else
    _4= _bind(_4, s__2f_2f)(_4, _5);
  _5= l_453;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_454;
  _3= v_Character;
  _4= self;
  _5= l_455;
  if (_areIntegerObjects(_4, _5))
    _4= _integerObject(_integerValue(_4) % _integerValue(_5));
  else
    _4= _bind(_4, s__5c_5c)(_4, _5);
  _3= _bind(_3, s_digitValue_)(_3, _4);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _1= _bind(_1, s_yourself)(_1);
  return _1;
 }
}

static int   Set__5fsizeof(oop self) { return sizeof(struct t_Set); }
static char *Set__5fdebugName(oop self) { return "Set"; }

static oop Set__s_new_(oop self, oop v_size)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= l_456;
  ((struct t_Set *)self)->tally= _1;
  _1= v_Array;
  _2= v_size;
  _1= _bind(_1, s_new_)(_1, _2);
  ((struct t_Set *)self)->array= _1;
  _1= self;
  return _1;
 }
}

static oop Set__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t_Set *)self)->tally;
  return _1;
 }
}

static oop Set__s_add_(oop self, oop v_newObject)
{
 {
  oop v_index;
  oop _1, _2, _3, _4;
  _1= v_newObject;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= l_457;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_newObject;
  _1= _bind(_1, s_findElementOrNil_)(_1, _2);
  v_index= _1;
  _1= ((struct t_Set *)self)->array;
  _2= v_index;
  _1= _bind(_1, s_at_)(_1, _2);
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_index;
  _4= v_newObject;
  _2= _bind(_2, s_atNewIndex_put_)(_2, _3, _4);
 }
  _1= _2;
  } else _1= 0;
  _1= v_newObject;
  return _1;
 }
}

static oop Set__s_findElementOrNil_(oop self, oop v_anObject)
{
 {
  oop v_index;
  oop _1, _2, _3;
  _1= self;
  _2= v_anObject;
  _1= _bind(_1, s_scanFor_)(_1, _2);
  v_index= _1;
  _1= v_index;
  _2= l_458;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= self;
  _3= l_459;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_index;
  return _1;
 }
}

static oop b_32(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_31(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_32, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop b_34(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_33(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_34, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop Set__s_scanFor_(oop self, oop v_anObject)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_anObject;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_finish;
  oop v_start;
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _1= _bind(_1, s_size)(_1);
  v_finish= _1;
  _1= _state[1];
  _1= _bind(_1, s_hash)(_1);
  _2= v_finish;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) % _integerValue(_2));
  else
    _1= _bind(_1, s__5c_5c)(_1, _2);
  v_start= _1;
  _1= v_start;
  _2= v_finish;
  _3= l_460;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_31, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_461;
  _2= v_start;
  _3= l_462;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_33, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_463;
  return _1;
 }
}

static oop Set__s_atNewIndex_put_(oop self, oop v_index, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _2= v_index;
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= ((struct t_Set *)self)->tally;
  _2= l_464;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_Set *)self)->tally= _1;
  _1= self;
  _1= _bind(_1, s_fullCheck)(_1);
  _1= self;
  return _1;
 }
}

static oop Set__s_fullCheck(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_Set *)self)->array;
  _1= _bind(_1, s_size)(_1);
  _2= ((struct t_Set *)self)->tally;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  _2= l_465;
  _3= ((struct t_Set *)self)->array;
  _3= _bind(_3, s_size)(_3);
  _4= l_466;
  if (_areIntegerObjects(_3, _4))
    _3= _integerObject(_integerValue(_3) / _integerValue(_4));
  else
    _3= _bind(_3, s__2f_2f)(_3, _4);
  _2= _bind(_2, s_max_)(_2, _3);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_grow)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Set__s_growSize(oop self)
{
 {
  oop _1, _2, _3;
  _1= l_467;
  _2= ((struct t_Set *)self)->array;
  _2= _bind(_2, s_size)(_2);
  _3= l_468;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_max_)(_1, _2);
  return _1;
 }
}

static oop b_35(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_element;
  _2= _bind(_2, s_noCheckAdd_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop Set__s_grow(oop self)
{
 {
  oop v_oldElements;
  oop v_oldSize;
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  v_oldElements= _1;
  _1= ((struct t_Set *)self)->array;
  _1= _bind(_1, s_size)(_1);
  v_oldSize= _1;
  _1= v_Array;
  _2= v_oldSize;
  _3= self;
  _3= _bind(_3, s_growSize)(_3);
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_new_)(_1, _2);
  ((struct t_Set *)self)->array= _1;
  _1= l_469;
  ((struct t_Set *)self)->tally= _1;
  _1= v_oldElements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_35, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Set__s_noCheckAdd_(oop self, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _2= self;
  _3= v_anObject;
  _2= _bind(_2, s_findElementOrNil_)(_2, _3);
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= ((struct t_Set *)self)->tally;
  _2= l_470;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_Set *)self)->tally= _1;
  _1= self;
  return _1;
 }
}

static oop b_36(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= v_element;
  _2= _bind(_2, s_value_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop Set__s_do_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unaryBlock;
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->tally;
  _2= l_471;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (!_1) {
 {
  _2= ((struct t_Set *)self)->array;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_36, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Set__s_like_(oop self, oop v_anObject)
{
 {
  oop v_index;
  oop _1, _2, _3;
  _1= self;
  _2= v_anObject;
  _1= _bind(_1, s_scanFor_)(_1, _2);
  v_index= _1;
  _1= v_index;
  _2= l_472;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (!_1) {
 {
  _2= ((struct t_Set *)self)->array;
  _3= v_index;
  _2= _bind(_2, s_at_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static int   IdentitySet__5fsizeof(oop self) { return sizeof(struct t_IdentitySet); }
static char *IdentitySet__5fdebugName(oop self) { return "IdentitySet"; }

static oop b_38(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_37(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop v_element;
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  v_element= _1;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= v_element;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_38, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop b_40(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_39(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop v_element;
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  v_element= _1;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= v_element;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_40, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop IdentitySet__s_scanFor_(oop self, oop v_anObject)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_anObject;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_start;
  oop v_finish;
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _1= _bind(_1, s_size)(_1);
  v_finish= _1;
  _1= _state[0];
  _1= _bind(_1, s_identityHash)(_1);
  _2= v_finish;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) % _integerValue(_2));
  else
    _1= _bind(_1, s__5c_5c)(_1, _2);
  v_start= _1;
  _1= v_start;
  _2= v_finish;
  _3= l_473;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_37, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_474;
  _2= v_start;
  _3= l_475;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_39, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_476;
  return _1;
 }
}

static int   Dictionary__5fsizeof(oop self) { return sizeof(struct t_Dictionary); }
static char *Dictionary__5fdebugName(oop self) { return "Dictionary"; }

static oop Dictionary__s_noCheckAdd_(oop self, oop v_anObject)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _2= self;
  _3= v_anObject;
  _3= _bind(_3, s_key)(_3);
  _2= _bind(_2, s_findElementOrNil_)(_2, _3);
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= ((struct t_Set *)self)->tally;
  _2= l_477;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_Set *)self)->tally= _1;
  _1= self;
  return _1;
 }
}

static oop Dictionary__s_at_ifAbsent_(oop self, oop v_key, oop v_aBlock)
{
 {
  oop v_association;
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _2= self;
  _3= v_key;
  _2= _bind(_2, s_findElementOrNil_)(_2, _3);
  _1= _bind(_1, s_at_)(_1, _2);
  v_association= _1;
  _1= v_association;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= v_association;
  _2= _bind(_2, s_value)(_2);
 }
  } else {
 {
  _2= v_aBlock;
  _2= _bind(_2, s_value)(_2);
 }
  } _1= _2;
  return _1;
 }
}

static oop b_41(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_errorKeyNotFound)(_1);
  return _1;
 }
}

static oop Dictionary__s_at_(oop self, oop v_key)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_key;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_41, 0, self, 0, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop Dictionary__s_at_put_(oop self, oop v_key, oop v_anObject)
{
 {
  oop v_index;
  oop v_association;
  oop _1, _2, _3, _4, _5, _6;
  _1= self;
  _2= v_key;
  _1= _bind(_1, s_findElementOrNil_)(_1, _2);
  v_index= _1;
  _1= ((struct t_Set *)self)->array;
  _2= v_index;
  _1= _bind(_1, s_at_)(_1, _2);
  v_association= _1;
  _1= v_association;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= v_association;
  _3= v_anObject;
  _2= _bind(_2, s_value_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_index;
  _4= v_Association;
  _5= v_key;
  _6= v_anObject;
  _4= _bind(_4, s_key_value_)(_4, _5, _6);
  _2= _bind(_2, s_atNewIndex_put_)(_2, _3, _4);
 }
  } _1= _2;
  _1= v_anObject;
  return _1;
 }
}

static oop Dictionary__s_includesKey_(oop self, oop v_aKey)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _2= self;
  _3= v_aKey;
  _2= _bind(_2, s_findElementOrNil_)(_2, _3);
  _1= _bind(_1, s_at_)(_1, _2);
  _1= _bind(_1, s_notNil)(_1);
  return _1;
 }
}

static oop b_42(oop _self, oop v_key)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_key;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop Dictionary__s_keys(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_Set;
  _2= ((struct t_Set *)self)->array;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_42, 1, self, _state, 0);
  _1= _bind(_1, s_keysDo_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static oop Dictionary__s_associationsDo_(oop self, oop v_unaryBlock)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_unaryBlock;
  _1= _rebind(v_Set, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_43(oop _self, oop v_association)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_association;
  _2= _bind(_2, s_key)(_2);
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop Dictionary__s_keysDo_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unaryBlock;
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_43, 1, self, _state, 0);
  _1= _bind(_1, s_associationsDo_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_44(oop _self, oop v_association)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_association;
  _2= _bind(_2, s_value)(_2);
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop Dictionary__s_do_(oop self, oop v_unaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unaryBlock;
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_44, 1, self, _state, 0);
  _1= _bind(_1, s_associationsDo_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_45(oop _self, oop v_association)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_association;
  _2= _bind(_2, s_key)(_2);
  _3= v_association;
  _3= _bind(_3, s_value)(_3);
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  return _1;
 }
}

static oop Dictionary__s_keysAndValuesDo_(oop self, oop v_binaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_binaryBlock;
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_45, 1, self, _state, 0);
  _1= _bind(_1, s_associationsDo_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_46(oop _self, oop v_x, oop v_y)
{
 {
  oop _1, _2;
  _1= v_x;
  _1= _bind(_1, s_value)(_1);
  _2= v_y;
  _2= _bind(_2, s_value)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  return _1;
 }
}

static oop b_47(oop _self, oop v_assoc)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_assoc;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop b_48(oop _self, oop v_assoc)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= v_assoc;
  _2= _bind(_2, s_key)(_2);
  _3= v_assoc;
  _3= _bind(_3, s_value)(_3);
  _1= _bind(_1, s_value_value_)(_1, _2, _3);
  return _1;
 }
}

static oop Dictionary__s_keysAndSortedValuesDo_(oop self, oop v_binaryBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_binaryBlock;
 {
  oop _1, _2;
  _1= v_SortedCollection;
  _2= self;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= _state[0];
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_46, 2, self, _state, 0);
  _1= _bind(_1, s_sortBlock_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_47, 1, self, _state, 0);
  _1= _bind(_1, s_associationsDo_)(_1, _2);
  _1= _state[0];
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_48, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_49(oop _self, oop v_key)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_key;
  _bind(_1, s_print_)(_1, _2);
  _2= l_479;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_key;
  _2= _bind(_2, s_at_)(_2, _3);
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_space)(_1);
  return _1;
 }
}

static oop Dictionary__s_printElementsOn_(oop self, oop v_aStream)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aStream;
 {
  oop _1, _2, _3;
  _1= _state[0];
  _2= l_478;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_49, 1, self, _state, 0);
  _1= _bind(_1, s_keysDo_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= _state[0];
  _3= l_480;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= l_481;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static int   IdentityDictionary__5fsizeof(oop self) { return sizeof(struct t_IdentityDictionary); }
static char *IdentityDictionary__5fdebugName(oop self) { return "IdentityDictionary"; }

static oop b_51(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_50(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop v_element;
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  v_element= _1;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= v_element;
  _2= _bind(_2, s_key)(_2);
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_51, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop b_53(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_52(oop _self, oop v_index)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_index;
 {
  oop v_element;
  oop _1, _2, _3;
  _1= ((struct t_Set *)((struct t_BlockClosure *)_self)->receiver)->array;
  _2= _state[0];
  _1= _bind(_1, s_at_)(_1, _2);
  v_element= _1;
  _1= v_element;
  _1= _bind(_1, s_isNil)(_1);
  if (!_1) {
 {
  _2= v_element;
  _2= _bind(_2, s_key)(_2);
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_53, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop IdentityDictionary__s_scanFor_(oop self, oop v_anObject)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_anObject;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_start;
  oop v_finish;
  oop _1, _2, _3;
  _1= ((struct t_Set *)self)->array;
  _1= _bind(_1, s_size)(_1);
  v_finish= _1;
  _1= _state[0];
  _1= _bind(_1, s_identityHash)(_1);
  _2= v_finish;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) % _integerValue(_2));
  else
    _1= _bind(_1, s__5c_5c)(_1, _2);
  v_start= _1;
  _1= v_start;
  _2= v_finish;
  _3= l_482;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_50, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_483;
  _2= v_start;
  _3= l_484;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_52, 1, self, _state, &_env);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= l_485;
  return _1;
 }
}

static oop b_54(oop _self, oop v_key)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_key;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop IdentityDictionary__s_keys(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_IdentitySet;
  _2= ((struct t_Set *)self)->array;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_54, 1, self, _state, 0);
  _1= _bind(_1, s_keysDo_)(_1, _2);
  _1= _state[0];
  return _1;
 }
}

static int   Symbol__5fsizeof(oop self) { return sizeof(struct t_Symbol); }
static char *Symbol__5fdebugName(oop self) { return "Symbol"; }

static oop Symbol__s_new_(oop self, oop v_newSize)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_newSize;
  _1= _rebind(v_String, s_new_)(_1, _2);
  self= _1;
  _1= self;
  return _1;
 }
}

static oop b_55(oop _self, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_index;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _4= v_index;
  _3= _bind(_3, s_at_)(_3, _4);
  _1= _rebind(v_String, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Symbol__s_string_(oop self, oop v_aString)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aString;
 {
  oop _1, _2, _3;
  _1= l_486;
  _2= _state[0];
  _2= _bind(_2, s_size)(_2);
  _3= l_487;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_55, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static int   SymbolTable__5fsizeof(oop self) { return sizeof(struct t_SymbolTable); }
static char *SymbolTable__5fdebugName(oop self) { return "SymbolTable"; }

static oop Symbol__s_intern_(oop self, oop v_aStringOrSymbol)
{
 {
  oop v_symbol;
  oop _1, _2, _3, _4;
  _1= v_SymbolTable;
  _2= v_aStringOrSymbol;
  _1= _bind(_1, s_like_)(_1, _2);
  v_symbol= _1;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= v_symbol;
 }
  } else {
 {
  _2= v_SymbolTable;
  _3= self;
  _4= v_aStringOrSymbol;
  _4= _bind(_4, s_size)(_4);
  _3= _bind(_3, s_new_)(_3, _4);
  _4= v_aStringOrSymbol;
  _3= _bind(_3, s_string_)(_3, _4);
  _2= _bind(_2, s_add_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop Symbol__s__5fvalue_(oop self, oop v__value)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_String;
  _3= v__value;
  _2= _bind(_2, s__5fvalue_)(_2, _3);
  _1= _bind(_1, s_intern_)(_1, _2);
  return _1;
 }
}

static oop String__s_asSymbol(oop self)
{
 {
  oop _1, _2;
  _1= v_Symbol;
  _2= self;
  _1= _bind(_1, s_intern_)(_1, _2);
  return _1;
 }
}

static int   SelectorTable__5fsizeof(oop self) { return sizeof(struct t_SelectorTable); }
static char *SelectorTable__5fdebugName(oop self) { return "SelectorTable"; }

static oop SelectorTable__s_intern_(oop self, oop v_aSymbol)
{
 {
  oop v_selector;
  oop _1, _2, _3;
  
      struct t_String *symbol= (struct t_String *)v_aSymbol;
      int size= _integerValue(symbol->size);
      char *elements= (char *)symbol->_elements;
      char *buf= (char *)alloca(size + 1);
      memcpy(buf, elements, size);
      buf[size]= '\0';
      v_selector= (oop)_selector(buf);
    
  ; _1= 0;
  _1= self;
  _2= v_aSymbol;
  _3= v_selector;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Object__s__5fperform_(oop self, oop v_sel)
{
 {
  oop _1;
  
  return _rebind(self, (sel_t)v_sel)(self);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_56(oop _self)
{
 {
  oop _1, _2;
  _1= v_SelectorTable;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_intern_)(_1, _2);
  return _1;
 }
}

static oop Object__s_perform_(oop self, oop v_aSymbol)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aSymbol;
 {
  oop _1, _2, _3, _4;
  _1= self;
  _2= v_SelectorTable;
  _3= _state[0];
  _4= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_56, 0, self, _state, 0);
  _2= _bind(_2, s_at_ifAbsent_)(_2, _3, _4);
  _1= _bind(_1, s__5fperform_)(_1, _2);
  return _1;
 }
}

static oop Object__s__5fperform_with_(oop self, oop v_sel, oop v_a)
{
 {
  oop _1;
  
  return _rebind(self, (sel_t)v_sel)(self, v_a);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_57(oop _self)
{
 {
  oop _1, _2;
  _1= v_SelectorTable;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_intern_)(_1, _2);
  return _1;
 }
}

static oop Object__s_perform_with_(oop self, oop v_aSymbol, oop v_a)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aSymbol;
 {
  oop _1, _2, _3, _4;
  _1= self;
  _2= v_SelectorTable;
  _3= _state[0];
  _4= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_57, 0, self, _state, 0);
  _2= _bind(_2, s_at_ifAbsent_)(_2, _3, _4);
  _3= v_a;
  _1= _bind(_1, s__5fperform_with_)(_1, _2, _3);
  return _1;
 }
}

static int   Stream__5fsizeof(oop self) { return sizeof(struct t_Stream); }
static char *Stream__5fdebugName(oop self) { return "Stream"; }

static oop b_58(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= v_element;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  return _1;
 }
}

static oop Stream__s_nextPutAll_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= v_aCollection;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_58, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Stream__s_nextPut_(oop self, oop v_anObject)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  return _1;
 }
}

static oop Stream__s_print_(oop self, oop v_anObject)
{
 {
  oop _1, _2;
  _1= v_anObject;
  _2= self;
  _1= _bind(_1, s_printOn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Stream__s_isEmpty(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_size)(_1);
  _2= l_489;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop Stream__s_notEmpty(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_isEmpty)(_1);
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop Stream__s_contents(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_subclassResponsibility)(_1);
  return _1;
 }
}

static int   PositionableStream__5fsizeof(oop self) { return sizeof(struct t_PositionableStream); }
static char *PositionableStream__5fdebugName(oop self) { return "PositionableStream"; }

static oop PositionableStream__s_on_(oop self, oop v_aCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_aCollection;
  ((struct t_PositionableStream *)self)->collection= _1;
  _1= v_aCollection;
  _1= _bind(_1, s_size)(_1);
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= l_490;
  ((struct t_PositionableStream *)self)->position= _1;
  _1= self;
  _1= _bind(_1, s_reset)(_1);
  _1= self;
  return _1;
 }
}

static oop PositionableStream__s_reset(oop self)
{
 {
  oop _1;
  _1= l_491;
  ((struct t_PositionableStream *)self)->position= _1;
  _1= self;
  return _1;
 }
}

static oop PositionableStream__s_atEnd(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_PositionableStream *)self)->position;
  _2= ((struct t_PositionableStream *)self)->readLimit;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 >= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e_3d)(_1, _2);
  return _1;
 }
}

static oop PositionableStream__s_position_(oop self, oop v_anInteger)
{
 {
  oop _1, _2, _3;
  _1= v_anInteger;
  _2= l_492;
  _3= ((struct t_PositionableStream *)self)->readLimit;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (_1) {
 {
  _2= v_anInteger;
  ((struct t_PositionableStream *)self)->position= _2;
 }
  } else {
 {
  _2= self;
  _2= _bind(_2, s_positionError)(_2);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop PositionableStream__s_skip_(oop self, oop v_anInteger)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= ((struct t_PositionableStream *)self)->position;
  _3= v_anInteger;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_position_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop PositionableStream__s_size(oop self)
{
 {
  oop _1;
  _1= ((struct t_PositionableStream *)self)->readLimit;
  return _1;
 }
}

static oop PositionableStream__s_contents(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_PositionableStream *)self)->collection;
  _2= l_493;
  _3= ((struct t_PositionableStream *)self)->readLimit;
  _1= _bind(_1, s_copyFrom_to_)(_1, _2, _3);
  return _1;
 }
}

static oop PositionableStream__s_collection(oop self)
{
 {
  oop _1;
  _1= ((struct t_PositionableStream *)self)->collection;
  return _1;
 }
}

static oop b_59(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop PositionableStream__s_peek(oop self)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_nextObject;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_atEnd)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_59, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  v_nextObject= _1;
  _1= ((struct t_PositionableStream *)self)->position;
  _2= l_494;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  ((struct t_PositionableStream *)self)->position= _1;
  _1= v_nextObject;
  return _1;
 }
}

static int   ReadStream__5fsizeof(oop self) { return sizeof(struct t_ReadStream); }
static char *ReadStream__5fdebugName(oop self) { return "ReadStream"; }

static oop ReadStream__s_next(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_atEnd)(_1);
  if (!_1) {
 {
  oop v_object;
  _2= ((struct t_PositionableStream *)self)->collection;
  _3= ((struct t_PositionableStream *)self)->position;
  _2= _bind(_2, s_at_)(_2, _3);
  v_object= _2;
  _2= ((struct t_PositionableStream *)self)->position;
  _3= l_495;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_PositionableStream *)self)->position= _2;
  _2= v_object;
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop ReadStream__s_readStream(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop SequenceableCollection__s_readStream(oop self)
{
 {
  oop _1, _2;
  _1= v_ReadStream;
  _2= self;
  _1= _bind(_1, s_on_)(_1, _2);
  return _1;
 }
}

static int   WriteStream__5fsizeof(oop self) { return sizeof(struct t_WriteStream); }
static char *WriteStream__5fdebugName(oop self) { return "WriteStream"; }

static oop WriteStream__s_reset(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_PositionableStream *)self)->readLimit;
  _2= ((struct t_PositionableStream *)self)->position;
  _1= _bind(_1, s_max_)(_1, _2);
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= self;
  _1= _rebind(v_PositionableStream, s_reset)(_1);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_resetToStart(oop self)
{
 {
  oop _1;
  _1= l_496;
  ((struct t_PositionableStream *)self)->position= _1;
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_on_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aCollection;
  _1= _rebind(v_PositionableStream, s_on_)(_1, _2);
  self= _1;
  _1= l_497;
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= l_498;
  ((struct t_WriteStream *)self)->writeLimit= _1;
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_nextPut_(oop self, oop v_anObject)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_PositionableStream *)self)->position;
  _2= ((struct t_WriteStream *)self)->writeLimit;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 >= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e_3d)(_1, _2);
  if (_1) {
 {
  _2= self;
  _3= v_anObject;
  _2= _bind(_2, s_pastEndPut_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_PositionableStream *)self)->collection;
  _3= ((struct t_PositionableStream *)self)->position;
  _4= l_499;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  ((struct t_PositionableStream *)self)->position= _3;
  _4= l_500;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 - (long)_4 + 1);
  else
    _3= _bind(_3, s__2d)(_3, _4);
  _4= v_anObject;
  _2= _bind(_2, s_at_put_)(_2, _3, _4);
 }
  } _1= _2;
  return _1;
 }
}

static oop WriteStream__s_pastEndPut_(oop self, oop v_anObject)
{
 {
  oop v_oldSize;
  oop v_grownCollection;
  oop _1, _2, _3, _4, _5;
  _1= ((struct t_PositionableStream *)self)->collection;
  _1= _bind(_1, s_size)(_1);
  v_oldSize= _1;
  _1= ((struct t_PositionableStream *)self)->collection;
  _2= v_oldSize;
  _3= v_oldSize;
  _4= l_501;
  _3= _bind(_3, s_max_)(_3, _4);
  _4= l_502;
  _3= _bind(_3, s_min_)(_3, _4);
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  _1= _bind(_1, s_new_)(_1, _2);
  v_grownCollection= _1;
  _1= v_grownCollection;
  _2= l_503;
  _3= v_oldSize;
  _4= ((struct t_PositionableStream *)self)->collection;
  _5= l_504;
  _1= _bind(_1, s_replaceFrom_to_with_startingAt_)(_1, _2, _3, _4, _5);
  ((struct t_PositionableStream *)self)->collection= _1;
  _1= ((struct t_PositionableStream *)self)->collection;
  _1= _bind(_1, s_size)(_1);
  ((struct t_WriteStream *)self)->writeLimit= _1;
  _1= ((struct t_PositionableStream *)self)->collection;
  _2= ((struct t_PositionableStream *)self)->position;
  _3= l_505;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_PositionableStream *)self)->position= _2;
  _3= l_506;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= v_anObject;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop WriteStream__s_size(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_PositionableStream *)self)->readLimit;
  _2= ((struct t_PositionableStream *)self)->position;
  _1= _bind(_1, s_max_)(_1, _2);
  ((struct t_PositionableStream *)self)->readLimit= _1;
  return _1;
 }
}

static oop WriteStream__s_tab(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_507;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_nl(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_508;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_cr(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_509;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_space(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_510;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_60(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_tab)(_1);
  return _1;
 }
}

static oop WriteStream__s_tab_(oop self, oop v_n)
{
 {
  oop _1, _2;
  _1= v_n;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_60, 0, self, 0, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_61(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop WriteStream__s_nl_(oop self, oop v_n)
{
 {
  oop _1, _2;
  _1= v_n;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_61, 0, self, 0, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_62(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_cr)(_1);
  return _1;
 }
}

static oop WriteStream__s_cr_(oop self, oop v_n)
{
 {
  oop _1, _2;
  _1= v_n;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_62, 0, self, 0, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_63(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_space)(_1);
  return _1;
 }
}

static oop WriteStream__s_space_(oop self, oop v_n)
{
 {
  oop _1, _2;
  _1= v_n;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_63, 0, self, 0, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_contents(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_PositionableStream *)self)->readLimit;
  _2= ((struct t_PositionableStream *)self)->position;
  _1= _bind(_1, s_max_)(_1, _2);
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= self;
  _1= _rebind(v_PositionableStream, s_contents)(_1);
  return _1;
 }
}

static oop WriteStream__s_position_(oop self, oop v_anInteger)
{
 {
  oop _1, _2;
  _1= ((struct t_PositionableStream *)self)->readLimit;
  _2= ((struct t_PositionableStream *)self)->position;
  _1= _bind(_1, s_max_)(_1, _2);
  ((struct t_PositionableStream *)self)->readLimit= _1;
  _1= self;
  _2= v_anInteger;
  _1= _rebind(v_PositionableStream, s_position_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WriteStream__s_writeStream(oop self)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop SequenceableCollection__s_writeStream(oop self)
{
 {
  oop _1, _2;
  _1= v_WriteStream;
  _2= self;
  _1= _bind(_1, s_on_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_firstToken_(oop self, oop v_delimiters)
{
 {
  oop v_in;
  oop v_out;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_readStream)(_1);
  v_in= _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  _1= _bind(_1, s_writeStream)(_1);
  v_out= _1;
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
  _1= _bind(_1, s_not)(_1);
  if (_1) {
 {
  _2= v_delimiters;
  _3= v_in;
  _3= _bind(_3, s_peek)(_3);
  _2= _bind(_2, s_includes_)(_2, _3);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= v_in;
  _1= _bind(_1, s_next)(_1);
 }
  };
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
  _1= _bind(_1, s_not)(_1);
  if (_1) {
 {
  _2= v_delimiters;
  _3= v_in;
  _3= _bind(_3, s_peek)(_3);
  _2= _bind(_2, s_includes_)(_2, _3);
  _2= _bind(_2, s_not)(_2);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= v_out;
  _2= v_in;
  _2= _bind(_2, s_next)(_2);
  _1= _bind(_1, s_nextPut_)(_1, _2);
 }
  };
  _1= v_out;
  _1= _bind(_1, s_contents)(_1);
  return _1;
 }
}

static oop SequenceableCollection__s_tokenised_(oop self, oop v_delimiters)
{
 {
  oop v_in;
  oop v_out;
  oop v_tokens;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_readStream)(_1);
  v_in= _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  _1= _bind(_1, s_writeStream)(_1);
  v_out= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_tokens= _1;
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
 }
  if (_1) break;
 {
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
  _1= _bind(_1, s_not)(_1);
  if (_1) {
 {
  _2= v_delimiters;
  _3= v_in;
  _3= _bind(_3, s_peek)(_3);
  _2= _bind(_2, s_includes_)(_2, _3);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= v_in;
  _1= _bind(_1, s_next)(_1);
 }
  };
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
  _1= _bind(_1, s_not)(_1);
  if (_1) {
 {
  _2= v_delimiters;
  _3= v_in;
  _3= _bind(_3, s_peek)(_3);
  _2= _bind(_2, s_includes_)(_2, _3);
  _2= _bind(_2, s_not)(_2);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= v_out;
  _2= v_in;
  _2= _bind(_2, s_next)(_2);
  _1= _bind(_1, s_nextPut_)(_1, _2);
 }
  };
  _1= v_out;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= v_tokens;
  _3= v_out;
  _3= _bind(_3, s_contents)(_3);
  _2= _bind(_2, s_add_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_out;
  _1= _bind(_1, s_resetToStart)(_1);
 }
  };
  _1= v_tokens;
  return _1;
 }
}

static oop b_64(oop _self, oop v_element)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  if (_1) {
 {
  _2= v_false;
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _2;
 }
  } else {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[2];
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } _1= _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= v_element;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_delimited_(oop self, oop v_delimiter)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 3);
  _state[2]= v_delimiter;
 {
  oop _1, _2;
  _1= v_Array;
  _2= l_511;
  _1= _bind(_1, s_new_)(_1, _2);
  _1= _bind(_1, s_writeStream)(_1);
  _state[1]= _1;
  _1= v_true;
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_64, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[1];
  _1= _bind(_1, s_contents)(_1);
  return _1;
 }
}

static oop b_65(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_element;
  _2= _bind(_2, s_size)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  return _1;
 }
}

static oop b_66(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= v_element;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  return _1;
 }
}

static oop SequenceableCollection__s_flattened(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_emptyCheck)(_1);
  _1= l_512;
  _state[0]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_65, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_species)(_1);
  _2= _state[0];
  _1= _bind(_1, s_new_)(_1, _2);
  _1= _bind(_1, s_writeStream)(_1);
  _state[1]= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_66, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[1];
  _1= _bind(_1, s_contents)(_1);
  return _1;
 }
}

static int   Smalltalk__5fsizeof(oop self) { return sizeof(struct t_Smalltalk); }
static char *Smalltalk__5fdebugName(oop self) { return "Smalltalk"; }

static oop Smalltalk__s_quit(oop self)
{
 {
  oop _1;
  
  exit(0);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Smalltalk__s_abort(oop self)
{
 {
  oop _1;
  
  fflush(stdout);
  fprintf(stderr, "\nSmalltalk abort\n");
  fflush(stderr);
  abort();

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Smalltalk__s_argumentCount(oop self)
{
 {
  oop _1;
  
  return _integerObject((long)_argc);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_67(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Smalltalk__s_argumentAt_(oop self, oop v_index)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v__value;
  oop _1, _2;
  _1= v_index;
  _2= self;
  _2= _bind(_2, s_argumentCount)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 >= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e_3d)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_67, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
   v__value= (oop)_argv[_integerValue(v_index)] 
  ; _1= 0;
  _1= v_String;
  _2= v__value;
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop b_68(oop _self, oop v_index)
{
 {
  oop _1, _2, _3, _4;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_index;
  _3= ((struct t_BlockClosure *)_self)->receiver;
  _4= v_index;
  _3= _bind(_3, s_argumentAt_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Smalltalk__s_arguments(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop v_argc;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_argumentCount)(_1);
  v_argc= _1;
  _1= v_Array;
  _2= v_argc;
  _1= _bind(_1, s_new_)(_1, _2);
  _state[0]= _1;
  _1= l_513;
  _2= v_argc;
  _3= l_514;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_68, 1, self, _state, 0);
  _1= _bind(_1, s_to_do_)(_1, _2, _3);
  _1= _state[0];
  return _1;
 }
}

static oop Smalltalk__s_osError(oop self)
{
 {
  oop _1;
  
  return _integerObject((long)errno);

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Smalltalk__s__5fosErrorString_(oop self, oop v_errno)
{
 {
  oop _1;
  
  return (oop)strerror(_integerValue(v_errno));

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Smalltalk__s_osErrorString_(oop self, oop v_errno)
{
 {
  oop _1, _2, _3;
  _1= v_String;
  _2= self;
  _3= v_errno;
  _2= _bind(_2, s__5fosErrorString_)(_2, _3);
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop Smalltalk__s_osErrorString(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= self;
  _2= _bind(_2, s_osError)(_2);
  _1= _bind(_1, s_osErrorString_)(_1, _2);
  return _1;
 }
}

static oop Smalltalk__s_garbageCollect(oop self)
{
 {
  oop _1;
  
  GC_gcollect();

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop Smalltalk__s_bytesFree(oop self)
{
 {
  oop _1;
  
  return _integerObject(GC_get_heap_size());

  ; _1= 0;
  _1= self;
  return _1;
 }
}

static int   GetOpt__5fsizeof(oop self) { return sizeof(struct t_GetOpt); }
static char *GetOpt__5fdebugName(oop self) { return "GetOpt"; }

static oop b_69(oop _self, oop v_arg)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop GetOpt__s_new(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_IdentityDictionary, s_new)(_1);
  self= _1;
  _1= c_69;
  ((struct t_GetOpt *)self)->defaultBlock= _1;
  _1= self;
  return _1;
 }
}

static oop GetOpt__s_default_(oop self, oop v_unaryBlock)
{
 {
  oop _1;
  _1= v_unaryBlock;
  ((struct t_GetOpt *)self)->defaultBlock= _1;
  _1= self;
  return _1;
 }
}

static oop GetOpt__s_parse_(oop self, oop v_argumentCollection)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_argumentCollection;
  _3= l_515;
  _1= _bind(_1, s_parse_startingAt_)(_1, _2, _3);
  return _1;
 }
}

static oop GetOpt__s_parse_startingAt_(oop self, oop v_argumentCollection, oop v_offset)
{
 {
  oop v_args;
  oop _1, _2, _3;
  _1= v_argumentCollection;
  _1= _bind(_1, s_readStream)(_1);
  _2= v_offset;
  _1= _bind(_1, s_skip_)(_1, _2);
  v_args= _1;
  for (;;) {
 {
  _1= v_args;
  _1= _bind(_1, s_atEnd)(_1);
 }
  if (_1) break;
 {
  oop v_arg;
  _1= v_args;
  _1= _bind(_1, s_next)(_1);
  v_arg= _1;
  _1= self;
  _2= v_arg;
  _3= v_args;
  _1= _bind(_1, s_parseArgument_with_)(_1, _2, _3);
 }
  };
  _1= self;
  return _1;
 }
}

static oop GetOpt__s_parseArgument_with_(oop self, oop v_arg, oop v_rest)
{
 {
  oop _1, _2, _3, _4;
  _1= v_arg;
  _1= _bind(_1, s_first)(_1);
  _2= l_516;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_arg;
  _2= _bind(_2, s_size)(_2);
  _3= l_517;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= self;
  _3= v_arg;
  _4= v_rest;
  _2= _bind(_2, s_parseOption_with_)(_2, _3, _4);
 }
  } else {
 {
  _2= ((struct t_GetOpt *)self)->defaultBlock;
  _3= v_arg;
  _2= _bind(_2, s_value_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_71(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_GetOpt *)((struct t_BlockClosure *)_self)->receiver)->defaultBlock;
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)_self)->outer)->_state)[0];
  _1= _bind(_1, s_value_)(_1, _2);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_70(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= l_518;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_71, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop GetOpt__s_parseOption_with_(oop self, oop v_option, oop v_rest)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_option;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_block;
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= _state[0];
  _2= _bind(_2, s_second)(_2);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_70, 0, self, _state, &_env);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  v_block= _1;
  _1= v_block;
  _1= _bind(_1, s_arity)(_1);
  _2= l_519;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= self;
  _3= _state[0];
  _4= v_block;
  _2= _bind(_2, s_applyOption_to_)(_2, _3, _4);
 }
  } else {
 {
  _2= self;
  _3= _state[0];
  _4= v_block;
  _5= v_rest;
  _2= _bind(_2, s_applyOption_to_with_)(_2, _3, _4, _5);
 }
  } _1= _2;
  return _1;
 }
}

static oop GetOpt__s_applyOption_to_(oop self, oop v_anOption, oop v_unaryBlock)
{
 {
  oop _1, _2, _3, _4;
  _1= v_anOption;
  _1= _bind(_1, s_size)(_1);
  _2= l_520;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_unaryBlock;
  _3= v_anOption;
  _3= _bind(_3, s_second)(_3);
  _2= _bind(_2, s_value_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= l_521;
  _4= v_anOption;
  _3= _bind(_3, s__2c)(_3, _4);
  _4= l_522;
  _3= _bind(_3, s__2c)(_3, _4);
  _2= _bind(_2, s_error_)(_2, _3);
 }
  } _1= _2;
  return _1;
 }
}

static oop GetOpt__s_applyOption_to_with_(oop self, oop v_anOption, oop v_binaryBlock, oop v_rest)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_anOption;
  _1= _bind(_1, s_size)(_1);
  _2= l_523;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= v_rest;
  _2= _bind(_2, s_atEnd)(_2);
  if (_2) {
 {
  _3= self;
  _4= l_524;
  _5= v_anOption;
  _4= _bind(_4, s__2c)(_4, _5);
  _3= _bind(_3, s_error_)(_3, _4);
 }
  } else {
 {
  _3= v_binaryBlock;
  _4= v_anOption;
  _4= _bind(_4, s_second)(_4);
  _5= v_rest;
  _5= _bind(_5, s_next)(_5);
  _3= _bind(_3, s_value_value_)(_3, _4, _5);
 }
  } _2= _3;
 }
  } else {
 {
  _2= v_binaryBlock;
  _3= v_anOption;
  _3= _bind(_3, s_second)(_3);
  _4= v_anOption;
  _5= l_525;
  _4= _bind(_4, s_copyFrom_)(_4, _5);
  _2= _bind(_2, s_value_value_)(_2, _3, _4);
 }
  } _1= _2;
  return _1;
 }
}

static oop String__s_directoryName(oop self)
{
 {
  oop v_dirName;
  oop _1, _2, _3;
  _1= self;
  _2= l_526;
  _1= _bind(_1, s_tokenised_)(_1, _2);
  v_dirName= _1;
  _1= _bind(_1, s_removeLast)(_1);
  _1= v_dirName;
  _1= _bind(_1, s_isEmpty)(_1);
  if (_1) {
 {
  _2= l_527;
 }
  } else {
 {
  _2= v_dirName;
  _3= l_528;
  _2= _bind(_2, s_delimited_)(_2, _3);
  _2= _bind(_2, s_flattened)(_2);
 }
  } _1= _2;
  return _1;
 }
}

static oop String__s_baseName(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_529;
  _1= _bind(_1, s_tokenised_)(_1, _2);
  _1= _bind(_1, s_last)(_1);
  return _1;
 }
}

static oop String__s_absolutePathName(oop self)
{
 {
  oop v_cPath;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s__5fcString)(_1);
  v_cPath= _1;
  {
      char *path= (char *)v_cPath;
      char buf[PATH_MAX];
      if (!realpath(path, buf)) return 0;
      v_cPath= (oop)buf;
    }
  ; _1= 0;
  _1= v_String;
  _2= v_cPath;
  _1= _bind(_1, s__5fvalue_)(_1, _2);
  return _1;
 }
}

static oop String__s_isReadableFile(oop self)
{
 {
  oop v_cPath;
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fcString)(_1);
  v_cPath= _1;
  {
      char *path= (char *)v_cPath;
      if (-1 == access(path, R_OK)) return 0;
    }
  ; _1= 0;
  _1= self;
  return _1;
 }
}

static oop String__s_readFromFileNamed_ifError_(oop self, oop v_path, oop v_errorBlock)
{
 {
  oop v_cPath;
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_path;
  _1= _bind(_1, s__5fcString)(_1);
  v_cPath= _1;
  {
      struct t_String *this= (struct t_String *)self;
      char *path= (char *)v_cPath;
      int fd= open(path, O_RDONLY | O_BINARY);
      if (fd >= 0)
        {
	  int position= 0;
	  int remaining= 0;
          struct stat sb;
          fstat(fd, &sb);
          remaining= sb.st_size;
	  this->_elements= (oop)_newBytes(remaining);
          while (remaining)
            {
	      int count= read(fd, (char *)this->_elements + position, remaining);
              if (count < 1)
                break;
              position += count;
              remaining -= count;
	    }
          close(fd);
          if (!remaining)
            {
              this->size= _integerObject((long)position);
              return self;
            }
        }
    }
  ; _1= 0;
  _1= v_errorBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop b_72(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_530;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_Smalltalk;
  _3= _bind(_3, s_osErrorString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop String__s_readFromFileNamed_(oop self, oop v_path)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_path;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_72, 0, self, _state, 0);
  _1= _bind(_1, s_readFromFileNamed_ifError_)(_1, _2, _3);
  return _1;
 }
}

static oop String__s_writeToFileNamed_ifError_(oop self, oop v_path, oop v_errorBlock)
{
 {
  oop v_cPath;
  oop _1;
  _1= v_path;
  _1= _bind(_1, s__5fcString)(_1);
  v_cPath= _1;
  {
      struct t_String *this= (struct t_String *)self;
      char *path= (char *)v_cPath;
      int fd= open(path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
      if (fd >= 0)
        {
	  int position= 0;
	  int remaining= _integerValue(this->size);
          while (remaining)
            {
	      int count= write(fd, (char *)this->_elements + position, remaining);
              if (count < 1)
                break;
              position += count;
              remaining -= count;
	    }
          close(fd);
          if (!remaining)
            return self;
        }
    }
  ; _1= 0;
  _1= v_errorBlock;
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop b_73(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_531;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_Smalltalk;
  _3= _bind(_3, s_osErrorString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop String__s_writeToFileNamed_(oop self, oop v_path)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_path;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_73, 0, self, _state, 0);
  _1= _bind(_1, s_writeToFileNamed_ifError_)(_1, _2, _3);
  return _1;
 }
}

static int   CompilerOptions__5fsizeof(oop self) { return sizeof(struct t_CompilerOptions); }
static char *CompilerOptions__5fdebugName(oop self) { return "CompilerOptions"; }

static int   Scanner__5fsizeof(oop self) { return sizeof(struct t_Scanner); }
static char *Scanner__5fdebugName(oop self) { return "Scanner"; }

static int   Parser__5fsizeof(oop self) { return sizeof(struct t_Parser); }
static char *Parser__5fdebugName(oop self) { return "Parser"; }

static int   Compiler__5fsizeof(oop self) { return sizeof(struct t_Compiler); }
static char *Compiler__5fdebugName(oop self) { return "Compiler"; }

static int   Scope__5fsizeof(oop self) { return sizeof(struct t_Scope); }
static char *Scope__5fdebugName(oop self) { return "Scope"; }

static int   TranslationUnit__5fsizeof(oop self) { return sizeof(struct t_TranslationUnit); }
static char *TranslationUnit__5fdebugName(oop self) { return "TranslationUnit"; }

static int   Variable__5fsizeof(oop self) { return sizeof(struct t_Variable); }
static char *Variable__5fdebugName(oop self) { return "Variable"; }

static int   NamedVariable__5fsizeof(oop self) { return sizeof(struct t_NamedVariable); }
static char *NamedVariable__5fdebugName(oop self) { return "NamedVariable"; }

static int   GlobalVariable__5fsizeof(oop self) { return sizeof(struct t_GlobalVariable); }
static char *GlobalVariable__5fdebugName(oop self) { return "GlobalVariable"; }

static int   SelfVariable__5fsizeof(oop self) { return sizeof(struct t_SelfVariable); }
static char *SelfVariable__5fdebugName(oop self) { return "SelfVariable"; }

static int   ReceiverVariable__5fsizeof(oop self) { return sizeof(struct t_ReceiverVariable); }
static char *ReceiverVariable__5fdebugName(oop self) { return "ReceiverVariable"; }

static int   LocalVariable__5fsizeof(oop self) { return sizeof(struct t_LocalVariable); }
static char *LocalVariable__5fdebugName(oop self) { return "LocalVariable"; }

static int   RemoteReceiverVariable__5fsizeof(oop self) { return sizeof(struct t_RemoteReceiverVariable); }
static char *RemoteReceiverVariable__5fdebugName(oop self) { return "RemoteReceiverVariable"; }

static int   RemoteVariable__5fsizeof(oop self) { return sizeof(struct t_RemoteVariable); }
static char *RemoteVariable__5fdebugName(oop self) { return "RemoteVariable"; }

static int   ParseNode__5fsizeof(oop self) { return sizeof(struct t_ParseNode); }
static char *ParseNode__5fdebugName(oop self) { return "ParseNode"; }

static int   ValueNode__5fsizeof(oop self) { return sizeof(struct t_ValueNode); }
static char *ValueNode__5fdebugName(oop self) { return "ValueNode"; }

static int   BlockReturnNode__5fsizeof(oop self) { return sizeof(struct t_BlockReturnNode); }
static char *BlockReturnNode__5fdebugName(oop self) { return "BlockReturnNode"; }

static int   ReturnNode__5fsizeof(oop self) { return sizeof(struct t_ReturnNode); }
static char *ReturnNode__5fdebugName(oop self) { return "ReturnNode"; }

static int   LiteralNode__5fsizeof(oop self) { return sizeof(struct t_LiteralNode); }
static char *LiteralNode__5fdebugName(oop self) { return "LiteralNode"; }

static int   SymbolNode__5fsizeof(oop self) { return sizeof(struct t_SymbolNode); }
static char *SymbolNode__5fdebugName(oop self) { return "SymbolNode"; }

static int   StringNode__5fsizeof(oop self) { return sizeof(struct t_StringNode); }
static char *StringNode__5fdebugName(oop self) { return "StringNode"; }

static int   IntegerNode__5fsizeof(oop self) { return sizeof(struct t_IntegerNode); }
static char *IntegerNode__5fdebugName(oop self) { return "IntegerNode"; }

static int   CharacterNode__5fsizeof(oop self) { return sizeof(struct t_CharacterNode); }
static char *CharacterNode__5fdebugName(oop self) { return "CharacterNode"; }

static int   ArrayNode__5fsizeof(oop self) { return sizeof(struct t_ArrayNode); }
static char *ArrayNode__5fdebugName(oop self) { return "ArrayNode"; }

static int   WordArrayNode__5fsizeof(oop self) { return sizeof(struct t_WordArrayNode); }
static char *WordArrayNode__5fdebugName(oop self) { return "WordArrayNode"; }

static int   ByteArrayNode__5fsizeof(oop self) { return sizeof(struct t_ByteArrayNode); }
static char *ByteArrayNode__5fdebugName(oop self) { return "ByteArrayNode"; }

static int   VariableNode__5fsizeof(oop self) { return sizeof(struct t_VariableNode); }
static char *VariableNode__5fdebugName(oop self) { return "VariableNode"; }

static int   AssignmentNode__5fsizeof(oop self) { return sizeof(struct t_AssignmentNode); }
static char *AssignmentNode__5fdebugName(oop self) { return "AssignmentNode"; }

static int   SendNode__5fsizeof(oop self) { return sizeof(struct t_SendNode); }
static char *SendNode__5fdebugName(oop self) { return "SendNode"; }

static int   TemplateNode__5fsizeof(oop self) { return sizeof(struct t_TemplateNode); }
static char *TemplateNode__5fdebugName(oop self) { return "TemplateNode"; }

static int   PrimitiveNode__5fsizeof(oop self) { return sizeof(struct t_PrimitiveNode); }
static char *PrimitiveNode__5fdebugName(oop self) { return "PrimitiveNode"; }

static int   ExternDeclarationNode__5fsizeof(oop self) { return sizeof(struct t_ExternDeclarationNode); }
static char *ExternDeclarationNode__5fdebugName(oop self) { return "ExternDeclarationNode"; }

static int   IncludeNode__5fsizeof(oop self) { return sizeof(struct t_IncludeNode); }
static char *IncludeNode__5fdebugName(oop self) { return "IncludeNode"; }

static int   ImportNode__5fsizeof(oop self) { return sizeof(struct t_ImportNode); }
static char *ImportNode__5fdebugName(oop self) { return "ImportNode"; }

static int   ExportNode__5fsizeof(oop self) { return sizeof(struct t_ExportNode); }
static char *ExportNode__5fdebugName(oop self) { return "ExportNode"; }

static int   RequireNode__5fsizeof(oop self) { return sizeof(struct t_RequireNode); }
static char *RequireNode__5fdebugName(oop self) { return "RequireNode"; }

static int   ClassNode__5fsizeof(oop self) { return sizeof(struct t_ClassNode); }
static char *ClassNode__5fdebugName(oop self) { return "ClassNode"; }

static int   ExternalClassNode__5fsizeof(oop self) { return sizeof(struct t_ExternalClassNode); }
static char *ExternalClassNode__5fdebugName(oop self) { return "ExternalClassNode"; }

static int   SequenceNode__5fsizeof(oop self) { return sizeof(struct t_SequenceNode); }
static char *SequenceNode__5fdebugName(oop self) { return "SequenceNode"; }

static int   BlockNode__5fsizeof(oop self) { return sizeof(struct t_BlockNode); }
static char *BlockNode__5fdebugName(oop self) { return "BlockNode"; }

static int   MethodNode__5fsizeof(oop self) { return sizeof(struct t_MethodNode); }
static char *MethodNode__5fdebugName(oop self) { return "MethodNode"; }

static int   ExecNode__5fsizeof(oop self) { return sizeof(struct t_ExecNode); }
static char *ExecNode__5fdebugName(oop self) { return "ExecNode"; }

static oop Object__s_notImplemented_(oop self, oop v_selector)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= self;
  _2= _bind(_2, s_debugName)(_2);
  _3= l_532;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_selector;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_location(oop self)
{
 {
  oop _1;
  _1= ((struct t_ParseNode *)self)->location;
  return _1;
 }
}

static oop ParseNode__s_isOpenBlock(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop ParseNode__s_forTopLevel_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_forGobble_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= l_533;
  _2= self;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= v_nil;
  return _1;
 }
}

static oop ParseNode__s_encodeIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_534;
  _1= _bind(_1, s_subclassResponsibility_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_encode_(oop self, oop v_scope)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_535;
  _1= _bind(_1, s_subclassResponsibility_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_gen_(oop self, oop v_scope)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_536;
  _1= _bind(_1, s_subclassResponsibility_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_Object, s_printOn_)(_1, _2);
  return _1;
 }
}

static oop ValueNode__s_withValue_(oop self, oop v_aNode)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_ParseNode, s_new)(_1);
  self= _1;
  _1= v_aNode;
  ((struct t_ValueNode *)self)->value= _1;
  _1= self;
  return _1;
 }
}

static oop ValueNode__s_value(oop self)
{
 {
  oop _1;
  _1= ((struct t_ValueNode *)self)->value;
  return _1;
 }
}

static oop ValueNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= ((struct t_ValueNode *)self)->value;
  _2= v_aScope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= ((struct t_ValueNode *)self)->value;
  _1= _bind(_1, s_location)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_isReturnNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop BlockReturnNode__s_isReturnNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop BlockReturnNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_ValueNode *)self)->value;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_537;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_538;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ReturnNode__s_initialise(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_BlockReturnNode, s_initialise)(_1);
  _1= l_539;
  ((struct t_ReturnNode *)self)->level= _1;
  _1= self;
  return _1;
 }
}

static oop ReturnNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  _1= _bind(_1, s_level)(_1);
  _2= l_540;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  ((struct t_ReturnNode *)self)->level= _1;
  _2= l_541;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= v_aScope;
  _2= _bind(_2, s_noteExportNLR)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_aScope;
  _1= _rebind(v_BlockReturnNode, s_encode_)(_1, _2);
  return _1;
 }
}

static oop b_74(oop _self)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_545;
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop b_75(oop _self)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_548;
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop ReturnNode__s_gen_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3;
  _1= ((struct t_ReturnNode *)self)->level;
  _2= l_542;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _state[0]= _2;
  _2= ((struct t_ValueNode *)self)->value;
  _3= v_unit;
  _2= _bind(_2, s_gen_)(_2, _3);
  _2= _state[0];
  _3= l_543;
  _2= _bind(_2, s_gen_)(_2, _3);
  _2= ((struct t_ReturnNode *)self)->level;
  _3= l_544;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_74, 0, self, _state, 0);
  _2= _bind(_2, s_timesRepeat_)(_2, _3);
  _2= _state[0];
  _3= l_546;
  _2= _bind(_2, s_gen_)(_2, _3);
  _2= ((struct t_ReturnNode *)self)->level;
  _3= l_547;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_75, 0, self, _state, 0);
  _2= _bind(_2, s_timesRepeat_)(_2, _3);
  _2= _state[0];
  _3= l_549;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ValueNode *)self)->value;
  _3= _bind(_3, s_location)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_550;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  } else {
 {
  _2= self;
  _3= v_unit;
  _2= _rebind(v_BlockReturnNode, s_gen_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop ReturnNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
 {
  oop _1, _2, _3, _4;
  _1= v_aStream;
  _2= v_indent;
  _3= l_551;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= l_552;
  _bind(_1, s_nextPut_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_ValueNode *)self)->value;
  _2= v_aStream;
  _3= v_indent;
  _4= l_553;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static int   LiteralNodeTag__5fsizeof(oop self) { return sizeof(struct t_LiteralNodeTag); }
static char *LiteralNodeTag__5fdebugName(oop self) { return "LiteralNodeTag"; }

static oop LiteralNode__s_initialise(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _1= _rebind(v_ValueNode, s_initialise)(_1);
  self= _1;
  _1= v_LiteralNodeTag;
  _2= l_555;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_LiteralNodeTag= _1;
  ((struct t_LiteralNode *)self)->tag= _1;
  _1= self;
  return _1;
 }
}

static oop LiteralNode__s_tag(oop self)
{
 {
  oop _1;
  _1= ((struct t_LiteralNode *)self)->tag;
  return _1;
 }
}

static oop LiteralNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  _1= _bind(_1, s_newTemp)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= v_aScope;
  _2= self;
  _2= _bind(_2, s_literalClass)(_2);
  _bind(_1, s_lookup_)(_1, _2);
  _2= self;
  _2= _bind(_2, s_literalSelector)(_2);
  _bind(_1, s_declareSelector_)(_1, _2);
  _2= self;
  _1= _bind(_1, s_declareLiteral_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop LiteralNode__s_genDefinition_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_556;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_557;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop LiteralNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_558;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_559;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_560;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SymbolNode__s_fromString_(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop SymbolNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_561;
  return _1;
 }
}

static oop SymbolNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_562;
  return _1;
 }
}

static oop SymbolNode__s_genInitialisation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_563;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_564;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_565;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop StringNode__s_fromString_(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop StringNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_566;
  return _1;
 }
}

static oop StringNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_567;
  return _1;
 }
}

static oop b_76(oop _self, oop v_char)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_char;
  _2= l_570;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_571;
  _2= _bind(_2, s_gen_)(_2, _3);
 }
  } else {
 {
  _2= v_char;
  _3= l_572;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 < (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3c)(_2, _3);
  if (!_2) {
 {
  _3= v_char;
  _4= l_573;
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 == (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3d)(_3, _4);
  if (!_3) {
 {
  _4= v_char;
  _4= _bind(_4, s_asciiValue)(_4);
  _5= l_574;
  if (_areIntegerObjects(_4, _5))
    _4= ((long)_4 > (long)_5) ? v_true : v_false;
  else
    _4= _bind(_4, s__3e)(_4, _5);
 }
  _3= _4;
  }
 }
  _2= _3;
  }
  if (_2) {
 {
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _4= l_575;
  _bind(_3, s_gen_)(_3, _4);
  _4= v_char;
  _4= _bind(_4, s_asciiValue)(_4);
  _4= _bind(_4, s_octal3)(_4);
  _3= _bind(_3, s_gen_)(_3, _4);
 }
  } else {
 {
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _4= v_char;
  _3= _bind(_3, s_nextPut_)(_3, _4);
 }
  } _2= _3;
 }
  } _1= _2;
  return _1;
 }
}

static oop StringNode__s_genInitialisation_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= _state[0];
  _2= l_568;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_569;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_76, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _2= l_576;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop StringNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
 {
  oop _1, _2, _3;
  _1= v_aStream;
  _2= v_indent;
  _3= l_577;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_print_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop IntegerNode__s_fromString_(oop self, oop v_aString)
{
 {
  oop v_base;
  oop v_aStream;
  oop _1, _2, _3, _4;
  _1= v_aString;
  _1= _bind(_1, s_readStream)(_1);
  v_aStream= _1;
  _1= v_aString;
  _2= l_578;
  _1= _bind(_1, s_beginsWith_)(_1, _2);
  if (_1) {
 {
  _2= l_579;
  v_base= _2;
  _2= v_aStream;
  _3= l_580;
  _2= _bind(_2, s_skip_)(_2, _3);
 }
  } else {
 {
  _2= l_581;
  v_base= _2;
 }
  } _1= _2;
  _1= self;
  _2= v_Integer;
  _3= v_aStream;
  _4= v_base;
  _2= _bind(_2, s_readFrom_base_)(_2, _3, _4);
  _1= _bind(_1, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop IntegerNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_582;
  return _1;
 }
}

static oop IntegerNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_583;
  return _1;
 }
}

static oop IntegerNode__s_genInitialisation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_584;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_585;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_print_)(_1, _2);
  _2= l_586;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop IntegerNode__s_genByte_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_ValueNode *)self)->value;
  _2= l_587;
  _3= l_588;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (!_1) {
 {
  _2= self;
  _3= l_589;
  _4= ((struct t_ValueNode *)self)->value;
  _4= _bind(_4, s_printString)(_4);
  _3= _bind(_3, s__2c)(_3, _4);
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_590;
  _3= ((struct t_ValueNode *)self)->value;
  _3= _bind(_3, s_octal3)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop IntegerNode__s_genWord_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= ((struct t_ValueNode *)self)->value;
  _1= _bind(_1, s_print_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop CharacterNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_591;
  return _1;
 }
}

static oop CharacterNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_592;
  return _1;
 }
}

static oop CharacterNode__s_genInitialisation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_593;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_594;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_asciiValue)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_595;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ArrayNode__s_withElements_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aCollection;
  _1= _rebind(v_LiteralNode, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop ArrayNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_596;
  return _1;
 }
}

static oop ArrayNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_597;
  return _1;
 }
}

static oop b_77(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= v_element;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genDefinition_)(_1, _2);
  return _1;
 }
}

static oop b_78(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= l_601;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_element;
  _2= _bind(_2, s_tag)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_602;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop ArrayNode__s_genDefinition_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= _state[0];
  _1= _bind(_1, s_outputStream)(_1);
  _state[1]= _1;
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_77, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  _2= _state[0];
  _1= _rebind(v_LiteralNode, s_genDefinition_)(_1, _2);
  _1= _state[1];
  _2= l_598;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_599;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_600;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_78, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[1];
  _2= l_603;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop b_79(oop _self, oop v_element)
{
 {
  oop _1, _2;
  _1= v_element;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genInitialisation_)(_1, _2);
  return _1;
 }
}

static oop ArrayNode__s_genInitialisation_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_79, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_604;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_605;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_606;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_607;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ArrayNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_LiteralNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_608;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_print_)(_1, _2);
  _2= l_609;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ByteArrayNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_610;
  return _1;
 }
}

static oop ByteArrayNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_611;
  return _1;
 }
}

static oop ByteArrayNode__s_withElements_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aCollection;
  _1= _rebind(v_LiteralNode, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop b_80(oop _self, oop v_byte)
{
 {
  oop _1, _2;
  _1= v_byte;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genByte_)(_1, _2);
  return _1;
 }
}

static oop ByteArrayNode__s_genInitialisation_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop v_stream;
  oop _1, _2;
  _1= _state[0];
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_612;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_613;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_614;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_80, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= v_stream;
  _2= l_615;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ByteArrayNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_LiteralNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_616;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_print_)(_1, _2);
  _2= l_617;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop WordArrayNode__s_literalClass(oop self)
{
 {
  oop _1;
  _1= l_618;
  return _1;
 }
}

static oop WordArrayNode__s_literalSelector(oop self)
{
 {
  oop _1;
  _1= l_619;
  return _1;
 }
}

static oop WordArrayNode__s_withElements_(oop self, oop v_aCollection)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aCollection;
  _1= _rebind(v_LiteralNode, s_withValue_)(_1, _2);
  return _1;
 }
}

static oop b_81(oop _self, oop v_word)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_623;
  _1= _bind(_1, s_space_)(_1, _2);
  _1= v_word;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _1= _bind(_1, s_genWord_)(_1, _2);
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_624;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop WordArrayNode__s_genDefinition_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_unit;
 {
  oop _1, _2;
  _1= _state[1];
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= self;
  _2= _state[1];
  _1= _rebind(v_LiteralNode, s_genDefinition_)(_1, _2);
  _1= _state[0];
  _2= l_620;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_621;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_622;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_ValueNode *)self)->value;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_81, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _2= l_625;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop WordArrayNode__s_genInitialisation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_626;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_627;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_628;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_LiteralNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_629;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop WordArrayNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_LiteralNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_630;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= ((struct t_ValueNode *)self)->value;
  _bind(_1, s_print_)(_1, _2);
  _2= l_631;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s_isVariableNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop VariableNode__s_isVariableNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop VariableNode__s_withName_(oop self, oop v_nameString)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_VariableNode *)self)->name= _1;
  _1= v_nil;
  ((struct t_VariableNode *)self)->variable= _1;
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_name(oop self)
{
 {
  oop _1;
  _1= ((struct t_VariableNode *)self)->name;
  return _1;
 }
}

static oop b_82(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_VariableNode *)((struct t_BlockClosure *)_self)->receiver)->name;
  _2= l_632;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop VariableNode__s_beSelf(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_82, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= l_633;
  ((struct t_VariableNode *)self)->name= _1;
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_encodeLvalue_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  _2= ((struct t_VariableNode *)self)->name;
  _1= _bind(_1, s_lookup_)(_1, _2);
  ((struct t_VariableNode *)self)->variable= _1;
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  _2= ((struct t_VariableNode *)self)->name;
  _1= _bind(_1, s_lookup_)(_1, _2);
  ((struct t_VariableNode *)self)->variable= _1;
  _1= v_aScope;
  _1= _bind(_1, s_newTemp)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_genLvalue_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_VariableNode *)self)->variable;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_gen_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_634;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_635;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_VariableNode *)self)->variable;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_636;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop VariableNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
 {
  oop _1, _2, _3;
  _1= v_aStream;
  _2= v_indent;
  _3= l_637;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= l_638;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_VariableNode *)self)->name;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_639;
  _bind(_1, s_nextPut_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop AssignmentNode__s_withVariable_value_(oop self, oop v_variableNode, oop v_valueNode)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_variableNode;
  ((struct t_AssignmentNode *)self)->variable= _1;
  _1= v_valueNode;
  ((struct t_AssignmentNode *)self)->value= _1;
  _1= self;
  return _1;
 }
}

static oop AssignmentNode__s_encode_(oop self, oop v_scope)
{
 {
  oop _1, _2;
  _1= ((struct t_AssignmentNode *)self)->variable;
  _2= v_scope;
  _1= _bind(_1, s_encodeLvalue_)(_1, _2);
  _1= ((struct t_AssignmentNode *)self)->value;
  _2= v_scope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= ((struct t_AssignmentNode *)self)->value;
  _1= _bind(_1, s_location)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop AssignmentNode__s_gen_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_AssignmentNode *)self)->value;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_640;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_AssignmentNode *)self)->variable;
  _2= v_unit;
  _1= _bind(_1, s_genLvalue_)(_1, _2);
  _1= v_stream;
  _2= l_641;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_642;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop AssignmentNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
 {
  oop _1, _2, _3, _4;
  _1= v_aStream;
  _2= v_indent;
  _3= l_643;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= ((struct t_AssignmentNode *)self)->variable;
  _bind(_1, s_print_)(_1, _2);
  _2= l_644;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_AssignmentNode *)self)->value;
  _2= v_aStream;
  _3= v_indent;
  _4= l_645;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop Object__s_isPrimitiveNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop PrimitiveNode__s_isPrimitiveNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop PrimitiveNode__s_withCode_(oop self, oop v_aString)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_aString;
  ((struct t_PrimitiveNode *)self)->code= _1;
  _1= self;
  return _1;
 }
}

static oop PrimitiveNode__s_forTopLevel_(oop self, oop v_aCompiler)
{
 {
  oop _1, _2;
  _1= v_ExecNode;
  _2= self;
  _1= _bind(_1, s_withStatement_)(_1, _2);
  return _1;
 }
}

static oop PrimitiveNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1;
  _1= v_aScope;
  _1= _bind(_1, s_newTemp)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop PrimitiveNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_646;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_PrimitiveNode *)self)->code;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_647;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_648;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop PrimitiveNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_ParseNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_649;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= ((struct t_PrimitiveNode *)self)->code;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_650;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s_isExternDeclarationNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop ExternDeclarationNode__s_isExternDeclatationNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop ExternDeclarationNode__s_withNames_(oop self, oop v_nameCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_nameCollection;
  ((struct t_ExternDeclarationNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop ExternDeclarationNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_ParseNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_651;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_ExternDeclarationNode *)self)->names;
  _bind(_1, s_print_)(_1, _2);
  _2= l_652;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s_isSendNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop SendNode__s_isSendNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop SendNode__s_withReceiver_selector_(oop self, oop v_rcv, oop v_sel)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_rcv;
  ((struct t_SendNode *)self)->receiver= _1;
  _1= v_sel;
  ((struct t_SendNode *)self)->selector= _1;
  _1= v_sel;
  ((struct t_SendNode *)self)->mangled= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_SendNode *)self)->arguments= _1;
  _1= v_nil;
  ((struct t_SendNode *)self)->cascade= _1;
  _1= v_nil;
  ((struct t_SendNode *)self)->supered= _1;
  _1= v_nil;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  return _1;
 }
}

static oop SendNode__s_cascade(oop self)
{
 {
  oop _1;
  _1= ((struct t_SendNode *)self)->cascade;
  return _1;
 }
}

static oop SendNode__s_addKeyword_(oop self, oop v_keyword)
{
 {
  oop _1, _2;
  _1= ((struct t_SendNode *)self)->selector;
  _2= v_keyword;
  _1= _bind(_1, s__2c)(_1, _2);
  ((struct t_SendNode *)self)->selector= _1;
  _1= self;
  return _1;
 }
}

static oop SendNode__s_addArgument_(oop self, oop v_argument)
{
 {
  oop _1, _2;
  _1= ((struct t_SendNode *)self)->arguments;
  _2= v_argument;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_addCascade_(oop self, oop v_sendNode)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= v_sendNode;
  ((struct t_SendNode *)self)->cascade= _2;
 }
  } else {
 {
  _2= ((struct t_SendNode *)self)->cascade;
  _3= v_sendNode;
  _2= _bind(_2, s_addCascade_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop SendNode__s_supered_(oop self, oop v_base)
{
 {
  oop _1, _2, _3;
  _1= v_base;
  ((struct t_SendNode *)self)->supered= _1;
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->cascade;
  _3= v_base;
  _2= _bind(_2, s_supered_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static int   MacroEncoders__5fsizeof(oop self) { return sizeof(struct t_MacroEncoders); }
static char *MacroEncoders__5fdebugName(oop self) { return "MacroEncoders"; }

static oop SendNode__s_encodeBinary_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_aScope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_aScope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= v_aScope;
  _1= _bind(_1, s_freeTemp)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_location)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop SendNode__s_encodeAdd_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_707;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeSub_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_708;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeMul_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_709;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeDiv_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_710;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeMod_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_711;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeBitAnd_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_712;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeBitOr_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_713;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeBitXor_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_714;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeLT_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_715;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeLE_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_716;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeEQ_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_717;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeID_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_718;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeNI_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_719;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeNE_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_720;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeGE_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_721;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeGT_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= l_722;
  ((struct t_SendNode *)self)->macro= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeBinary_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeValue_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_723;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_warnBlockReceiver(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isBlockNode)(_1);
  if (_1) {
 {
  _2= l_724;
  _3= ((struct t_SendNode *)self)->selector;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_725;
  _3= _bind(_3, s_println)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop SendNode__s_encodeAnd_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_warnBlockReceiver)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_726;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encode_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeOr_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_warnBlockReceiver)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_727;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encode_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeIfTrue_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_warnBlockReceiver)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_728;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encode_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeIfFalse_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_warnBlockReceiver)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_729;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encode_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop b_83(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_SendNode *)((struct t_BlockClosure *)_self)->receiver)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_location)(_1);
  _2= ((struct t_SendNode *)((struct t_BlockClosure *)_self)->receiver)->arguments;
  _2= _bind(_2, s_second)(_2);
  _2= _bind(_2, s_location)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeIfTrueIfFalse_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_warnBlockReceiver)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_second)(_2);
  _2= _bind(_2, s_isOpenBlock)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= l_730;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encode_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_second)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_83, 0, self, 0, 0);
  _2= _bind(_2, s_assert_)(_2, _3);
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeIfFalseIfTrue_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_731;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_encodeWhileTrue_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_732;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeWhileTrueArg_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_isOpenBlock)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= l_733;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeWhileFalse_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= l_734;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop SendNode__s_encodeWhileFalseArg_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isOpenBlock)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_isOpenBlock)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= l_735;
  ((struct t_SendNode *)self)->macro= _2;
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= v_aScope;
  _2= _bind(_2, s_freeTemp)(_2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _3= v_aScope;
  _2= _bind(_2, s_encodeOpen_)(_2, _3);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  ((struct t_ParseNode *)self)->location= _2;
  _2= self;
 }
  } else {
 {
  _2= v_nil;
 }
  } _1= _2;
  return _1;
 }
}

static oop b_84(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_85(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop SendNode__s_encodeMacro_(oop self, oop v_aScope)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_notNil)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_84, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= v_MacroEncoders;
  _3= ((struct t_SendNode *)self)->selector;
  _4= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_85, 0, self, 0, &_env);
  _2= _bind(_2, s_at_ifAbsent_)(_2, _3, _4);
  _3= v_aScope;
  _1= _bind(_1, s_perform_with_)(_1, _2, _3);
  return _1;
 }
}

static oop b_86(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= v_arg;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_encode_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_encodeCascade_location_(oop self, oop v_aScope, oop v_aLocation)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aScope;
 {
  oop _1, _2, _3, _4;
  _1= v_aLocation;
  ((struct t_ParseNode *)self)->location= _1;
  _1= _state[0];
  _2= ((struct t_SendNode *)self)->selector;
  _1= _bind(_1, s_declareSelector_)(_1, _2);
  ((struct t_SendNode *)self)->mangled= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_86, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_size)(_2);
  _1= _bind(_1, s_freeTemps_)(_1, _2);
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->cascade;
  _3= _state[0];
  _4= v_aLocation;
  _2= _bind(_2, s_encodeCascade_location_)(_2, _3, _4);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_87(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop SendNode__s_encode_(oop self, oop v_aScope)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3, _4;
  _1= v_aScope;
  _2= ((struct t_SendNode *)self)->selector;
  _1= _bind(_1, s_declareSelector_)(_1, _2);
  ((struct t_SendNode *)self)->mangled= _1;
  _1= self;
  _2= v_aScope;
  _1= _bind(_1, s_encodeMacro_)(_1, _2);
  _state[0]= _1;
  _1= _bind(_1, s_notNil)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_87, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_isVariableNode)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_name)(_2);
  _3= l_736;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  if (_1) {
 {
  oop v_base;
  _2= v_aScope;
  _2= _bind(_2, s_class)(_2);
  _2= _bind(_2, s_base)(_2);
  v_base= _2;
  _2= _bind(_2, s_isNil)(_2);
  if (_2) {
 {
  _3= self;
  _4= l_737;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= self;
  _3= v_base;
  _2= _bind(_2, s_supered_)(_2, _3);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_beSelf)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_aScope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_location)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  _2= v_aScope;
  _3= ((struct t_ParseNode *)self)->location;
  _1= _bind(_1, s_encodeCascade_location_)(_1, _2, _3);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genAdd_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_738;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_739;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_740;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_741;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_742;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_743;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_744;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_745;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_746;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_747;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_748;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_749;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_750;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_751;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_752;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genSub_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_753;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_754;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_755;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_756;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_757;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_758;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_759;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_760;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_761;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_762;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_763;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_764;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_765;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_766;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_767;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genMul_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_768;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_769;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_770;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_771;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_772;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_773;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_774;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_775;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_776;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_777;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_778;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_779;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_780;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_781;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_782;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genDiv_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_783;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_784;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_785;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_786;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_787;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_788;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_789;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_790;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_791;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_792;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_793;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_794;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_795;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_796;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_797;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genMod_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_798;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_799;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_800;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_801;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_802;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_803;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_804;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_805;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_806;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_807;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_808;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_809;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_810;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_811;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_812;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genBitAnd_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_813;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_814;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_815;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_816;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_817;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_818;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_819;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_820;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_821;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_822;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_823;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_824;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_825;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_826;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_827;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genBitOr_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_828;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_829;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_830;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_831;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_832;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_833;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_834;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_835;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_836;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_837;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_838;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_839;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_840;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_841;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_842;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genBitXor_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_843;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_844;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_845;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_846;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_847;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_848;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_849;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_850;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_851;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_852;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_853;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_854;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_855;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_856;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_857;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genLT_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_858;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_859;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_860;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_861;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_862;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_863;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_864;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_865;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_866;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_867;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_868;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_869;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_870;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_871;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_872;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_873;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genLE_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_874;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_875;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_876;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_877;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_878;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_879;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_880;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_881;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_882;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_883;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_884;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_885;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_886;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_887;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_888;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_889;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genEQ_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_890;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_891;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_892;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_893;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_894;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_895;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_896;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_897;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_898;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_899;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_900;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_901;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_902;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_903;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_904;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_905;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genID_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_906;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_907;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_908;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_909;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_910;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genNI_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_911;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_912;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_913;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_914;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_915;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genNE_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_916;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_917;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_918;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_919;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_920;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_921;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_922;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_923;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_924;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_925;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_926;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_927;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_928;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_929;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_930;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_931;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genGE_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_932;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_933;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_934;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_935;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_936;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_937;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_938;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_939;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_940;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_941;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_942;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_943;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_944;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_945;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_946;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_947;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genGT_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop v_arg;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  v_arg= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_arg;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_948;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_949;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_950;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_951;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_952;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_953;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_954;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_955;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_956;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_957;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_958;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_959;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->mangled;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_960;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_961;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->receiver;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_962;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_963;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genAnd_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_964;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_965;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_966;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_967;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_968;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= v_stream;
  _2= l_969;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genOr_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_970;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_971;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_972;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_973;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_974;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= v_stream;
  _2= l_975;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genIfTrue_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_976;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_977;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_978;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_979;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_980;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= v_stream;
  _2= l_981;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_982;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genIfTrueIfFalse_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_983;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_984;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_985;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_second)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_986;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_987;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_second)(_2);
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_988;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genIfFalse_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= v_stream;
  _2= l_989;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_990;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_991;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_992;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_SendNode *)self)->arguments;
  _2= _bind(_2, s_first)(_2);
  _2= _bind(_2, s_location)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_993;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= v_stream;
  _2= l_994;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_995;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genWhileFalse_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_996;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_997;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_998;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genWhileFalseArg_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_999;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1000;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1001;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1002;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genWhileTrue_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_1003;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1004;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1005;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_genWhileTrueArg_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_1006;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1007;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1008;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->arguments;
  _1= _bind(_1, s_first)(_1);
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1009;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop SendNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_SendNode *)self)->macro;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= ((struct t_SendNode *)self)->macro;
  _4= v_unit;
  _2= _bind(_2, s_perform_with_)(_2, _3, _4);
 }
  } else {
 {
  _2= ((struct t_SendNode *)self)->receiver;
  _3= v_unit;
  _2= _bind(_2, s_gen_)(_2, _3);
  _2= self;
  _3= v_unit;
  _2= _bind(_2, s_genCascade_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_88(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= v_arg;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop b_89(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= l_1019;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_location)(_2);
  _1= _bind(_1, s_print_)(_1, _2);
  return _1;
 }
}

static oop SendNode__s_genCascade_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_unit;
 {
  oop _1, _2, _3;
  _1= _state[0];
  _1= _bind(_1, s_outputStream)(_1);
  _state[1]= _1;
  _1= ((struct t_SendNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_88, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[1];
  _2= l_1010;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= _state[1];
  _3= l_1011;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ParseNode *)self)->location;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1012;
  _2= _bind(_2, s_gen_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SendNode *)self)->supered;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= _state[1];
  _3= l_1013;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ParseNode *)self)->location;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1014;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SendNode *)self)->mangled;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1015;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ParseNode *)self)->location;
  _2= _bind(_2, s_print_)(_2, _3);
 }
  } else {
 {
  _2= _state[1];
  _3= l_1016;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SendNode *)self)->supered;
  _3= _bind(_3, s_name)(_3);
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1017;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SendNode *)self)->mangled;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1018;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ParseNode *)self)->location;
  _2= _bind(_2, s_print_)(_2, _3);
 }
  } _1= _2;
  _1= ((struct t_SendNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_89, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[1];
  _2= l_1020;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->cascade;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->cascade;
  _3= _state[0];
  _2= _bind(_2, s_genCascade_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_90(oop _self, oop v_arg)
{
 {
  oop _1, _2, _3, _4;
  _1= v_arg;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _4= l_1024;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
  return _1;
 }
}

static oop SendNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_aStream;
  _state[1]= v_indent;
 {
  oop _1, _2, _3, _4, _5;
  _1= _state[0];
  _2= _state[1];
  _3= l_1021;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= l_1022;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_SendNode *)self)->selector;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SendNode *)self)->receiver;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SendNode *)self)->receiver;
  _3= _state[0];
  _4= _state[1];
  _5= l_1023;
  if (_areIntegerObjects(_4, _5))
    _4= (oop)((long)_4 + (long)_5 - 1);
  else
    _4= _bind(_4, s__2b)(_4, _5);
  _2= _bind(_2, s_printOn_indent_)(_2, _3, _4);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SendNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_90, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  for (;;) {
 {
  _1= self;
  _1= _bind(_1, s_cascade)(_1);
  self= _1;
  _1= _bind(_1, s_notNil)(_1);
 }
  if (!_1) break;
 {
  _1= _state[0];
  _2= _state[1];
  _3= l_1025;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _bind(_1, s_space_)(_1, _2);
  _2= l_1026;
  _bind(_1, s_nextPut_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  _2= _state[0];
  _3= _state[1];
  _4= l_1027;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
 }
  };
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_initialise(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_ParseNode, s_initialise)(_1);
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_SequenceNode *)self)->temporaries= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_SequenceNode *)self)->statements= _1;
  _1= v_IdentitySet;
  _1= _bind(_1, s_new)(_1);
  ((struct t_SequenceNode *)self)->literals= _1;
  _1= v_nil;
  ((struct t_SequenceNode *)self)->scope= _1;
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_addTemporary_(oop self, oop v_node)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= v_node;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_addStatement_(oop self, oop v_node)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= v_node;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_lastStatement(oop self)
{
 {
  oop _1;
  _1= ((struct t_SequenceNode *)self)->statements;
  _1= _bind(_1, s_last)(_1);
  return _1;
 }
}

static oop SequenceNode__s_external_(oop self, oop v_externNode)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= v_externNode;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_91(oop _self, oop v_temp)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= v_temp;
  _1= _bind(_1, s_declareLocal_)(_1, _2);
  return _1;
 }
}

static oop b_92(oop _self, oop v_stmt)
{
 {
  oop _1, _2;
  _1= v_stmt;
  _2= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= _bind(_1, s_location)(_1);
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= _bind(_2, s_freeTemp)(_2);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop SequenceNode__s_encodeOpen_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  ((struct t_SequenceNode *)self)->scope= _1;
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_91, 1, self, 0, 0);
  _1= _bind(_1, s_collect_)(_1, _2);
  ((struct t_SequenceNode *)self)->temporaries= _1;
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_92, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= v_aScope;
  _1= _bind(_1, s_newTemp)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  return _1;
 }
}

static oop b_93(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= (_1 == _2) ? v_true : v_false;
  return _1;
 }
}

static oop b_94(oop _self, oop v_temp)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= v_temp;
  _1= _bind(_1, s_declareLocal_)(_1, _2);
  return _1;
 }
}

static oop b_95(oop _self, oop v_stmt)
{
 {
  oop _1, _2;
  _1= v_stmt;
  _2= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _1= _bind(_1, s_encode_)(_1, _2);
  _1= _bind(_1, s_location)(_1);
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= _bind(_2, s_freeTemp)(_2);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop SequenceNode__s_encodeSequence_(oop self, oop v_aScope)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aScope;
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_93, 0, self, _state, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_94, 1, self, _state, 0);
  _1= _bind(_1, s_collect_)(_1, _2);
  ((struct t_SequenceNode *)self)->temporaries= _1;
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_95, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_genImplementation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1028;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1029;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop SequenceNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1030;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_96(oop _self, oop v_temp)
{
 {
  oop _1, _2, _3;
  _1= v_temp;
  _1= _bind(_1, s_isExported)(_1);
  if (!_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_1033;
  _bind(_2, s_gen_)(_2, _3);
  _3= v_temp;
  _3= _bind(_3, s_mangledName)(_3);
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1034;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop b_97(oop _self, oop v_n)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1038;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_n;
  _1= _bind(_1, s_print_)(_1, _2);
  return _1;
 }
}

static oop b_98(oop _self, oop v_stmt)
{
 {
  oop _1, _2;
  _1= v_stmt;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop SequenceNode__s_genSequence_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[1]= v_unit;
 {
  oop v_nTemps;
  oop _1, _2, _3, _4;
  _1= _state[1];
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= l_1031;
 }
  } else {
 {
  _2= ((struct t_SequenceNode *)self)->scope;
  _2= _bind(_2, s_tempCount)(_2);
 }
  } _1= _2;
  v_nTemps= _1;
  _1= _state[0];
  _2= l_1032;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_96, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= v_nTemps;
  _2= l_1035;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= _state[0];
  _3= l_1036;
  _2= _bind(_2, s_gen_)(_2, _3);
  _2= l_1037;
  _3= v_nTemps;
  _4= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_97, 1, self, _state, 0);
  _2= _bind(_2, s_to_do_)(_2, _3, _4);
  _2= _state[0];
  _3= l_1039;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
  _2= ((struct t_SequenceNode *)self)->scope;
  _2= _bind(_2, s_resetTemps)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_98, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _2= l_1040;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static int   BlockNodeTag__5fsizeof(oop self) { return sizeof(struct t_BlockNodeTag); }
static char *BlockNodeTag__5fdebugName(oop self) { return "BlockNodeTag"; }

static oop BlockNode__s_initialise(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_SequenceNode, s_initialise)(_1);
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_BlockNode *)self)->arguments= _1;
  _1= v_false;
  ((struct t_BlockNode *)self)->variadic= _1;
  _1= l_1042;
  ((struct t_BlockNode *)self)->tag= _1;
  _1= self;
  return _1;
 }
}

static oop Object__s_isBlockNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop BlockNode__s_isBlockNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop BlockNode__s_beVariadic(oop self)
{
 {
  oop _1;
  _1= v_true;
  ((struct t_BlockNode *)self)->variadic= _1;
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_addArgument_(oop self, oop v_node)
{
 {
  oop _1, _2;
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= v_node;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_isOpenBlock(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockNode *)self)->arguments;
  _1= _bind(_1, s_isEmpty)(_1);
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(_2, s_isEmpty)(_2);
  if (!_2) {
 {
  _3= ((struct t_SequenceNode *)self)->statements;
  _3= _bind(_3, s_last)(_3);
  _3= _bind(_3, s_isReturnNode)(_3);
  _3= _bind(_3, s_not)(_3);
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  return _1;
 }
}

static oop BlockNode__s_ensureReturn(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= ((struct t_SequenceNode *)self)->statements;
  _1= _bind(_1, s_isEmpty)(_1);
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)self)->statements;
  _3= v_BlockReturnNode;
  _4= v_VariableNode;
  _5= l_1043;
  _4= _bind(_4, s_withName_)(_4, _5);
  _3= _bind(_3, s_withValue_)(_3, _4);
  _2= _bind(_2, s_add_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(_2, s_last)(_2);
  _2= _bind(_2, s_isReturnNode)(_2);
  if (!_2) {
 {
  oop v_last;
  _3= ((struct t_SequenceNode *)self)->statements;
  _3= _bind(_3, s_removeLast)(_3);
  v_last= _3;
  _3= ((struct t_SequenceNode *)self)->statements;
  _4= v_BlockReturnNode;
  _5= v_last;
  _4= _bind(_4, s_withValue_)(_4, _5);
  _3= _bind(_3, s_addLast_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_99(oop _self)
{
 {
  oop _1;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _1= _bind(_1, s_isNil)(_1);
  return _1;
 }
}

static oop BlockNode__s_encode_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_BlockNodeTag;
  _2= l_1044;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  v_BlockNodeTag= _1;
  ((struct t_BlockNode *)self)->tag= _1;
  _1= v_aScope;
  _2= self;
  _1= _bind(_1, s_addBlock_)(_1, _2);
  _1= v_aScope;
  _1= _bind(_1, s_newTemp)(_1);
  ((struct t_ParseNode *)self)->location= _1;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_99, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= v_aScope;
  _2= self;
  _1= _bind(_1, s_innerScopeFor_)(_1, _2);
  ((struct t_SequenceNode *)self)->scope= _1;
  _1= self;
  _2= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_encodeBlock_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_100(oop _self)
{
 {
  oop _1;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _1= _bind(_1, s_notNil)(_1);
  return _1;
 }
}

static oop b_101(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _2= v_arg;
  _1= _bind(_1, s_declareLocal_)(_1, _2);
  return _1;
 }
}

static oop BlockNode__s_encodeBlock_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_100, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_101, 1, self, 0, 0);
  _1= _bind(_1, s_collect_)(_1, _2);
  ((struct t_BlockNode *)self)->arguments= _1;
  _1= self;
  _bind(_1, s_ensureReturn)(_1);
  _2= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_encodeSequence_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genDefinition_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genDefinitions_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_isStatic)(_1);
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _3= l_1045;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_BlockNode *)self)->tag;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1046;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_102(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1049;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_mangledName)(_2);
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop b_103(oop _self, oop v_arg)
{
 {
  oop _1, _2, _3;
  _1= v_arg;
  _1= _bind(_1, s_isExported)(_1);
  if (_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_1055;
  _bind(_2, s_gen_)(_2, _3);
  _3= v_arg;
  _3= _bind(_3, s_offset)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1056;
  _bind(_2, s_gen_)(_2, _3);
  _3= v_arg;
  _3= _bind(_3, s_mangledName)(_3);
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1057;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop BlockNode__s_genImplementation_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genImplementations_)(_1, _2);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= _state[0];
  _2= l_1047;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1048;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_102, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _2= l_1050;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_1051;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_exports)(_1);
  _2= l_1052;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= _state[0];
  _3= l_1053;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SequenceNode *)self)->scope;
  _3= _bind(_3, s_exports)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1054;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
  _2= ((struct t_BlockNode *)self)->arguments;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_103, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= _state[0];
  _2= l_1058;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1059;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genInitialisation_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genInitialisations_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_isStatic)(_1);
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _3= l_1060;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_BlockNode *)self)->tag;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1061;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1062;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_BlockNode *)self)->tag;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1063;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_BlockNode *)self)->arguments;
  _3= _bind(_3, s_size)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1064;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genStatic_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1065;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1066;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1067;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genFull_(oop self, oop v_unit)
{
 {
  oop v_parent;
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_parent)(_1);
  v_parent= _1;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1068;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1069;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1070;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1071;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1072;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->arguments;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_1073;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_parent;
  _2= _bind(_2, s_isMethod)(_2);
  if (_2) {
 {
  _3= l_1074;
 }
  } else {
 {
  _3= l_1075;
 }
  } _2= _3;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_parent;
  _2= _bind(_2, s_exports)(_2);
  _3= l_1076;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
  if (_2) {
 {
  _3= l_1077;
 }
  } else {
 {
  _3= l_1078;
 }
  } _2= _3;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_parent;
  _2= _bind(_2, s_isMethod)(_2);
  if (_2) {
 {
  _3= l_1079;
 }
  } else {
 {
  _3= l_1080;
 }
  } _2= _3;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1081;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_genNLR_(oop self, oop v_unit)
{
 {
  oop v_parent;
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_parent)(_1);
  v_parent= _1;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1082;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ParseNode *)self)->location;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1083;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1084;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1085;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->tag;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1086;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_BlockNode *)self)->arguments;
  _2= _bind(_2, s_size)(_2);
  _bind(_1, s_print_)(_1, _2);
  _2= l_1087;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_parent;
  _2= _bind(_2, s_isMethod)(_2);
  if (_2) {
 {
  _3= l_1088;
 }
  } else {
 {
  _3= l_1089;
 }
  } _2= _3;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_parent;
  _2= _bind(_2, s_exports)(_2);
  _3= l_1090;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
  if (_2) {
 {
  _3= l_1091;
 }
  } else {
 {
  _3= l_1092;
 }
  } _2= _3;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1093;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop BlockNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_isStatic)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_unit;
  _2= _bind(_2, s_genStatic_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_SequenceNode *)self)->scope;
  _2= _bind(_2, s_parent)(_2);
  _2= _bind(_2, s_exportNLR)(_2);
  if (_2) {
 {
  _3= self;
  _4= v_unit;
  _3= _bind(_3, s_genNLR_)(_3, _4);
 }
  } else {
 {
  _3= self;
  _4= v_unit;
  _3= _bind(_3, s_genFull_)(_3, _4);
 }
  } _2= _3;
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_104(oop _self, oop v_stmt)
{
 {
  oop _1, _2, _3, _4;
  _1= v_stmt;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _4= l_1097;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
  return _1;
 }
}

static oop BlockNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_aStream;
  _state[1]= v_indent;
 {
  oop _1, _2;
  _1= _state[0];
  _2= _state[1];
  _bind(_1, s_space_)(_1, _2);
  _2= l_1094;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= _state[0];
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= _state[0];
  _2= l_1095;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= _state[0];
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= _state[0];
  _2= l_1096;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_104, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ParseNode__s_isMethod(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop MethodNode__s_isMethod(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop MethodNode__s_withClass_selector_arguments_(oop self, oop v_classString, oop v_selectorString, oop v_argumentCollection)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_BlockNode, s_new)(_1);
  self= _1;
  _1= v_classString;
  ((struct t_MethodNode *)self)->class= _1;
  _1= v_selectorString;
  ((struct t_MethodNode *)self)->selector= _1;
  _1= v_argumentCollection;
  ((struct t_BlockNode *)self)->arguments= _1;
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_class(oop self)
{
 {
  oop _1;
  _1= ((struct t_MethodNode *)self)->class;
  return _1;
 }
}

static oop MethodNode__s_ensureReturn(oop self)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= ((struct t_SequenceNode *)self)->statements;
  _1= _bind(_1, s_isEmpty)(_1);
  if (!_1) {
 {
  _2= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(_2, s_last)(_2);
  _2= _bind(_2, s_isReturnNode)(_2);
  _2= _bind(_2, s_not)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)self)->statements;
  _3= v_BlockReturnNode;
  _4= v_VariableNode;
  _5= l_1098;
  _4= _bind(_4, s_withName_)(_4, _5);
  _3= _bind(_3, s_withValue_)(_3, _4);
  _2= _bind(_2, s_add_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_105(oop _self)
{
 {
  oop _1;
  _1= ((struct t_SequenceNode *)((struct t_BlockClosure *)_self)->receiver)->scope;
  _1= _bind(_1, s_isNil)(_1);
  return _1;
 }
}

static oop b_107(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= l_1099;
  _3= ((struct t_MethodNode *)((struct t_BlockClosure *)_self)->receiver)->class;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_1100;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop b_106(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= ((struct t_MethodNode *)((struct t_BlockClosure *)_self)->receiver)->class;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_107, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_lookup_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop MethodNode__s_encodeIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_105, 0, self, _state, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= _state[0];
  _2= self;
  _1= _bind(_1, s_innerScopeFor_)(_1, _2);
  ((struct t_SequenceNode *)self)->scope= _1;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= ((struct t_MethodNode *)self)->selector;
  _1= _bind(_1, s_declareSelector_)(_1, _2);
  ((struct t_MethodNode *)self)->selector= _1;
  _1= _state[0];
  _2= ((struct t_MethodNode *)self)->class;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_106, 0, self, _state, 0);
  _1= _bind(_1, s_lookupClass_ifAbsent_)(_1, _2, _3);
  ((struct t_MethodNode *)self)->class= _1;
  _1= ((struct t_MethodNode *)self)->class;
  _1= _bind(_1, s_isClassNode)(_1);
  if (_1) {
 {
  _2= ((struct t_SequenceNode *)self)->scope;
  _3= ((struct t_MethodNode *)self)->class;
  _2= _bind(_2, s_declareState_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= l_1101;
  _3= v_SelfVariable;
  _3= _bind(_3, s_new)(_3);
  _1= _bind(_1, s_declare_as_)(_1, _2, _3);
  _1= self;
  _2= _state[0];
  _1= _rebind(v_BlockNode, s_encodeBlock_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genDefinitions_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_genDefinition_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1102;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_108(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1106;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_arg;
  _2= _bind(_2, s_mangledName)(_2);
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop b_109(oop _self, oop v_arg)
{
 {
  oop _1, _2, _3;
  _1= v_arg;
  _1= _bind(_1, s_isExported)(_1);
  if (_1) {
 {
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_1114;
  _bind(_2, s_gen_)(_2, _3);
  _3= v_arg;
  _3= _bind(_3, s_offset)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1115;
  _bind(_2, s_gen_)(_2, _3);
  _3= v_arg;
  _3= _bind(_3, s_mangledName)(_3);
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1116;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  return _1;
 }
}

static oop MethodNode__s_genImplementationIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genImplementations_)(_1, _2);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= _state[0];
  _2= l_1103;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->class;
  _2= _bind(_2, s_name)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1104;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->selector;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1105;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_108, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->variadic;
  if (_1) {
 {
  _2= _state[0];
  _3= l_1107;
  _2= _bind(_2, s_gen_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= l_1108;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_1109;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_exportNLR)(_1);
  if (_1) {
 {
  _2= _state[0];
  _3= l_1110;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_exports)(_1);
  _2= l_1111;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= _state[0];
  _3= l_1112;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SequenceNode *)self)->scope;
  _3= _bind(_3, s_exports)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1113;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
  _2= ((struct t_BlockNode *)self)->arguments;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_109, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_exportNLR)(_1);
  if (_1) {
 {
  _2= _state[0];
  _3= l_1117;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= _state[0];
  _2= l_1118;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genInitialisations_)(_1, _2);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1119;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->class;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1120;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->selector;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1121;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->class;
  _2= _bind(_2, s_name)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1122;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->selector;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1123;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_genImplementation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1124;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1125;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop MethodNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= ((struct t_MethodNode *)self)->class;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1126;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_MethodNode *)self)->selector;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= ((struct t_BlockNode *)self)->arguments;
  _2= v_aStream;
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= v_aStream;
  _2= l_1127;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->temporaries;
  _2= v_aStream;
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= v_aStream;
  _2= l_1128;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= ((struct t_SequenceNode *)self)->literals;
  _2= v_aStream;
  _1= _bind(_1, s_printElementsOn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_110(oop _self, oop v_stmt)
{
 {
  oop _1, _2, _3, _4;
  _1= v_stmt;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _4= l_1130;
  if (_areIntegerObjects(_3, _4))
    _3= (oop)((long)_3 + (long)_4 - 1);
  else
    _3= _bind(_3, s__2b)(_3, _4);
  _1= _bind(_1, s_printOn_indent_)(_1, _2, _3);
  return _1;
 }
}

static oop MethodNode__s_printOn_indent_(oop self, oop v_aStream, oop v_indent)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_aStream;
  _state[1]= v_indent;
 {
  oop _1, _2, _3;
  _1= _state[0];
  _2= _state[1];
  _3= l_1129;
  if (_areIntegerObjects(_2, _3))
    _2= _integerObject(_integerValue(_2) * _integerValue(_3));
  else
    _2= _bind(_2, s__2a)(_2, _3);
  _1= _bind(_1, s_space_)(_1, _2);
  _1= self;
  _2= _state[0];
  _1= _bind(_1, s_printOn_)(_1, _2);
  _1= _state[0];
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->statements;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_110, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= _state[0];
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_withStatement_(oop self, oop v_parseNode)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  _2= v_parseNode;
  _1= _bind(_1, s_addStatement_)(_1, _2);
  return _1;
 }
}

static oop ExecNode__s_isMethod(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop ExecNode__s_encodeIn_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3, _4, _5, _6;
  _1= v_aScope;
  _2= self;
  _1= _bind(_1, s_innerScopeFor_)(_1, _2);
  ((struct t_SequenceNode *)self)->scope= _1;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= l_1131;
  _3= v_LocalVariable;
  _4= l_1132;
  _5= l_1133;
  _6= l_1134;
  _3= _bind(_3, s_withName_mangledName_level_)(_3, _4, _5, _6);
  _1= _bind(_1, s_declare_as_)(_1, _2, _3);
  _1= self;
  _2= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_encodeSequence_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genDefinitions_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_genDefinition_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1135;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genImplementations_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_genImplementation_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1136;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop v_stream;
  oop _1, _2, _3;
  _1= ((struct t_SequenceNode *)self)->scope;
  _2= v_unit;
  _1= _bind(_1, s_genInitialisations_)(_1, _2);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  v_stream= _1;
  _1= v_stream;
  _2= l_1137;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_SequenceNode *)self)->scope;
  _1= _bind(_1, s_exports)(_1);
  _2= l_1138;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= v_stream;
  _3= l_1139;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_SequenceNode *)self)->scope;
  _3= _bind(_3, s_exports)(_3);
  _bind(_2, s_print_)(_2, _3);
  _3= l_1140;
  _bind(_2, s_gen_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_unit;
  _1= _bind(_1, s_genSequence_)(_1, _2);
  _1= v_stream;
  _2= l_1141;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _2= l_1142;
  _1= _bind(_1, s_notImplemented_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExecNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1143;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  _2= v_aStream;
  _1= _rebind(v_SequenceNode, s_printOn_)(_1, _2);
  _1= v_aStream;
  _2= l_1144;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_withName_(oop self, oop v_nameString)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_IncludeNode *)self)->name= _1;
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_encodeIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1145;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_IncludeNode *)self)->name;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1146;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop IncludeNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1147;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_IncludeNode *)self)->name;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1148;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ImportNode__s_withNames_(oop self, oop v_nameCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameCollection;
  ((struct t_ImportNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop b_111(oop _self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_name;
  _1= _bind(_1, s_declareGlobal_)(_1, _2);
  return _1;
 }
}

static oop ImportNode__s_encodeIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_ImportNode *)self)->names;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_111, 1, self, _state, 0);
  _1= _bind(_1, s_collect_)(_1, _2);
  ((struct t_ImportNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop ImportNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1149;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop ImportNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1150;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop b_112(oop _self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1152;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_name;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1153;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_name;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1154;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop ImportNode__s_genInitialisationIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= _state[0];
  _2= l_1151;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_ImportNode *)self)->names;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_112, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ImportNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1155;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_ImportNode *)self)->names;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1156;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExportNode__s_withNames_(oop self, oop v_nameCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameCollection;
  ((struct t_ExportNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop b_115(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)_self)->outer)->_state)[0];
  _3= l_1157;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop b_114(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)_self)->outer)->_state)[0];
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_115, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_lookup_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_113(oop _self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_114, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_lookupClass_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop ExportNode__s_encodeIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_ExportNode *)self)->names;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_113, 1, self, _state, 0);
  _1= _bind(_1, s_collect_)(_1, _2);
  ((struct t_ExportNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop ExportNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop ExportNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop b_116(oop _self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1158;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1159;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_name;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1160;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_name;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1161;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop ExportNode__s_genInitialisationIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= ((struct t_ExportNode *)self)->names;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_116, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExportNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1162;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_ExportNode *)self)->names;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1163;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop RequireNode__s_withNames_(oop self, oop v_nameCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameCollection;
  ((struct t_RequireNode *)self)->names= _1;
  _1= self;
  return _1;
 }
}

static oop RequireNode__s_encodeIn_(oop self, oop v_aScope)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop RequireNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop RequireNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop b_117(oop _self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1164;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1165;
  _bind(_1, s_gen_)(_1, _2);
  _2= v_name;
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1166;
  _bind(_1, s_gen_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop RequireNode__s_genInitialisationIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= ((struct t_RequireNode *)self)->names;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_117, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop RequireNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1167;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_RequireNode *)self)->names;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1168;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_name(oop self)
{
 {
  oop _1;
  _1= ((struct t_ClassNode *)self)->name;
  return _1;
 }
}

static oop ClassNode__s_base(oop self)
{
 {
  oop _1;
  _1= ((struct t_ClassNode *)self)->base;
  return _1;
 }
}

static oop ClassNode__s_mangledName(oop self)
{
 {
  oop _1;
  _1= ((struct t_ClassNode *)self)->mangledName;
  return _1;
 }
}

static oop ClassNode__s_typeName(oop self)
{
 {
  oop _1;
  _1= ((struct t_ClassNode *)self)->typeName;
  return _1;
 }
}

static oop ClassNode__s_slots(oop self)
{
 {
  oop _1;
  _1= ((struct t_ClassNode *)self)->slots;
  return _1;
 }
}

static oop Object__s_isClassNode(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop ClassNode__s_isClassNode(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop ClassNode__s_withName_base_slots_(oop self, oop v_nameString, oop v_baseString, oop v_slotCollection)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_ClassNode *)self)->name= _1;
  _1= v_baseString;
  ((struct t_ClassNode *)self)->base= _1;
  _1= v_slotCollection;
  ((struct t_ClassNode *)self)->slots= _1;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_withName_(oop self, oop v_nameString)
{
 {
  oop _1, _2;
  _1= l_1169;
  _2= v_nameString;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_ClassNode *)self)->name= _1;
  _1= v_nil;
  ((struct t_ClassNode *)self)->base= _1;
  _1= v_nil;
  ((struct t_ClassNode *)self)->slots= _1;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s__3d(oop self, oop v_aClassNode)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_aClassNode;
  _1= _bind(_1, s_isClassNode)(_1);
  if (_1) {
 {
  _2= ((struct t_ClassNode *)self)->name;
  _3= v_aClassNode;
  _3= _bind(_3, s_name)(_3);
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
  if (_2) {
 {
  _3= ((struct t_ClassNode *)self)->base;
  _4= v_aClassNode;
  _4= _bind(_4, s_base)(_4);
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 == (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3d)(_3, _4);
  if (_3) {
 {
  _4= ((struct t_ClassNode *)self)->slots;
  _5= v_aClassNode;
  _5= _bind(_5, s_slots)(_5);
  if (_areIntegerObjects(_4, _5))
    _4= ((long)_4 == (long)_5) ? v_true : v_false;
  else
    _4= _bind(_4, s__3d)(_4, _5);
 }
  _3= _4;
  }
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  return _1;
 }
}

static oop b_118(oop _self, oop v_slot)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_slot;
  _2= _bind(_2, s_name)(_2);
  _3= v_slot;
  _1= _bind(_1, s_declare_as_)(_1, _2, _3);
  return _1;
 }
}

static oop ClassNode__s_declareIn_(oop self, oop v_aScope)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aScope;
 {
  oop _1, _2, _3;
  _1= ((struct t_ClassNode *)self)->slots;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_ClassNode *)self)->slots;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_118, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_119(oop _self, oop v_slotName)
{
 {
  oop v_var;
  oop _1, _2, _3, _4;
  _1= v_ReceiverVariable;
  _2= v_slotName;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _4= v_slotName;
  _3= _bind(_3, s_mangleSlot_)(_3, _4);
  _4= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_withName_mangledName_class_)(_1, _2, _3, _4);
  v_var= _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= v_var;
  _1= _bind(_1, s_includes_)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= l_1172;
  _4= v_slotName;
  _3= _bind(_3, s__2c)(_3, _4);
  _4= l_1173;
  _3= _bind(_3, s__2c)(_3, _4);
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[1];
  _2= v_var;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop ClassNode__s_encodeIn_(oop self, oop v_translationUnit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 2);
  _state[0]= v_translationUnit;
 {
  oop v_declaration;
  oop _1, _2, _3, _4, _5;
  _1= _state[0];
  _2= ((struct t_ClassNode *)self)->name;
  _1= _bind(_1, s_mangleVariable_)(_1, _2);
  ((struct t_ClassNode *)self)->mangledName= _1;
  _1= l_1170;
  _2= ((struct t_ClassNode *)self)->name;
  _1= _bind(_1, s__2c)(_1, _2);
  ((struct t_ClassNode *)self)->typeName= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  _state[1]= _1;
  _1= ((struct t_ClassNode *)self)->base;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= _state[0];
  _3= ((struct t_ClassNode *)self)->base;
  _2= _bind(_2, s_lookupClass_)(_2, _3);
  ((struct t_ClassNode *)self)->base= _2;
  _2= ((struct t_ClassNode *)self)->base;
  _2= _bind(_2, s_isClassNode)(_2);
  if (!_2) {
 {
  _3= self;
  _4= l_1171;
  _5= ((struct t_ClassNode *)self)->base;
  _5= _bind(_5, s_printString)(_5);
  _4= _bind(_4, s__2c)(_4, _5);
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= _state[1];
  _3= ((struct t_ClassNode *)self)->base;
  _3= _bind(_3, s_slots)(_3);
  _2= _bind(_2, s_addAll_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_ClassNode *)self)->slots;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_ClassNode *)self)->slots;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_119, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
  _2= _state[1];
  _2= _bind(_2, s_asArray)(_2);
  ((struct t_ClassNode *)self)->slots= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= _state[0];
  _2= self;
  _1= _bind(_1, s_declareClass_)(_1, _2);
  v_declaration= _1;
  _1= ((struct t_ClassNode *)self)->slots;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= v_declaration;
  _3= self;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= _state[0];
  _4= l_1174;
  _bind(_3, s_declareSelector_)(_3, _4);
  _4= l_1175;
  _3= _bind(_3, s_declareSelector_)(_3, _4);
 }
  } else {
 {
  _3= v_nil;
  ((struct t_ClassNode *)self)->name= _3;
 }
  } _2= _3;
 }
  _1= _2;
  } else _1= 0;
  _1= v_declaration;
  return _1;
 }
}

static oop b_120(oop _self, oop v_slot)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1179;
  _3= v_slot;
  _3= _bind(_3, s_name)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_1180;
  _2= _bind(_2, s__2c)(_2, _3);
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop ClassNode__s_genDeclarationIn_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3;
  _1= ((struct t_ClassNode *)self)->name;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_ClassNode *)self)->slots;
  _2= _bind(_2, s_notNil)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _state[0]= _2;
  _2= _state[0];
  _3= l_1176;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _3= ((struct t_ClassNode *)self)->name;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1177;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1178;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
  _2= ((struct t_ClassNode *)self)->slots;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_120, 1, self, _state, 0);
  _2= _bind(_2, s_do_)(_2, _3);
  _2= _state[0];
  _3= l_1181;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_ClassNode *)self)->name;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_ClassNode *)self)->slots;
  _2= _bind(_2, s_notNil)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _3= l_1182;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ClassNode *)self)->name;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1183;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ClassNode *)self)->name;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1184;
  _bind(_2, s_gen_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1185;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ClassNode *)self)->name;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1186;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_ClassNode *)self)->name;
  _bind(_2, s_gen_)(_2, _3);
  _3= l_1187;
  _bind(_2, s_gen_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= ((struct t_ClassNode *)self)->name;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  oop v_stream;
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  v_stream= _2;
  _2= ((struct t_ClassNode *)self)->slots;
  _2= _bind(_2, s_notNil)(_2);
  if (_2) {
 {
  _3= ((struct t_ClassNode *)self)->base;
  _3= _bind(_3, s_notNil)(_3);
  if (_3) {
 {
  _4= v_stream;
  _5= l_1188;
  _bind(_4, s_gen_)(_4, _5);
  _5= ((struct t_ClassNode *)self)->mangledName;
  _bind(_4, s_gen_)(_4, _5);
  _5= l_1189;
  _bind(_4, s_gen_)(_4, _5);
  _5= ((struct t_ClassNode *)self)->base;
  _5= _bind(_5, s_mangledName)(_5);
  _bind(_4, s_gen_)(_4, _5);
  _5= l_1190;
  _bind(_4, s_gen_)(_4, _5);
  _4= _bind(_4, s_nl)(_4);
 }
  } else {
 {
  _4= v_stream;
  _5= l_1191;
  _bind(_4, s_gen_)(_4, _5);
  _5= ((struct t_ClassNode *)self)->mangledName;
  _bind(_4, s_gen_)(_4, _5);
  _5= l_1192;
  _bind(_4, s_gen_)(_4, _5);
  _4= _bind(_4, s_nl)(_4);
 }
  } _3= _4;
  _3= v_stream;
  _4= l_1193;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->mangledName;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1194;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->name;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1195;
  _bind(_3, s_gen_)(_3, _4);
  _bind(_3, s_nl)(_3);
  _4= l_1196;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->mangledName;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1197;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->name;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1198;
  _bind(_3, s_gen_)(_3, _4);
  _3= _bind(_3, s_nl)(_3);
 }
  } else {
 {
  _3= v_stream;
  _4= l_1199;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->mangledName;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1200;
  _bind(_3, s_gen_)(_3, _4);
  _4= ((struct t_ClassNode *)self)->mangledName;
  _bind(_3, s_gen_)(_3, _4);
  _4= l_1201;
  _bind(_3, s_gen_)(_3, _4);
  _3= _bind(_3, s_nl)(_3);
 }
  } _2= _3;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2, _3, _4;
  _1= v_aStream;
  _2= ((struct t_ClassNode *)self)->name;
  _2= _bind(_2, s_isNil)(_2);
  if (_2) {
 {
  _3= l_1202;
 }
  } else {
 {
  _3= ((struct t_ClassNode *)self)->name;
 }
  } _2= _3;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1203;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= ((struct t_ClassNode *)self)->base;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= v_aStream;
  _3= ((struct t_ClassNode *)self)->base;
  _2= _bind(_2, s_print_)(_2, _3);
 }
  } else {
 {
  _2= v_aStream;
  _3= ((struct t_ClassNode *)self)->base;
  _3= _bind(_3, s_isString)(_3);
  if (_3) {
 {
  _4= ((struct t_ClassNode *)self)->base;
 }
  } else {
 {
  _4= ((struct t_ClassNode *)self)->base;
  _4= _bind(_4, s_name)(_4);
 }
  } _3= _4;
  _2= _bind(_2, s_nextPutAll_)(_2, _3);
 }
  } _1= _2;
  _1= ((struct t_ClassNode *)self)->slots;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= v_aStream;
  _3= l_1204;
  _2= _bind(_2, s_nextPutAll_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_ClassNode *)self)->slots;
  _3= v_aStream;
  _2= _bind(_2, s_printElementsOn_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop ClassNode__s_forGobble_(oop self, oop v_translationUnit)
{
 {
  oop _1, _2;
  _1= l_1205;
  _2= self;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= v_ExternalClassNode;
  _2= self;
  _1= _bind(_1, s_on_)(_1, _2);
  return _1;
 }
}

static oop ExternalClassNode__s_on_(oop self, oop v_aClassNode)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_aClassNode;
  ((struct t_ExternalClassNode *)self)->classNode= _1;
  _1= self;
  return _1;
 }
}

static oop ExternalClassNode__s_encodeIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_ExternalClassNode *)self)->classNode;
  _2= v_unit;
  _1= _bind(_1, s_encodeIn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExternalClassNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= ((struct t_ExternalClassNode *)self)->classNode;
  _2= v_unit;
  _1= _bind(_1, s_genDeclarationIn_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ExternalClassNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop ExternalClassNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop ExternalClassNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1206;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_ExternalClassNode *)self)->classNode;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1207;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_withText_(oop self, oop v_aString)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_aString;
  ((struct t_TemplateNode *)self)->text= _1;
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_encodeIn_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_printString)(_1);
  _2= l_1208;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_unit;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_genDeclarationIn_(oop self, oop v_unit)
{
 {
  oop v_string;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_printString)(_1);
  _2= l_1209;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_unit;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  v_string= _1;
  _1= _bind(_1, s_println)(_1);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1210;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_string;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1211;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_genImplementationIn_(oop self, oop v_unit)
{
 {
  oop v_string;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_printString)(_1);
  _2= l_1212;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_unit;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  v_string= _1;
  _1= _bind(_1, s_println)(_1);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1213;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_string;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1214;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_genInitialisationIn_(oop self, oop v_unit)
{
 {
  oop v_string;
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_printString)(_1);
  _2= l_1215;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= v_unit;
  _2= _bind(_2, s_printString)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  v_string= _1;
  _1= _bind(_1, s_println)(_1);
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1216;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_string;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1217;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop TemplateNode__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= l_1218;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= ((struct t_TemplateNode *)self)->text;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1219;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Object__s_isNamedVariable(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop NamedVariable__s_isNamedVariable(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop NamedVariable__s_withName_mangledName_(oop self, oop v_nameString, oop v_mangledString)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_Variable, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_NamedVariable *)self)->name= _1;
  _1= v_mangledString;
  ((struct t_NamedVariable *)self)->mangledName= _1;
  _1= self;
  return _1;
 }
}

static oop NamedVariable__s_name(oop self)
{
 {
  oop _1;
  _1= ((struct t_NamedVariable *)self)->name;
  return _1;
 }
}

static oop NamedVariable__s_mangledName(oop self)
{
 {
  oop _1;
  _1= ((struct t_NamedVariable *)self)->mangledName;
  return _1;
 }
}

static oop NamedVariable__s__3d(oop self, oop v_anObject)
{
 {
  oop _1, _2, _3, _4;
  _1= v_anObject;
  _1= _bind(_1, s_isNamedVariable)(_1);
  if (_1) {
 {
  _2= ((struct t_NamedVariable *)self)->name;
  _3= v_anObject;
  _3= _bind(_3, s_name)(_3);
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
  if (_2) {
 {
  _3= ((struct t_NamedVariable *)self)->mangledName;
  _4= v_anObject;
  _4= _bind(_4, s_mangledName)(_4);
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 == (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3d)(_3, _4);
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  return _1;
 }
}

static oop NamedVariable__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= ((struct t_NamedVariable *)self)->mangledName;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop NamedVariable__s_printOn_(oop self, oop v_aStream)
{
 {
  oop _1, _2;
  _1= v_aStream;
  _2= ((struct t_NamedVariable *)self)->name;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1220;
  _bind(_1, s_nextPut_)(_1, _2);
  _2= ((struct t_NamedVariable *)self)->mangledName;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1221;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop ReceiverVariable__s_withName_mangledName_class_(oop self, oop v_nameString, oop v_mangledString, oop v_classNode)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_nameString;
  _3= v_mangledString;
  _1= _rebind(v_NamedVariable, s_withName_mangledName_)(_1, _2, _3);
  self= _1;
  _1= v_classNode;
  ((struct t_ReceiverVariable *)self)->class= _1;
  _1= self;
  return _1;
 }
}

static oop ReceiverVariable__s_class(oop self)
{
 {
  oop _1;
  _1= ((struct t_ReceiverVariable *)self)->class;
  return _1;
 }
}

static oop ReceiverVariable__s_isExported(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop ReceiverVariable__s_exportedTo_(oop self, oop v_aScope)
{
 {
  oop _1, _2;
  _1= v_aScope;
  _1= _bind(_1, s_noteExportSelf)(_1);
  _1= v_RemoteReceiverVariable;
  _2= self;
  _1= _bind(_1, s_withVariable_)(_1, _2);
  return _1;
 }
}

static oop ReceiverVariable__s_exportFrom_(oop self, oop v_aScope)
{
 {
  oop _1;
  _1= v_aScope;
  _1= _bind(_1, s_noteExportSelf)(_1);
  _1= self;
  return _1;
 }
}

static oop ReceiverVariable__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1222;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_ReceiverVariable *)self)->class;
  _2= _bind(_2, s_typeName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1223;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_NamedVariable *)self)->name;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop RemoteReceiverVariable__s_withVariable_(oop self, oop v_aVariable)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_aVariable;
  ((struct t_RemoteReceiverVariable *)self)->receiverVariable= _1;
  _1= self;
  return _1;
 }
}

static oop RemoteReceiverVariable__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1224;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_RemoteReceiverVariable *)self)->receiverVariable;
  _2= _bind(_2, s_class)(_2);
  _2= _bind(_2, s_typeName)(_2);
  _bind(_1, s_gen_)(_1, _2);
  _2= l_1225;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_RemoteReceiverVariable *)self)->receiverVariable;
  _2= _bind(_2, s_name)(_2);
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop LocalVariable__s_withName_mangledName_level_(oop self, oop v_nameString, oop v_mangledString, oop v_levelInteger)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_nameString;
  _3= v_mangledString;
  _1= _rebind(v_NamedVariable, s_withName_mangledName_)(_1, _2, _3);
  self= _1;
  _1= v_false;
  ((struct t_LocalVariable *)self)->isExported= _1;
  _1= v_levelInteger;
  ((struct t_LocalVariable *)self)->level= _1;
  _1= l_1226;
  ((struct t_LocalVariable *)self)->offset= _1;
  _1= self;
  return _1;
 }
}

static oop LocalVariable__s_isExported(oop self)
{
 {
  oop _1;
  _1= ((struct t_LocalVariable *)self)->isExported;
  return _1;
 }
}

static oop LocalVariable__s_level(oop self)
{
 {
  oop _1;
  _1= ((struct t_LocalVariable *)self)->level;
  return _1;
 }
}

static oop LocalVariable__s_offset(oop self)
{
 {
  oop _1;
  _1= ((struct t_LocalVariable *)self)->offset;
  return _1;
 }
}

static oop b_121(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_LocalVariable *)((struct t_BlockClosure *)_self)->receiver)->level;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= _bind(_2, s_level)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  return _1;
 }
}

static oop LocalVariable__s_exportFrom_(oop self, oop v_aScope)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_aScope;
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_121, 0, self, _state, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= ((struct t_LocalVariable *)self)->isExported;
  if (!_1) {
 {
  _2= v_true;
  ((struct t_LocalVariable *)self)->isExported= _2;
  _2= _state[0];
  _2= _bind(_2, s_nextExportOffset)(_2);
  ((struct t_LocalVariable *)self)->offset= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop LocalVariable__s_exportedTo_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3;
  _1= v_RemoteVariable;
  _2= v_aScope;
  _2= _bind(_2, s_level)(_2);
  _3= ((struct t_LocalVariable *)self)->level;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 - (long)_3 + 1);
  else
    _2= _bind(_2, s__2d)(_2, _3);
  _3= ((struct t_LocalVariable *)self)->offset;
  _1= _bind(_1, s_level_offset_)(_1, _2, _3);
  return _1;
 }
}

static oop LocalVariable__s_gen_(oop self, oop v_unit)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_LocalVariable *)self)->isExported;
  if (_1) {
 {
  _2= v_unit;
  _2= _bind(_2, s_outputStream)(_2);
  _3= l_1227;
  _bind(_2, s_gen_)(_2, _3);
  _3= ((struct t_LocalVariable *)self)->offset;
  _bind(_2, s_print_)(_2, _3);
  _3= l_1228;
  _2= _bind(_2, s_gen_)(_2, _3);
 }
  } else {
 {
  _2= self;
  _3= v_unit;
  _2= _rebind(v_NamedVariable, s_gen_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop GlobalVariable__s_level(oop self)
{
 {
  oop _1;
  _1= l_1229;
  return _1;
 }
}

static oop GlobalVariable__s_exportedTo_(oop self, oop v_aScope)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop SelfVariable__s_new(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_1230;
  _3= l_1231;
  _1= _bind(_1, s_withName_mangledName_)(_1, _2, _3);
  return _1;
 }
}

static oop SelfVariable__s_isExported(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop SelfVariable__s_exportedTo_(oop self, oop v_aScope)
{
 {
  oop _1, _2, _3, _4;
  _1= v_aScope;
  _1= _bind(_1, s_noteExportSelf)(_1);
  _1= v_LocalVariable;
  _2= l_1232;
  _3= l_1233;
  _4= v_aScope;
  _4= _bind(_4, s_level)(_4);
  _1= _bind(_1, s_withName_mangledName_level_)(_1, _2, _3, _4);
  return _1;
 }
}

static oop Object__s_isRemoteVariable(oop self)
{
 {
  oop _1;
  _1= v_false;
  return _1;
 }
}

static oop RemoteVariable__s_isRemoteVariable(oop self)
{
 {
  oop _1;
  _1= v_true;
  return _1;
 }
}

static oop RemoteVariable__s_level_offset_(oop self, oop v_levelInteger, oop v_offsetInteger)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_levelInteger;
  ((struct t_RemoteVariable *)self)->level= _1;
  _1= v_offsetInteger;
  ((struct t_RemoteVariable *)self)->offset= _1;
  _1= self;
  return _1;
 }
}

static oop b_122(oop _self)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1235;
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop b_123(oop _self)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1238;
  _1= _bind(_1, s_gen_)(_1, _2);
  return _1;
 }
}

static oop RemoteVariable__s_gen_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_unit;
  _1= _bind(_1, s_outputStream)(_1);
  _state[0]= _1;
  _1= _state[0];
  _2= l_1234;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_RemoteVariable *)self)->level;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_122, 0, self, _state, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= _state[0];
  _2= l_1236;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= ((struct t_RemoteVariable *)self)->level;
  _2= l_1237;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_123, 0, self, _state, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= _state[0];
  _2= l_1239;
  _bind(_1, s_gen_)(_1, _2);
  _2= ((struct t_RemoteVariable *)self)->offset;
  _bind(_1, s_print_)(_1, _2);
  _2= l_1240;
  _1= _bind(_1, s_gen_)(_1, _2);
  _1= self;
  return _1;
 }
}

static int   CompilerOutputStream__5fsizeof(oop self) { return sizeof(struct t_CompilerOutputStream); }
static char *CompilerOutputStream__5fdebugName(oop self) { return "CompilerOutputStream"; }

static oop CompilerOutputStream__s_gen_(oop self, oop v_aString)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aString;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_new(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _1= _rebind(v_Object, s_new)(_1);
  self= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_TranslationUnit *)self)->environment= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_TranslationUnit *)self)->externals= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_TranslationUnit *)self)->classes= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_TranslationUnit *)self)->selectors= _1;
  _1= v_CompilerOutputStream;
  _2= v_String;
  _2= _bind(_2, s_new)(_2);
  _1= _bind(_1, s_on_)(_1, _2);
  ((struct t_TranslationUnit *)self)->outputStream= _1;
  _1= self;
  return _1;
 }
}

static oop TranslationUnit__s_outputStream(oop self)
{
 {
  oop _1;
  _1= ((struct t_TranslationUnit *)self)->outputStream;
  return _1;
 }
}

static oop TranslationUnit__s_level(oop self)
{
 {
  oop _1;
  _1= l_1241;
  return _1;
 }
}

static oop TranslationUnit__s_note_(oop self, oop v_message)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop TranslationUnit__s_mangleVariable_(oop self, oop v_name)
{
 {
  oop _1, _2;
  _1= l_1242;
  _2= v_name;
  _1= _bind(_1, s__2c)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_mangleSelector_(oop self, oop v_selector)
{
 {
  oop v_in;
  oop v_out;
  oop _1, _2, _3, _4;
  _1= v_selector;
  _1= _bind(_1, s_readStream)(_1);
  v_in= _1;
  _1= v_String;
  _1= _bind(_1, s_new)(_1);
  _1= _bind(_1, s_writeStream)(_1);
  v_out= _1;
  _1= v_out;
  _2= l_1243;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  for (;;) {
 {
  _1= v_in;
  _1= _bind(_1, s_atEnd)(_1);
 }
  if (_1) break;
 {
  oop v_c;
  _1= v_in;
  _1= _bind(_1, s_next)(_1);
  v_c= _1;
  _1= v_c;
  _2= l_1244;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_out;
  _3= l_1245;
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } else {
 {
  _2= v_c;
  _2= _bind(_2, s_isLetter)(_2);
  if (!_2) {
 {
  _3= v_c;
  _3= _bind(_3, s_isDigit)(_3);
 }
  _2= _3;
  }
  if (_2) {
 {
  _3= v_out;
  _4= v_c;
  _3= _bind(_3, s_nextPut_)(_3, _4);
 }
  } else {
 {
  _3= v_out;
  _4= l_1246;
  _bind(_3, s_nextPut_)(_3, _4);
  _4= v_c;
  _4= _bind(_4, s_asciiValue)(_4);
  _4= _bind(_4, s_hex2)(_4);
  _3= _bind(_3, s_nextPutAll_)(_3, _4);
 }
  } _2= _3;
 }
  } _1= _2;
 }
  };
  _1= v_out;
  _1= _bind(_1, s_contents)(_1);
  return _1;
 }
}

static oop TranslationUnit__s_mangleSlot_(oop self, oop v_name)
{
 {
  oop _1;
  _1= v_name;
  return _1;
 }
}

static oop TranslationUnit__s_declareGlobal_(oop self, oop v_name)
{
 {
  oop _1, _2, _3, _4, _5, _6;
  _1= ((struct t_TranslationUnit *)self)->environment;
  _2= v_name;
  _3= v_GlobalVariable;
  _4= v_name;
  _5= self;
  _6= v_name;
  _5= _bind(_5, s_mangleVariable_)(_5, _6);
  _3= _bind(_3, s_withName_mangledName_)(_3, _4, _5);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop b_124(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop TranslationUnit__s_declareClass_(oop self, oop v_classNode)
{
 {
  oop v_decl;
  oop _1, _2, _3, _4, _5, _6, _7;
  _1= ((struct t_TranslationUnit *)self)->classes;
  _2= v_classNode;
  _2= _bind(_2, s_name)(_2);
  _3= c_124;
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  v_decl= _1;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= ((struct t_TranslationUnit *)self)->classes;
  _3= v_classNode;
  _3= _bind(_3, s_name)(_3);
  _4= v_classNode;
  _2= _bind(_2, s_at_put_)(_2, _3, _4);
  v_decl= _2;
  _2= ((struct t_TranslationUnit *)self)->environment;
  _3= v_classNode;
  _3= _bind(_3, s_name)(_3);
  _4= v_GlobalVariable;
  _5= v_classNode;
  _5= _bind(_5, s_name)(_5);
  _6= self;
  _7= v_classNode;
  _7= _bind(_7, s_name)(_7);
  _6= _bind(_6, s_mangleVariable_)(_6, _7);
  _4= _bind(_4, s_withName_mangledName_)(_4, _5, _6);
  _2= _bind(_2, s_at_put_)(_2, _3, _4);
 }
  } else {
 {
  _2= v_decl;
  _3= v_classNode;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 != (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__7e_3d)(_2, _3);
  if (_2) {
 {
  _3= self;
  _4= l_1247;
  _5= v_classNode;
  _5= _bind(_5, s_printString)(_5);
  _4= _bind(_4, s__2c)(_4, _5);
  _5= l_1248;
  _4= _bind(_4, s__2c)(_4, _5);
  _5= v_decl;
  _5= _bind(_5, s_printString)(_5);
  _4= _bind(_4, s__2c)(_4, _5);
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
 }
  } _1= _2;
  _1= v_decl;
  return _1;
 }
}

static oop b_125(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop TranslationUnit__s_lookupClass_ifAbsent_(oop self, oop v_name, oop v_errorBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_errorBlock;
 {
  oop _1, _2, _3;
  _1= ((struct t_TranslationUnit *)self)->classes;
  _2= v_name;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_125, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_126(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= l_1249;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_1250;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_lookupClass_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_126, 0, self, _state, 0);
  _1= _bind(_1, s_lookupClass_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_127(oop _self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_TranslationUnit *)((struct t_BlockClosure *)_self)->receiver)->selectors;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((struct t_BlockClosure *)_self)->receiver;
  _4= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= _bind(_3, s_mangleSelector_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop TranslationUnit__s_declareSelector_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= ((struct t_TranslationUnit *)self)->selectors;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_127, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_128(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= l_1251;
  _3= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_1252;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_lookupSelector_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= ((struct t_TranslationUnit *)self)->selectors;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_128, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_129(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_value)(_1);
  return _1;
 }
}

static oop TranslationUnit__s_lookup_ifAbsent_(oop self, oop v_name, oop v_errorBlock)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_errorBlock;
 {
  oop _1, _2, _3;
  _1= ((struct t_TranslationUnit *)self)->environment;
  _2= v_name;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_129, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_130(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_1253;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_lookup_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= self;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_130, 0, self, _state, 0);
  _1= _bind(_1, s_lookup_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_131(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= l_1254;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop TranslationUnit__s_lookupFree_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= ((struct t_TranslationUnit *)self)->environment;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_131, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop TranslationUnit__s_innerScopeFor_(oop self, oop v_blockNode)
{
 {
  oop _1, _2, _3;
  _1= v_Scope;
  _2= self;
  _3= v_blockNode;
  _1= _bind(_1, s_withParent_block_)(_1, _2, _3);
  return _1;
 }
}

static oop TranslationUnit__s_tempCount(oop self)
{
 {
  oop _1;
  _1= l_1255;
  return _1;
 }
}

static oop b_132(oop _self, oop v_x, oop v_y)
{
 {
  oop _1, _2;
  _1= v_x;
  _1= _bind(_1, s_name)(_1);
  _2= v_y;
  _2= _bind(_2, s_name)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 <= (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c_3d)(_1, _2);
  return _1;
 }
}

static oop b_133(oop _self, oop v_variable)
{
 {
  oop _1, _2;
  _1= ((struct t_TranslationUnit *)((struct t_BlockClosure *)_self)->receiver)->outputStream;
  _2= l_1256;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_variable;
  _2= _bind(_2, s_mangledName)(_2);
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1257;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop b_134(oop _self, oop v_selector)
{
 {
  oop _1, _2;
  _1= ((struct t_TranslationUnit *)((struct t_BlockClosure *)_self)->receiver)->outputStream;
  _2= l_1258;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_selector;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1259;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop TranslationUnit__s_genDefinitions(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_TranslationUnit *)self)->environment;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_132, 2, self, 0, 0);
  _1= _bind(_1, s_asSortedCollection_)(_1, _2);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_133, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_TranslationUnit *)self)->selectors;
  _1= _bind(_1, s_asSortedCollection)(_1);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_134, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_TranslationUnit *)self)->outputStream;
  _1= _bind(_1, s_nl)(_1);
  _1= self;
  return _1;
 }
}

static oop b_135(oop _self, oop v_name, oop v_mangled)
{
 {
  oop _1, _2;
  _1= ((struct t_TranslationUnit *)((struct t_BlockClosure *)_self)->receiver)->outputStream;
  _2= l_1260;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_mangled;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1261;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= v_name;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _2= l_1262;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  return _1;
 }
}

static oop TranslationUnit__s_genInitialisations(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_TranslationUnit *)self)->selectors;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_135, 2, self, 0, 0);
  _1= _bind(_1, s_keysAndSortedValuesDo_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scope__s_withParent_block_(oop self, oop v_parentScope, oop v_blockNode)
{
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_parentScope;
  _1= _bind(_1, s_level)(_1);
  _2= l_1263;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_Scope *)self)->level= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scope *)self)->environment= _1;
  _1= v_Dictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scope *)self)->imports= _1;
  _1= l_1264;
  ((struct t_Scope *)self)->exports= _1;
  _1= v_parentScope;
  ((struct t_Scope *)self)->parent= _1;
  _1= v_blockNode;
  ((struct t_Scope *)self)->block= _1;
  _1= v_false;
  ((struct t_Scope *)self)->exportSelf= _1;
  _1= v_false;
  ((struct t_Scope *)self)->exportOuter= _1;
  _1= v_false;
  ((struct t_Scope *)self)->exportNLR= _1;
  _1= l_1265;
  ((struct t_Scope *)self)->nTemps= _1;
  ((struct t_Scope *)self)->maxTemp= _1;
  ((struct t_Scope *)self)->minTemp= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scope *)self)->literals= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scope *)self)->blocks= _1;
  _1= self;
  return _1;
 }
}

static oop Scope__s_level(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->level;
  return _1;
 }
}

static oop Scope__s_parent(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->parent;
  return _1;
 }
}

static oop Scope__s_exports(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->exports;
  return _1;
 }
}

static oop Scope__s_exportNLR(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->exportNLR;
  return _1;
 }
}

static oop Scope__s_exportSelf(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->exportSelf;
  return _1;
 }
}

static oop Scope__s_exportOuter(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->exportOuter;
  return _1;
 }
}

static oop Scope__s_isMethod(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->block;
  _1= _bind(_1, s_isMethod)(_1);
  return _1;
 }
}

static oop Scope__s_class(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->block;
  _1= _bind(_1, s_isMethod)(_1);
  if (_1) {
 {
  _2= ((struct t_Scope *)self)->block;
  _2= _bind(_2, s_class)(_2);
 }
  } else {
 {
  _2= ((struct t_Scope *)self)->parent;
  _2= _bind(_2, s_class)(_2);
 }
  } _1= _2;
  return _1;
 }
}

static oop Scope__s_addBlock_(oop self, oop v_blockNode)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->blocks;
  _2= v_blockNode;
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scope__s_resetTemps(oop self)
{
 {
  oop _1;
  _1= l_1266;
  ((struct t_Scope *)self)->nTemps= _1;
  ((struct t_Scope *)self)->maxTemp= _1;
  ((struct t_Scope *)self)->minTemp= _1;
  _1= self;
  return _1;
 }
}

static oop Scope__s_tempCount(oop self)
{
 {
  oop _1;
  _1= ((struct t_Scope *)self)->maxTemp;
  return _1;
 }
}

static oop Scope__s_newTemp(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scope *)self)->maxTemp;
  _2= ((struct t_Scope *)self)->nTemps;
  _3= l_1267;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_Scope *)self)->nTemps= _2;
  _1= _bind(_1, s_max_)(_1, _2);
  ((struct t_Scope *)self)->maxTemp= _1;
  _1= ((struct t_Scope *)self)->nTemps;
  return _1;
 }
}

static oop b_136(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)((struct t_BlockClosure *)_self)->receiver)->nTemps;
  _2= ((struct t_Scope *)((struct t_BlockClosure *)_self)->receiver)->minTemp;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  return _1;
 }
}

static oop Scope__s_freeTemp(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_136, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= ((struct t_Scope *)self)->nTemps;
  _2= l_1268;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  ((struct t_Scope *)self)->nTemps= _1;
  _1= self;
  return _1;
 }
}

static oop b_137(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_freeTemp)(_1);
  return _1;
 }
}

static oop Scope__s_freeTemps_(oop self, oop v_count)
{
 {
  oop _1, _2;
  _1= v_count;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_137, 0, self, 0, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scope__s_isStatic(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_Scope *)self)->parent;
  _1= _bind(_1, s_exportNLR)(_1);
  if (!_1) {
 {
  _2= ((struct t_Scope *)self)->parent;
  _2= _bind(_2, s_exports)(_2);
  _3= l_1269;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 > (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3e)(_2, _3);
  if (!_2) {
 {
  _3= ((struct t_Scope *)self)->parent;
  _3= _bind(_3, s_exportSelf)(_3);
  if (!_3) {
 {
  _4= ((struct t_Scope *)self)->parent;
  _4= _bind(_4, s_exportOuter)(_4);
 }
  _3= _4;
  }
 }
  _2= _3;
  }
 }
  _1= _2;
  }
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop Scope__s_mangleVariable_(oop self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->parent;
  _2= v_name;
  _1= _bind(_1, s_mangleVariable_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_declareLiteral_(oop self, oop v_literal)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->literals;
  _2= v_literal;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_declareSelector_(oop self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->parent;
  _2= v_name;
  _1= _bind(_1, s_declareSelector_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_declareState_(oop self, oop v_classNode)
{
 {
  oop _1, _2;
  _1= v_classNode;
  _2= self;
  _1= _bind(_1, s_declareIn_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_declare_as_(oop self, oop v_name, oop v_node)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scope *)self)->environment;
  _2= v_name;
  _3= v_node;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Scope__s_declareLocal_(oop self, oop v_name)
{
 {
  oop _1, _2, _3, _4, _5, _6;
  _1= ((struct t_Scope *)self)->environment;
  _2= v_name;
  _3= v_LocalVariable;
  _4= v_name;
  _5= ((struct t_Scope *)self)->parent;
  _6= v_name;
  _5= _bind(_5, s_mangleVariable_)(_5, _6);
  _6= ((struct t_Scope *)self)->level;
  _3= _bind(_3, s_withName_mangledName_level_)(_3, _4, _5, _6);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop Scope__s_lookupClass_(oop self, oop v_name)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->parent;
  _2= v_name;
  _1= _bind(_1, s_lookupClass_)(_1, _2);
  return _1;
 }
}

static oop b_139(oop _self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_Scope *)((struct t_BlockClosure *)_self)->receiver)->imports;
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)_self)->outer)->_state)[0];
  _3= ((struct t_Scope *)((struct t_BlockClosure *)_self)->receiver)->parent;
  _4= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)_self)->outer)->_state)[0];
  _3= _bind(_3, s_lookupFree_)(_3, _4);
  _4= ((struct t_BlockClosure *)_self)->receiver;
  _3= _bind(_3, s_exportedTo_)(_3, _4);
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  return _1;
 }
}

static oop b_138(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scope *)((struct t_BlockClosure *)_self)->receiver)->imports;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_139, 0, ((struct t_BlockClosure *)_self)->receiver, 0, _self);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop Scope__s_lookup_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_name;
 {
  oop _1, _2, _3;
  _1= ((struct t_Scope *)self)->environment;
  _2= _state[0];
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_138, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  return _1;
 }
}

static oop b_140(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _1;
 }
}

static oop b_141(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_isRemoteVariable)(_1);
  _1= _bind(_1, s_not)(_1);
  return _1;
 }
}

static oop Scope__s_lookupFree_(oop self, oop v_name)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_Scope *)self)->environment;
  _2= v_name;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_140, 0, self, _state, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  _state[0]= _1;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_141, 0, self, _state, 0);
  _2= _bind(_2, s_assert_)(_2, _3);
  _2= _state[0];
  _2= _bind(_2, s_isExported)(_2);
  if (!_2) {
 {
  _3= _state[0];
  _4= self;
  _3= _bind(_3, s_exportFrom_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
 }
  } else {
 {
  _2= ((struct t_Scope *)self)->parent;
  _3= v_name;
  _2= _bind(_2, s_lookupFree_)(_2, _3);
  _state[0]= _2;
 }
  } _1= _2;
  _1= _state[0];
  return _1;
 }
}

static oop Scope__s_innerScopeFor_(oop self, oop v_blockNode)
{
 {
  oop _1, _2, _3;
  _1= v_Scope;
  _2= self;
  _3= v_blockNode;
  _1= _bind(_1, s_withParent_block_)(_1, _2, _3);
  return _1;
 }
}

static oop Scope__s_nextExportOffset(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->exports;
  _2= l_1270;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((struct t_Scope *)self)->exports= _1;
  _2= l_1271;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  return _1;
 }
}

static oop Scope__s_noteExportOuter(oop self)
{
 {
  oop _1, _2;
  _1= v_true;
  ((struct t_Scope *)self)->exportOuter= _1;
  _1= ((struct t_Scope *)self)->block;
  _1= _bind(_1, s_isMethod)(_1);
  if (!_1) {
 {
  _2= ((struct t_Scope *)self)->parent;
  _2= _bind(_2, s_noteExportOuter)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Scope__s_noteExportSelf(oop self)
{
 {
  oop _1, _2;
  _1= v_true;
  ((struct t_Scope *)self)->exportSelf= _1;
  _1= ((struct t_Scope *)self)->block;
  _1= _bind(_1, s_isMethod)(_1);
  if (!_1) {
 {
  _2= ((struct t_Scope *)self)->parent;
  _2= _bind(_2, s_noteExportSelf)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop Scope__s_noteExportNLR(oop self)
{
 {
  oop _1, _2;
  _1= v_true;
  ((struct t_Scope *)self)->exportOuter= _1;
  _1= ((struct t_Scope *)self)->block;
  _1= _bind(_1, s_isMethod)(_1);
  if (_1) {
 {
  _2= v_true;
  ((struct t_Scope *)self)->exportNLR= _2;
 }
  } else {
 {
  _2= ((struct t_Scope *)self)->parent;
  _2= _bind(_2, s_noteExportNLR)(_2);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop b_142(oop _self, oop v_literal)
{
 {
  oop _1, _2;
  _1= v_literal;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genDefinition_)(_1, _2);
  return _1;
 }
}

static oop b_143(oop _self, oop v_block)
{
 {
  oop _1, _2;
  _1= v_block;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genDefinition_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_genDefinitions_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->literals;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_142, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_Scope *)self)->blocks;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_143, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_144(oop _self, oop v_block)
{
 {
  oop _1, _2;
  _1= v_block;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genImplementation_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_genImplementations_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->blocks;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_144, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_145(oop _self, oop v_literal)
{
 {
  oop _1, _2;
  _1= v_literal;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genInitialisation_)(_1, _2);
  return _1;
 }
}

static oop b_146(oop _self, oop v_block)
{
 {
  oop _1, _2;
  _1= v_block;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_genInitialisation_)(_1, _2);
  return _1;
 }
}

static oop Scope__s_genInitialisations_(oop self, oop v_unit)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_unit;
 {
  oop _1, _2;
  _1= ((struct t_Scope *)self)->literals;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_145, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_Scope *)self)->blocks;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_146, 1, self, _state, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop CompilerOptions__s_new(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_Object, s_new)(_1);
  self= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_CompilerOptions *)self)->searchPaths= _1;
  _1= v_false;
  ((struct t_CompilerOptions *)self)->mainFlag= _1;
  _1= self;
  return _1;
 }
}

static oop CompilerOptions__s_searchPaths(oop self)
{
 {
  oop _1;
  _1= ((struct t_CompilerOptions *)self)->searchPaths;
  return _1;
 }
}

static oop CompilerOptions__s_mainFlag(oop self)
{
 {
  oop _1;
  _1= ((struct t_CompilerOptions *)self)->mainFlag;
  return _1;
 }
}

static oop CompilerOptions__s_mainFlag_(oop self, oop v_aBoolean)
{
 {
  oop _1;
  _1= v_aBoolean;
  ((struct t_CompilerOptions *)self)->mainFlag= _1;
  _1= self;
  return _1;
 }
}

static int   ScannerContext__5fsizeof(oop self) { return sizeof(struct t_ScannerContext); }
static char *ScannerContext__5fdebugName(oop self) { return "ScannerContext"; }

static oop ScannerContext__s_withName_line_input_header_(oop self, oop v_nameString, oop v_lineNumber, oop v_inputDescriptor, oop v_headerFlag)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  self= _1;
  _1= v_nameString;
  ((struct t_ScannerContext *)self)->name= _1;
  _1= v_lineNumber;
  ((struct t_ScannerContext *)self)->line= _1;
  _1= v_inputDescriptor;
  ((struct t_ScannerContext *)self)->input= _1;
  _1= v_headerFlag;
  ((struct t_ScannerContext *)self)->header= _1;
  _1= self;
  return _1;
 }
}

static oop ScannerContext__s_name(oop self)
{
 {
  oop _1;
  _1= ((struct t_ScannerContext *)self)->name;
  return _1;
 }
}

static oop ScannerContext__s_line(oop self)
{
 {
  oop _1;
  _1= ((struct t_ScannerContext *)self)->line;
  return _1;
 }
}

static oop ScannerContext__s_input(oop self)
{
 {
  oop _1;
  _1= ((struct t_ScannerContext *)self)->input;
  return _1;
 }
}

static oop ScannerContext__s_header(oop self)
{
 {
  oop _1;
  _1= ((struct t_ScannerContext *)self)->header;
  return _1;
 }
}

static oop Scanner__s_new(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _rebind(v_Object, s_new)(_1);
  _1= _bind(_1, s_initialise)(_1);
  self= _1;
  _1= self;
  return _1;
 }
}

static oop Scanner__s_initialise(oop self)
{
 {
  oop _1, _2, _3;
  _1= v_Array;
  _2= l_1272;
  _1= _bind(_1, s_new_)(_1, _2);
  ((struct t_Scanner *)self)->charTable= _1;
  _2= l_1273;
  _bind(_1, s_atAllPut_)(_1, _2);
  _2= l_1274;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1275;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1276;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1277;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1278;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1279;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1280;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1281;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1282;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1283;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1284;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1285;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1286;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1287;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1288;
  _2= _bind(_2, s_asByteArray)(_2);
  _3= l_1289;
  _bind(_1, s_atAll_put_)(_1, _2, _3);
  _2= l_1290;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1291;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1292;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1293;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1294;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1295;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1296;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1297;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1298;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1299;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1300;
  _2= _bind(_2, s_asciiValue)(_2);
  _3= l_1301;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= v_IdentityDictionary;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scanner *)self)->charEscapes= _1;
  _2= l_1302;
  _3= l_1303;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1304;
  _3= l_1305;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1306;
  _3= l_1307;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1308;
  _3= l_1309;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1310;
  _3= l_1311;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1312;
  _3= l_1313;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1314;
  _3= l_1315;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1316;
  _3= l_1317;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Scanner *)self)->includeStack= _1;
  _1= v_false;
  ((struct t_Scanner *)self)->prevHash= _1;
  _1= l_1318;
  ((struct t_Scanner *)self)->fileName= _1;
  _1= l_1319;
  ((struct t_Scanner *)self)->lineNumber= _1;
  _1= v_false;
  ((struct t_Scanner *)self)->headerFlag= _1;
  _1= self;
  return _1;
 }
}

static oop Scanner__s_error_(oop self, oop v_message)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= ((struct t_Scanner *)self)->fileName;
  _3= l_1320;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= ((struct t_Scanner *)self)->lineNumber;
  _3= _bind(_3, s_printString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _3= l_1321;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_message;
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _rebind(v_Object, s_error_)(_1, _2);
  return _1;
 }
}

static oop Scanner__s_next(oop self)
{
 {
  oop _1, _2;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->input;
  _1= _bind(_1, s_next)(_1);
  ((struct t_Scanner *)self)->c= _1;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->includeStack;
  _2= _bind(_2, s_notEmpty)(_2);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  oop v_context;
  _1= ((struct t_Scanner *)self)->includeStack;
  _1= _bind(_1, s_removeLast)(_1);
  v_context= _1;
  _1= v_context;
  _1= _bind(_1, s_input)(_1);
  ((struct t_Scanner *)self)->input= _1;
  _1= v_context;
  _1= _bind(_1, s_line)(_1);
  ((struct t_Scanner *)self)->lineNumber= _1;
  _1= v_context;
  _1= _bind(_1, s_name)(_1);
  ((struct t_Scanner *)self)->fileName= _1;
  _1= v_context;
  _1= _bind(_1, s_header)(_1);
  ((struct t_Scanner *)self)->headerFlag= _1;
  _1= ((struct t_Scanner *)self)->options;
  _1= _bind(_1, s_searchPaths)(_1);
  _1= _bind(_1, s_removeFirst)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->c;
  return _1;
 }
}

static oop b_147(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_149(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)((struct t_BlockClosure *)_self)->outer)->_envp, _1);
 }
}

static oop b_148(oop _self, oop v_dir)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= v_dir;
  _2= l_1324;
  _1= _bind(_1, s__2c)(_1, _2);
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s__2c)(_1, _2);
  _state[0]= _1;
  _1= _state[0];
  _1= _bind(_1, s_isReadableFile)(_1);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_149, 0, ((struct t_BlockClosure *)_self)->receiver, _state, _self);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  return _1;
 }
}

static oop Scanner__s_findFile_(oop self, oop v_file)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  _state[0]= v_file;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3;
  _1= _state[0];
  _2= l_1322;
  _1= _bind(_1, s__2c)(_1, _2);
  _state[0]= _1;
  _1= _state[0];
  _1= _bind(_1, s_isReadableFile)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_147, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= _state[0];
  _1= _bind(_1, s_first)(_1);
  _2= l_1323;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= ((struct t_Scanner *)self)->options;
  _2= _bind(_2, s_searchPaths)(_2);
  _3= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_148, 1, self, _state, &_env);
  _2= _bind(_2, s_do_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= _state[0];
  _3= l_1325;
  _2= _bind(_2, s__2c)(_2, _3);
  _3= v_Smalltalk;
  _3= _bind(_3, s_osErrorString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scanner__s_include_(oop self, oop v_name)
{
 {
  oop v_pathName;
  oop v_sourceString;
  oop _1, _2, _3, _4, _5, _6;
  _1= ((struct t_Scanner *)self)->includeStack;
  _2= v_ScannerContext;
  _3= ((struct t_Scanner *)self)->fileName;
  _4= ((struct t_Scanner *)self)->lineNumber;
  _5= ((struct t_Scanner *)self)->input;
  _6= ((struct t_Scanner *)self)->headerFlag;
  _2= _bind(_2, s_withName_line_input_header_)(_2, _3, _4, _5, _6);
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  _2= v_name;
  _1= _bind(_1, s_findFile_)(_1, _2);
  v_pathName= _1;
  _1= v_String;
  _2= v_pathName;
  _1= _bind(_1, s_readFromFileNamed_)(_1, _2);
  v_sourceString= _1;
  _1= v_sourceString;
  _1= _bind(_1, s_readStream)(_1);
  ((struct t_Scanner *)self)->input= _1;
  _1= v_name;
  ((struct t_Scanner *)self)->fileName= _1;
  _1= l_1326;
  ((struct t_Scanner *)self)->lineNumber= _1;
  _1= ((struct t_Scanner *)self)->options;
  _1= _bind(_1, s_searchPaths)(_1);
  _2= v_pathName;
  _2= _bind(_2, s_directoryName)(_2);
  _2= _bind(_2, s_absolutePathName)(_2);
  _1= _bind(_1, s_addFirst_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= self;
  return _1;
 }
}

static oop Scanner__s_gobble_(oop self, oop v_pathName)
{
 {
  oop _1, _2;
  _1= l_1327;
  _2= v_pathName;
  _1= _bind(_1, s__2c)(_1, _2);
  _1= _bind(_1, s_println)(_1);
  _1= self;
  _2= v_pathName;
  _1= _bind(_1, s_include_)(_1, _2);
  _1= v_true;
  ((struct t_Scanner *)self)->headerFlag= _1;
  _1= self;
  return _1;
 }
}

static oop Scanner__s_on_(oop self, oop v_aStringOrStream)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s_new)(_1);
  _1= _bind(_1, s_initialise)(_1);
  self= _1;
  _1= v_aStringOrStream;
  _1= _bind(_1, s_readStream)(_1);
  ((struct t_Scanner *)self)->input= _1;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= v_String;
  _1= _bind(_1, s_new)(_1);
  _1= _bind(_1, s_writeStream)(_1);
  ((struct t_Scanner *)self)->token= _1;
  _1= self;
  return _1;
 }
}

static oop Scanner__s_scan(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= v_nil;
  ((struct t_Scanner *)self)->type= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _2= _bind(_2, s_isNil)(_2);
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _1= _bind(_1, s_resetToStart)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->charTable;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_value)(_3);
  _2= _bind(_2, s_at_)(_2, _3);
  _3= l_1328;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1329;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->lineNumber;
  _3= l_1330;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_Scanner *)self)->lineNumber= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= ((struct t_Scanner *)self)->charTable;
  _4= ((struct t_Scanner *)self)->c;
  _4= _bind(_4, s_value)(_4);
  _3= _bind(_3, s_at_)(_3, _4);
  _2= _bind(_2, s_perform_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
 }
  };
  _1= l_1331;
  _2= ((struct t_Scanner *)self)->type;
  _1= (_1 == _2) ? v_true : v_false;
  ((struct t_Scanner *)self)->prevHash= _1;
  _1= ((struct t_Scanner *)self)->type;
  return _1;
 }
}

static oop Scanner__s_xSign(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->input;
  _1= _bind(_1, s_peek)(_1);
  _1= _bind(_1, s_isDigit)(_1);
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_xDigit)(_2);
 }
  } else {
 {
  _2= self;
  _2= _bind(_2, s_xBinary)(_2);
 }
  } _1= _2;
  return _1;
 }
}

static oop Scanner__s_xDot(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1332;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->input;
  _2= _bind(_2, s_peek)(_2);
  _3= l_1333;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= self;
  _bind(_2, s_next)(_2);
  _2= _bind(_2, s_next)(_2);
  _2= l_1334;
  ((struct t_Scanner *)self)->type= _2;
 }
  } else {
 {
  _2= l_1335;
  ((struct t_Scanner *)self)->type= _2;
 }
  } _1= _2;
  _1= ((struct t_Scanner *)self)->type;
  return _1;
 }
}

static oop b_150(oop _self)
{
 {
  oop _1;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _1= _bind(_1, s_contents)(_1);
  _1= _bind(_1, s_asSymbol)(_1);
  ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type= _1;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Scanner__s_xColon(oop self)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1336;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_150, 0, self, 0, &_env);
  _1= _bind(_1, s_ifFalse_)(_1, _2);
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= l_1337;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop Scanner__s_xPunctuator(oop self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_asString)(_1);
  _1= _bind(_1, s_asSymbol)(_1);
  ((struct t_Scanner *)self)->type= _1;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= ((struct t_Scanner *)self)->type;
  return _1;
 }
}

static oop Scanner__s_xBinary(oop self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->charTable;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_value)(_3);
  _2= _bind(_2, s_at_)(_2, _3);
  _3= l_1338;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= l_1339;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop Scanner__s_xLetter(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= l_1340;
  ((struct t_Scanner *)self)->type= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->charTable;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_value)(_3);
  _2= _bind(_2, s_at_)(_2, _3);
  _3= l_1341;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= ((struct t_Scanner *)self)->charTable;
  _4= ((struct t_Scanner *)self)->c;
  _4= _bind(_4, s_value)(_4);
  _3= _bind(_3, s_at_)(_3, _4);
  _4= l_1342;
  _3= (_3 == _4) ? v_true : v_false;
 }
  _2= _3;
  }
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1343;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _3= ((struct t_Scanner *)self)->c;
  _2= _bind(_2, s_nextPut_)(_2, _3);
  _2= self;
  _2= _bind(_2, s_next)(_2);
  _2= l_1344;
  ((struct t_Scanner *)self)->type= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->type;
  return _1;
 }
}

static oop Scanner__s_scanKeywords(oop self)
{
 {
  oop v_keywords;
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)self)->token;
  _1= _bind(_1, s_contents)(_1);
  v_keywords= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->charTable;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_value)(_3);
  _2= _bind(_2, s_at_)(_2, _3);
  _3= l_1345;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1346;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1347;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_keywords;
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s__2c)(_1, _2);
  v_keywords= _1;
 }
  };
  _1= ((struct t_Scanner *)self)->token;
  _bind(_1, s_resetToStart)(_1);
  _2= v_keywords;
  _1= _bind(_1, s_nextPutAll_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scanner__s_xDigit(oop self)
{
 {
  oop _1, _2, _3, _4;
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->charTable;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_value)(_3);
  _2= _bind(_2, s_at_)(_2, _3);
  _3= l_1348;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= ((struct t_Scanner *)self)->charTable;
  _4= ((struct t_Scanner *)self)->c;
  _4= _bind(_4, s_value)(_4);
  _3= _bind(_3, s_at_)(_3, _4);
  _4= l_1349;
  _3= (_3 == _4) ? v_true : v_false;
 }
  _2= _3;
  }
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= l_1350;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop b_151(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_next)(_1);
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->c;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= l_1352;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->c;
  _2= l_1353;
  _3= l_1354;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (!_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= l_1355;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= l_1356;
  if (_areIntegerObjects(_1, _2))
    _1= _integerObject(_integerValue(_1) * _integerValue(_2));
  else
    _1= _bind(_1, s__2a)(_1, _2);
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->c;
  _2= _bind(_2, s_digitValue)(_2);
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 + (long)_2 - 1);
  else
    _1= _bind(_1, s__2b)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  return _1;
 }
}

static oop Scanner__s_scanOctal(oop self)
{
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_digitValue)(_1);
  _state[0]= _1;
  _1= l_1351;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_151, 0, self, _state, 0);
  _1= _bind(_1, s_timesRepeat_)(_1, _2);
  _1= v_Character;
  _2= _state[0];
  _1= _bind(_1, s_value_)(_1, _2);
  return _1;
 }
}

static oop b_152(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->c;
  _2= l_1358;
  _3= l_1359;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _2= _bind(_2, s_scanOctal)(_2);
 }
  } else {
 {
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->c;
 }
  } _1= _2;
  return _1;
 }
}

static oop Scanner__s_scanEscape(oop self)
{
 {
  oop v_char;
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= l_1357;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->charEscapes;
  _2= ((struct t_Scanner *)self)->c;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_152, 0, self, 0, 0);
  _1= _bind(_1, s_at_ifAbsent_)(_1, _2, _3);
  v_char= _1;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= v_char;
  return _1;
 }
}

static oop Scanner__s_scanCharacter(oop self)
{
 {
  oop v_d;
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->c;
  v_d= _1;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= v_d;
  _2= l_1360;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_scanEscape)(_2);
 }
  } else {
 {
  _2= v_d;
 }
  } _1= _2;
  return _1;
 }
}

static oop Scanner__s_xIllegal(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= l_1361;
  _3= ((struct t_Scanner *)self)->c;
  _3= _bind(_3, s_printString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Scanner__s_xCharacter(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= l_1362;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->token;
  _2= self;
  _2= _bind(_2, s_scanCharacter)(_2);
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= l_1363;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop Scanner__s_xString(oop self)
{
 {
  oop _1, _2, _3;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1364;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_next)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->c;
  _3= l_1365;
  _2= (_2 != _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _2= self;
  _2= _bind(_2, s_scanCharacter)(_2);
  _1= _bind(_1, s_nextPut_)(_1, _2);
 }
  };
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= l_1366;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _2= l_1367;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _3= ((struct t_Scanner *)self)->c;
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
 }
  };
  _1= l_1368;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop Scanner__s_xComment(oop self)
{
 {
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_next)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->c;
  _3= l_1369;
  _2= (_2 != _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1370;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->lineNumber;
  _3= l_1371;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_Scanner *)self)->lineNumber= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= v_nil;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop b_153(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_next)(_1);
  _1= l_1372;
  ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type= _1;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Scanner__s_xBrace(oop self)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop v_nest;
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)self)->prevHash;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_153, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= l_1373;
  v_nest= _1;
  for (;;) {
 {
  _1= v_nest;
  _2= l_1374;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_next)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->c;
  _3= l_1375;
  _2= (_2 != _3) ? v_true : v_false;
 }
  _1= _2;
  }
 }
  if (!_1) break;
 {
  _1= ((struct t_Scanner *)self)->token;
  _2= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_nextPut_)(_1, _2);
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1376;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_nest;
  _3= l_1377;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  v_nest= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->c;
  _2= l_1378;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 == (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3d)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->lineNumber;
  _3= l_1379;
  if (_areIntegerObjects(_2, _3))
    _2= (oop)((long)_2 + (long)_3 - 1);
  else
    _2= _bind(_2, s__2b)(_2, _3);
  ((struct t_Scanner *)self)->lineNumber= _2;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_next)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->c;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= l_1380;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_nest;
  _2= l_1381;
  if (_areIntegerObjects(_1, _2))
    _1= (oop)((long)_1 - (long)_2 + 1);
  else
    _1= _bind(_1, s__2d)(_1, _2);
  v_nest= _1;
  _2= l_1382;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _3= ((struct t_Scanner *)self)->c;
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
 }
  };
  _1= self;
  _1= _bind(_1, s_next)(_1);
  _1= l_1383;
  ((struct t_Scanner *)self)->type= _1;
  return _1;
 }
}

static oop Parser__s_on_(oop self, oop v_aStringOrStream)
{
 {
  oop _1, _2;
  _1= self;
  _2= v_aStringOrStream;
  _1= _rebind(v_Scanner, s_on_)(_1, _2);
  self= _1;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= self;
  return _1;
 }
}

static oop Parser__s_note_(oop self, oop v_marker)
{
 {
  oop _1;
  _1= self;
  return _1;
 }
}

static oop Parser__s_parseByteArray(oop self)
{
 {
  oop v_elements;
  oop _1, _2, _3;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_elements= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1384;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (_1) break;
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1385;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1386;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_elements;
  _2= v_IntegerNode;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _2= _bind(_2, s_fromString_)(_2, _3);
  _1= _bind(_1, s_add_)(_1, _2);
  _1= _bind(_1, s_value)(_1);
  _2= l_1387;
  _3= l_1388;
  _1= _bind(_1, s_between_and_)(_1, _2, _3);
  if (!_1) {
 {
  _2= self;
  _3= l_1389;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_ByteArrayNode;
  _2= v_elements;
  _1= _bind(_1, s_withElements_)(_1, _2);
  return _1;
 }
}

static oop Parser__s_parseWordArray(oop self)
{
 {
  oop v_elements;
  oop _1, _2, _3;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_elements= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1390;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (_1) break;
 {
  _1= self;
  _2= l_1391;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1392;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1393;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_elements;
  _2= v_IntegerNode;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _2= _bind(_2, s_fromString_)(_2, _3);
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_WordArrayNode;
  _2= v_elements;
  _1= _bind(_1, s_withElements_)(_1, _2);
  return _1;
 }
}

static oop b_154(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_155(oop _self)
{
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type;
  _2= l_1398;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _2= _bind(_2, s_scanKeywords)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= v_SymbolNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_fromString_)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_156(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_157(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseWordArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_158(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseByteArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Parser__s_parseArrayLiteral(oop self)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= self;
  _1= _bind(_1, s_parseLiteralP)(_1);
  _state[0]= _1;
  _1= _bind(_1, s_notNil)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_154, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= l_1397;
  _2= ((struct t_Scanner *)self)->type;
  _1= _bind(_1, s_includes_)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_155, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1399;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_156, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1400;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_157, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1401;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_158, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= v_nil;
  return _1;
 }
}

static oop Parser__s_parseArray(oop self)
{
 {
  oop v_elements;
  oop v_element;
  oop _1, _2, _3;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_elements= _1;
  for (;;) {
 {
  _1= self;
  _1= _bind(_1, s_parseArrayLiteral)(_1);
  v_element= _1;
  _1= _bind(_1, s_notNil)(_1);
 }
  if (!_1) break;
 {
  _1= v_elements;
  _2= v_element;
  _1= _bind(_1, s_add_)(_1, _2);
 }
  };
  _1= self;
  _2= l_1402;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1403;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1404;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_ArrayNode;
  _2= v_elements;
  _1= _bind(_1, s_withElements_)(_1, _2);
  return _1;
 }
}

static oop b_159(oop _self)
{
 {
  oop v_node;
  oop _1, _2;
  _1= v_IntegerNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_fromString_)(_1, _2);
  v_node= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= v_node;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_160(oop _self)
{
 {
  oop v_node;
  oop _1, _2;
  _1= v_CharacterNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _2= _bind(_2, s_first)(_2);
  _1= _bind(_1, s_withValue_)(_1, _2);
  v_node= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= v_node;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_161(oop _self)
{
 {
  oop v_node;
  oop _1, _2;
  _1= v_StringNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_fromString_)(_1, _2);
  v_node= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= v_node;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_162(oop _self)
{
 {
  oop _1;
  _1= v_nil;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_163(oop _self)
{
 {
  oop v_node;
  oop _1, _2;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type;
  _2= l_1417;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _2= _bind(_2, s_scanKeywords)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= v_SymbolNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_fromString_)(_1, _2);
  v_node= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= v_node;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_164(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_165(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseWordArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_166(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseByteArray)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Parser__s_parseLiteralP(oop self)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= self;
  _2= l_1405;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1406;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_159, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1407;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_160, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1408;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_161, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1409;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1410;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_162, 0, self, 0, &_env);
  _1= _bind(_1, s_ifFalse_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= self;
  _2= l_1411;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= l_1416;
  _2= ((struct t_Scanner *)self)->type;
  _1= _bind(_1, s_includes_)(_1, _2);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_163, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1418;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1419;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_164, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1420;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_165, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1421;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_166, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1422;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop b_167(oop _self)
{
 {
  oop _1, _2;
  _1= v_VariableNode;
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_withName_)(_1, _2);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_168(oop _self)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseExpression)(_1);
  ((oop *)((struct t_BlockClosure *)_self)->_state)[0]= _1;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type;
  _2= l_1426;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= l_1427;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_169(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_1, s_scan)(_1);
  _1= _bind(_1, s_parseBlock)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_170(oop _self)
{
 {
  oop _1;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Parser__s_parsePrimary(oop self)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= self;
  _2= l_1423;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1424;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_167, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1425;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_168, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1428;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_169, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1429;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_parseLiteralP)(_1);
  _state[0]= _1;
  _1= self;
  _2= l_1430;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= _state[0];
  _1= _bind(_1, s_notNil)(_1);
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_170, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1431;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= self;
  _2= l_1432;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Parser__s_parseUnary(oop self)
{
 {
  oop v_node;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_parsePrimary)(_1);
  v_node= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1433;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= v_SendNode;
  _2= v_node;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _1= _bind(_1, s_withReceiver_selector_)(_1, _2, _3);
  v_node= _1;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= v_node;
  return _1;
 }
}

static oop Parser__s_parseBinary(oop self)
{
 {
  oop v_node;
  oop _1, _2, _3;
  _1= self;
  _1= _bind(_1, s_parseUnary)(_1);
  v_node= _1;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1434;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= v_SendNode;
  _2= v_node;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _1= _bind(_1, s_withReceiver_selector_)(_1, _2, _3);
  v_node= _1;
  _1= v_node;
  _2= self;
  _bind(_2, s_scan)(_2);
  _2= _bind(_2, s_parseUnary)(_2);
  _1= _bind(_1, s_addArgument_)(_1, _2);
 }
  };
  _1= v_node;
  return _1;
 }
}

static oop b_171(oop _self)
{
 {
  oop _1, _2, _3;
  _1= v_AssignmentNode;
  _2= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _3= ((struct t_BlockClosure *)_self)->receiver;
  _bind(_3, s_scan)(_3);
  _3= _bind(_3, s_parseExpression)(_3);
  _1= _bind(_1, s_withVariable_value_)(_1, _2, _3);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Parser__s_parseExpression(oop self)
{
  jmp_buf _env;
  oop *_state= (oop *)_newPointers(sizeof(oop) * 1);
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= l_1435;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_parseBinary)(_1);
  _state[0]= _1;
  _1= self;
  _2= l_1436;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1437;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_SendNode;
  _3= _state[0];
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _2= _bind(_2, s_withReceiver_selector_)(_2, _3, _4);
  _state[0]= _2;
  _2= _state[0];
  _3= self;
  _bind(_3, s_scan)(_3);
  _3= _bind(_3, s_parseBinary)(_3);
  _2= _bind(_2, s_addArgument_)(_2, _3);
  _2= self;
  _3= l_1438;
  _2= _bind(_2, s_note_)(_2, _3);
  for (;;) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1439;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1440;
  _3= (_3 == _4) ? v_true : v_false;
 }
  _2= _3;
  }
 }
  if (!_2) break;
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1441;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= _state[0];
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _3= _bind(_3, s_addKeyword_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= _state[0];
  _3= self;
  _bind(_3, s_scan)(_3);
  _3= _bind(_3, s_parseBinary)(_3);
  _2= _bind(_2, s_addArgument_)(_2, _3);
  _2= self;
  _3= l_1442;
  _2= _bind(_2, s_note_)(_2, _3);
 }
  };
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1443;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= _state[0];
  _2= _bind(_2, s_isVariableNode)(_2);
 }
  _1= _2;
  }
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_171, 0, self, _state, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1444;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= _state[0];
  _2= _bind(_2, s_isSendNode)(_2);
  _2= _bind(_2, s_not)(_2);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= self;
  _3= l_1445;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1446;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  oop v_cascade;
  _1= v_SendNode;
  _2= v_nil;
  _3= l_1447;
  _1= _bind(_1, s_withReceiver_selector_)(_1, _2, _3);
  v_cascade= _1;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1448;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  for (;;) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1449;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1450;
  _3= (_3 == _4) ? v_true : v_false;
 }
  _2= _3;
  }
 }
  if (!_2) break;
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1451;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= v_cascade;
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _3= _bind(_3, s_addKeyword_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= v_cascade;
  _3= self;
  _bind(_3, s_scan)(_3);
  _3= _bind(_3, s_parseBinary)(_3);
  _2= _bind(_2, s_addArgument_)(_2, _3);
 }
  };
 }
  } else {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1452;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= v_cascade;
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _bind(_3, s_addKeyword_)(_3, _4);
  _4= self;
  _bind(_4, s_scan)(_4);
  _4= _bind(_4, s_parseUnary)(_4);
  _3= _bind(_3, s_addArgument_)(_3, _4);
 }
  } else {
 {
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1453;
  _3= (_3 == _4) ? v_true : v_false;
  if (_3) {
 {
  _4= v_cascade;
  _5= ((struct t_Scanner *)self)->token;
  _5= _bind(_5, s_contents)(_5);
  _4= _bind(_4, s_addKeyword_)(_4, _5);
  _4= self;
  _4= _bind(_4, s_scan)(_4);
 }
  } else {
 {
  _4= self;
  _5= l_1454;
  _4= _bind(_4, s_error_)(_4, _5);
 }
  } _3= _4;
 }
  } _2= _3;
 }
  } _1= _2;
  _1= _state[0];
  _2= v_cascade;
  _1= _bind(_1, s_addCascade_)(_1, _2);
 }
  };
  _1= _state[0];
  return _1;
 }
}

static oop Parser__s_parseTemporaries_(oop self, oop v_block)
{
 {
  oop _1, _2, _3;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1455;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= v_block;
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_addTemporary_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1456;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _3= l_1457;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  if (!_1) {
 {
  _2= self;
  _3= l_1458;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_block;
  return _1;
 }
}

static oop Parser__s_parseSequence_(oop self, oop v_block)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= l_1459;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1460;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _3= l_1461;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= self;
  _bind(_2, s_scan)(_2);
  _3= v_block;
  _2= _bind(_2, s_parseTemporaries_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= l_1462;
  _1= _bind(_1, s_note_)(_1, _2);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1463;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (_1) break;
 {
  _1= self;
  _2= l_1464;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_block;
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1465;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= self;
  _3= _bind(_3, s_parseExtern)(_3);
 }
  } else {
 {
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1466;
  _3= (_3 == _4) ? v_true : v_false;
  if (_3) {
 {
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _5= l_1467;
  if (_areIntegerObjects(_4, _5))
    _4= ((long)_4 == (long)_5) ? v_true : v_false;
  else
    _4= _bind(_4, s__3d)(_4, _5);
 }
  _3= _4;
  }
  if (_3) {
 {
  _4= v_ReturnNode;
  _5= self;
  _bind(_5, s_scan)(_5);
  _5= _bind(_5, s_parseExpression)(_5);
  _4= _bind(_4, s_withValue_)(_4, _5);
 }
  } else {
 {
  _4= self;
  _4= _bind(_4, s_parseExpression)(_4);
 }
  } _3= _4;
 }
  } _2= _3;
  _1= _bind(_1, s_addStatement_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1468;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1469;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  if (!_1) {
 {
  _2= self;
  _3= l_1470;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1471;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= v_block;
  _1= _bind(_1, s_lastStatement)(_1);
  _1= _bind(_1, s_isReturnNode)(_1);
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1472;
  _2= (_2 != _3) ? v_true : v_false;
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= self;
  _3= l_1473;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
 }
  };
  _1= self;
  _2= l_1474;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= self;
  _2= l_1475;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_block;
  return _1;
 }
}

static oop Parser__s_parseBlockParameters_(oop self, oop v_block)
{
 {
  oop _1, _2, _3, _4;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1476;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1477;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1478;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_block;
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_addArgument_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1479;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _3= l_1480;
  if (_areIntegerObjects(_2, _3))
    _2= ((long)_2 == (long)_3) ? v_true : v_false;
  else
    _2= _bind(_2, s__3d)(_2, _3);
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= ((struct t_Scanner *)self)->token;
  _bind(_2, s_resetToStart)(_2);
  _3= l_1481;
  _2= _bind(_2, s_nextPut_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1482;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _4= l_1483;
  if (_areIntegerObjects(_3, _4))
    _3= ((long)_3 == (long)_4) ? v_true : v_false;
  else
    _3= _bind(_3, s__3d)(_3, _4);
 }
  _2= _3;
  }
  if (!_2) {
 {
  _3= self;
  _4= l_1484;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= self;
  _2= _bind(_2, s_scan)(_2);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop Parser__s_parseBlock(oop self)
{
 {
  oop v_block;
  oop _1, _2, _3;
  _1= v_BlockNode;
  _1= _bind(_1, s_new)(_1);
  v_block= _1;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1485;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= self;
  _3= v_block;
  _2= _bind(_2, s_parseBlockParameters_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _2= v_block;
  _1= _bind(_1, s_parseSequence_)(_1, _2);
  return _1;
 }
}

static oop Parser__s_parseExec(oop self)
{
 {
  oop _1, _2;
  _1= self;
  _bind(_1, s_scan)(_1);
  _2= v_ExecNode;
  _2= _bind(_2, s_new)(_2);
  _1= _bind(_1, s_parseSequence_)(_1, _2);
  return _1;
 }
}

static oop Parser__s_parseExtern(oop self)
{
 {
  oop v_text;
  oop v_node;
  oop _1, _2, _3, _4, _5, _6;
  _1= ((struct t_Scanner *)self)->token;
  _1= _bind(_1, s_contents)(_1);
  v_text= _1;
  _1= v_nil;
  v_node= _1;
  _1= v_text;
  _2= l_1486;
  _1= _bind(_1, s_beginsWith_)(_1, _2);
  if (_1) {
 {
  _2= v_IncludeNode;
  _3= v_text;
  _4= l_1487;
  _3= _bind(_3, s_tokenised_)(_3, _4);
  _3= _bind(_3, s_second)(_3);
  _2= _bind(_2, s_withName_)(_2, _3);
  v_node= _2;
 }
  } else {
 {
  _2= v_text;
  _3= l_1488;
  _2= _bind(_2, s_beginsWith_)(_2, _3);
  if (_2) {
 {
  _3= self;
  _4= v_text;
  _5= l_1489;
  _4= _bind(_4, s_tokenised_)(_4, _5);
  _4= _bind(_4, s_second)(_4);
  _3= _bind(_3, s_include_)(_3, _4);
 }
  } else {
 {
  _3= v_text;
  _4= l_1490;
  _3= _bind(_3, s_beginsWith_)(_3, _4);
  if (_3) {
 {
  _4= self;
  _5= v_text;
  _6= l_1491;
  _5= _bind(_5, s_tokenised_)(_5, _6);
  _5= _bind(_5, s_second)(_5);
  _4= _bind(_4, s_gobble_)(_4, _5);
 }
  } else {
 {
  _4= v_text;
  _5= l_1492;
  _4= _bind(_4, s_beginsWith_)(_4, _5);
  if (_4) {
 {
  _5= v_TemplateNode;
  _6= v_text;
  _5= _bind(_5, s_withText_)(_5, _6);
  v_node= _5;
 }
  } else {
 {
  _5= v_PrimitiveNode;
  _6= v_text;
  _5= _bind(_5, s_withCode_)(_5, _6);
  v_node= _5;
 }
  } _4= _5;
 }
  } _3= _4;
 }
  } _2= _3;
 }
  } _1= _2;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_node;
  return _1;
 }
}

static oop Parser__s_parseClass_(oop self, oop v_name)
{
 {
  oop v_base;
  oop v_slots;
  oop _1, _2, _3, _4;
  _1= v_nil;
  v_base= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_slots= _1;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1493;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= self;
  _2= _bind(_2, s_scan)(_2);
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1494;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= self;
  _4= l_1495;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  v_base= _2;
  _2= self;
  _2= _bind(_2, s_scan)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1496;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1497;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1498;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) break;
 {
  _1= v_slots;
  _2= ((struct t_Scanner *)self)->token;
  _2= _bind(_2, s_contents)(_2);
  _1= _bind(_1, s_add_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_scan)(_1);
 }
  };
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1499;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= self;
  _3= l_1500;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  _1= _bind(_1, s_scan)(_1);
  _1= v_ClassNode;
  _2= v_name;
  _3= v_base;
  _4= v_slots;
  _1= _bind(_1, s_withName_base_slots_)(_1, _2, _3, _4);
  return _1;
 }
}

static oop Parser__s_parseMethod_(oop self, oop v_className)
{
 {
  oop v_selector;
  oop v_arguments;
  oop v_node;
  oop _1, _2, _3, _4, _5;
  _1= self;
  _2= l_1501;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= l_1502;
  v_selector= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  v_arguments= _1;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1503;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  for (;;) {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1504;
  _2= (_2 == _3) ? v_true : v_false;
 }
  if (!_2) break;
 {
  _2= v_selector;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  v_selector= _2;
  _2= self;
  _2= _bind(_2, s_scan)(_2);
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1505;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) {
 {
  _3= self;
  _4= l_1506;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
  _2= v_arguments;
  _3= ((struct t_Scanner *)self)->token;
  _3= _bind(_3, s_contents)(_3);
  _2= _bind(_2, s_add_)(_2, _3);
  _2= self;
  _2= _bind(_2, s_scan)(_2);
 }
  };
 }
  } else {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1507;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= v_selector;
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _3= _bind(_3, s__2c)(_3, _4);
  v_selector= _3;
  _3= self;
  _3= _bind(_3, s_scan)(_3);
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1508;
  _3= (_3 == _4) ? v_true : v_false;
  if (!_3) {
 {
  _4= self;
  _5= l_1509;
  _4= _bind(_4, s_error_)(_4, _5);
 }
  _3= _4;
  } else _3= 0;
  _3= v_arguments;
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  _3= _bind(_3, s_add_)(_3, _4);
  _3= self;
  _3= _bind(_3, s_scan)(_3);
 }
  } else {
 {
  _3= ((struct t_Scanner *)self)->type;
  _4= l_1510;
  _3= (_3 == _4) ? v_true : v_false;
  if (_3) {
 {
  _4= ((struct t_Scanner *)self)->token;
  _4= _bind(_4, s_contents)(_4);
  v_selector= _4;
  _4= self;
  _4= _bind(_4, s_scan)(_4);
 }
  } else {
 {
  _4= self;
  _5= l_1511;
  _4= _bind(_4, s_error_)(_4, _5);
 }
  } _3= _4;
 }
  } _2= _3;
 }
  } _1= _2;
  _1= v_MethodNode;
  _2= v_className;
  _3= v_selector;
  _4= v_arguments;
  _1= _bind(_1, s_withClass_selector_arguments_)(_1, _2, _3, _4);
  v_node= _1;
  _1= self;
  _2= l_1512;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1513;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= v_node;
  _2= _bind(_2, s_beVariadic)(_2);
  _2= self;
  _2= _bind(_2, s_scan)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1514;
  _1= (_1 == _2) ? v_true : v_false;
  if (_1) {
 {
  _2= self;
  _bind(_2, s_scan)(_2);
  _3= v_node;
  _2= _bind(_2, s_parseSequence_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_Scanner *)self)->type;
  _3= l_1515;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) {
 {
  _3= v_node;
  _4= self;
  _4= _bind(_4, s_parseExtern)(_4);
  _3= _bind(_3, s_external_)(_3, _4);
 }
  } else {
 {
  _3= self;
  _4= l_1516;
  _3= _bind(_3, s_error_)(_3, _4);
 }
  } _2= _3;
 }
  } _1= _2;
  _1= self;
  _2= l_1517;
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_node;
  return _1;
 }
}

static oop b_172(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_parseExtern)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_173(oop _self)
{
 {
  oop _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_parseExec)(_1);
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop b_174(oop _self)
{
 {
  oop v_name;
  oop _1, _2, _3;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->token;
  _1= _bind(_1, s_contents)(_1);
  v_name= _1;
  _1= ((struct t_BlockClosure *)_self)->receiver;
  _1= _bind(_1, s_scan)(_1);
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type;
  _2= l_1521;
  _1= (_1 == _2) ? v_true : v_false;
  if (!_1) {
 {
  _2= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->type;
  _3= l_1522;
  _2= (_2 == _3) ? v_true : v_false;
 }
  _1= _2;
  }
  if (_1) {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_name;
  _2= _bind(_2, s_parseClass_)(_2, _3);
 }
  } else {
 {
  _2= ((struct t_BlockClosure *)_self)->receiver;
  _3= v_name;
  _2= _bind(_2, s_parseMethod_)(_2, _3);
 }
  } _1= _2;
  return _nlReturn(_self, ((struct t_BlockClosureNLR *)_self)->_envp, _1);
 }
}

static oop Parser__s_parseDeclaration(oop self)
{
  jmp_buf _env;
  if (setjmp(_env)) { return _nlAnswer; };
 {
  oop _1, _2;
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1518;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_172, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1519;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_173, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= ((struct t_Scanner *)self)->type;
  _2= l_1520;
  _1= (_1 == _2) ? v_true : v_false;
  _2= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(v_BlockClosureNLR, b_174, 0, self, 0, &_env);
  _1= _bind(_1, s_ifTrue_)(_1, _2);
  _1= self;
  _2= l_1523;
  _1= _bind(_1, s_error_)(_1, _2);
  _1= self;
  return _1;
 }
}

static oop Parser__s_parse(oop self)
{
 {
  oop _1, _2, _3, _4;
  for (;;) {
 {
  _1= ((struct t_Scanner *)self)->type;
  _1= _bind(_1, s_notNil)(_1);
 }
  if (!_1) break;
 {
  oop v_node;
  oop v_isExtern;
  _1= ((struct t_Scanner *)self)->headerFlag;
  v_isExtern= _1;
  _1= self;
  _1= _bind(_1, s_parseDeclaration)(_1);
  v_node= _1;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= self;
  _3= v_node;
  _4= v_isExtern;
  _2= _bind(_2, s_addNode_extern_)(_2, _3, _4);
 }
  _1= _2;
  } else _1= 0;
 }
  };
  _1= self;
  return _1;
 }
}

static oop Compiler__s_new(oop self)
{
 {
  oop _1;
  _1= self;
  _1= _bind(_1, s__5fclone)(_1);
  self= _1;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Compiler *)self)->program= _1;
  _1= v_TranslationUnit;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Compiler *)self)->translationUnit= _1;
  _1= self;
  return _1;
 }
}

static oop b_175(oop _self)
{
 {
  oop _1;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->input;
  _1= _bind(_1, s_atEnd)(_1);
  return _1;
 }
}

static oop b_176(oop _self)
{
 {
  oop _1;
  _1= ((struct t_Scanner *)((struct t_BlockClosure *)_self)->receiver)->includeStack;
  _1= _bind(_1, s_isEmpty)(_1);
  return _1;
 }
}

static oop b_177(oop _self, oop v_stmt)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _2= l_1528;
  _3= v_stmt;
  _3= _bind(_3, s_printString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_stmt;
  _2= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _1= _bind(_1, s_genDeclarationIn_)(_1, _2);
  return _1;
 }
}

static oop b_178(oop _self, oop v_stmt)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _2= l_1529;
  _3= v_stmt;
  _3= _bind(_3, s_printString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_stmt;
  _2= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _1= _bind(_1, s_genImplementationIn_)(_1, _2);
  return _1;
 }
}

static oop b_179(oop _self, oop v_stmt)
{
 {
  oop _1, _2, _3;
  _1= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _2= l_1534;
  _3= v_stmt;
  _3= _bind(_3, s_printString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_note_)(_1, _2);
  _1= v_stmt;
  _2= ((struct t_Compiler *)((struct t_BlockClosure *)_self)->receiver)->translationUnit;
  _1= _bind(_1, s_genInitialisationIn_)(_1, _2);
  return _1;
 }
}

static oop Compiler__s_compile_from_to_withOptions_(oop self, oop v_aStringOrStream, oop v_inputPath, oop v_outputPath, oop v_compilerOptions)
{
 {
  oop _1, _2, _3;
  _1= self;
  _2= v_aStringOrStream;
  _1= _bind(_1, s_on_)(_1, _2);
  self= _1;
  _1= v_inputPath;
  ((struct t_Scanner *)self)->fileName= _1;
  _1= v_compilerOptions;
  ((struct t_Scanner *)self)->options= _1;
  _1= v_TranslationUnit;
  _1= _bind(_1, s_new)(_1);
  ((struct t_Compiler *)self)->translationUnit= _1;
  _1= ((struct t_Compiler *)self)->translationUnit;
  _2= l_1524;
  _bind(_1, s_declareGlobal_)(_1, _2);
  _2= l_1525;
  _bind(_1, s_declareGlobal_)(_1, _2);
  _2= l_1526;
  _1= _bind(_1, s_declareGlobal_)(_1, _2);
  _1= self;
  _1= _bind(_1, s_parse)(_1);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_175, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= self;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_176, 0, self, 0, 0);
  _1= _bind(_1, s_assert_)(_1, _2);
  _1= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1527;
  _bind(_1, s_gen_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_Compiler *)self)->program;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_177, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_genDefinitions)(_1);
  _1= ((struct t_Compiler *)self)->program;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_178, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1530;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_1531;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_1532;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _bind(_1, s_nl)(_1);
  _2= l_1533;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_genInitialisations)(_1);
  _1= ((struct t_Compiler *)self)->program;
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_179, 1, self, 0, 0);
  _1= _bind(_1, s_do_)(_1, _2);
  _1= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_outputStream)(_1);
  _2= l_1535;
  _bind(_1, s_nextPutAll_)(_1, _2);
  _1= _bind(_1, s_nl)(_1);
  _1= ((struct t_Scanner *)self)->options;
  _1= _bind(_1, s_mainFlag)(_1);
  if (_1) {
 {
  _2= ((struct t_Compiler *)self)->translationUnit;
  _2= _bind(_2, s_outputStream)(_2);
  _bind(_2, s_nl)(_2);
  _3= l_1536;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1537;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1538;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1539;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1540;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _bind(_2, s_nl)(_2);
  _3= l_1541;
  _bind(_2, s_nextPutAll_)(_2, _3);
  _2= _bind(_2, s_nl)(_2);
 }
  _1= _2;
  } else _1= 0;
  _1= v_outputPath;
  _1= _bind(_1, s_isNil)(_1);
  if (_1) {
 {
  _2= ((struct t_Compiler *)self)->translationUnit;
  _2= _bind(_2, s_outputStream)(_2);
  _2= _bind(_2, s_contents)(_2);
  _2= _bind(_2, s_print)(_2);
 }
  } else {
 {
  _2= ((struct t_Compiler *)self)->translationUnit;
  _2= _bind(_2, s_outputStream)(_2);
  _2= _bind(_2, s_contents)(_2);
  _3= v_outputPath;
  _2= _bind(_2, s_writeToFileNamed_)(_2, _3);
 }
  } _1= _2;
  _1= self;
  return _1;
 }
}

static oop Compiler__s_addNode_extern_(oop self, oop v_aNode, oop v_externFlag)
{
 {
  oop _1, _2, _3, _4, _5;
  _1= v_aNode;
  _2= ((struct t_Compiler *)self)->translationUnit;
  _1= _bind(_1, s_forTopLevel_)(_1, _2);
  v_aNode= _1;
  _1= _bind(_1, s_notNil)(_1);
  if (_1) {
 {
  _2= v_externFlag;
  if (_2) {
 {
  _3= v_aNode;
  _4= ((struct t_Compiler *)self)->translationUnit;
  _3= _bind(_3, s_forGobble_)(_3, _4);
  v_aNode= _3;
 }
  _2= _3;
  } else _2= 0;
  _2= v_aNode;
  _2= _bind(_2, s_notNil)(_2);
  if (_2) {
 {
  _3= ((struct t_Compiler *)self)->translationUnit;
  _4= l_1542;
  _5= v_aNode;
  _5= _bind(_5, s_debugName)(_5);
  _4= _bind(_4, s__2c)(_4, _5);
  _3= _bind(_3, s_note_)(_3, _4);
  _3= ((struct t_Compiler *)self)->program;
  _4= v_aNode;
  _3= _bind(_3, s_add_)(_3, _4);
  _3= v_aNode;
  _4= ((struct t_Compiler *)self)->translationUnit;
  _3= _bind(_3, s_encodeIn_)(_3, _4);
 }
  _2= _3;
  } else _2= 0;
 }
  _1= _2;
  } else _1= 0;
  _1= self;
  return _1;
 }
}

static oop b_180(oop _self, oop v_opt, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _1= _bind(_1, s_searchPaths)(_1);
  _2= v_arg;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

static oop b_181(oop _self, oop v_opt)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[0];
  _2= v_true;
  _1= _bind(_1, s_mainFlag_)(_1, _2);
  return _1;
 }
}

static oop b_182(oop _self, oop v_opt, oop v_arg)
{
 {
  oop _1;
  _1= v_arg;
  ((oop *)((struct t_BlockClosure *)_self)->_state)[1]= _1;
  return _1;
 }
}

static oop b_183(oop _self, oop v_opt)
{
 {
  oop _1, _2, _3;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[2];
  _2= l_1547;
  _3= v_opt;
  _3= _bind(_3, s_asString)(_3);
  _2= _bind(_2, s__2c)(_2, _3);
  _1= _bind(_1, s_error_)(_1, _2);
  return _1;
 }
}

static oop b_184(oop _self, oop v_arg)
{
 {
  oop _1, _2;
  _1= ((oop *)((struct t_BlockClosure *)_self)->_state)[3];
  _2= v_arg;
  _1= _bind(_1, s_add_)(_1, _2);
  return _1;
 }
}

void __init__(void)
{
  oop self= 0;
  (void)self;
  s__2a= _selector("*");
  s__2b= _selector("+");
  s__2c= _selector(",");
  s__2d= _selector("-");
  s__2f_2f= _selector("//");
  s__3c= _selector("<");
  s__3c_3d= _selector("<=");
  s__3d= _selector("=");
  s__3d_3d= _selector("==");
  s__3e= _selector(">");
  s__3e_3d= _selector(">=");
  s__5c_5c= _selector("\\");
  s__5fbeNilType= _selector("_beNilType");
  s__5fbeTaggedType= _selector("_beTaggedType");
  s__5fcString= _selector("_cString");
  s__5fclone= _selector("_clone");
  s__5fclone_= _selector("_clone:");
  s__5fdebugName= _selector("_debugName");
  s__5fdelegated= _selector("_delegated");
  s__5felements= _selector("_elements");
  s__5fentry__5farity_= _selector("_entry:_arity:");
  s__5fentry__5farity_receiver_state_envp_= _selector("_entry:_arity:receiver:state:envp:");
  s__5fentry__5farity_receiver_state_outer_= _selector("_entry:_arity:receiver:state:outer:");
  s__5ferror_= _selector("_error:");
  s__5fidentityHash= _selector("_identityHash");
  s__5fintegerValue= _selector("_integerValue");
  s__5fintern_= _selector("_intern:");
  s__5fmemcmp_with_length_= _selector("_memcmp:with:length:");
  s__5fmethod= _selector("_method");
  s__5fmethodAt_put_= _selector("_methodAt:put:");
  s__5fmethod_= _selector("_method:");
  s__5fnewPointers_= _selector("_newPointers:");
  s__5fosErrorString_= _selector("_osErrorString:");
  s__5fperform_= _selector("_perform:");
  s__5fperform_with_= _selector("_perform:with:");
  s__5frealloc_size_= _selector("_realloc:size:");
  s__5fsize_value_= _selector("_size:value:");
  s__5fsizeof= _selector("_sizeof");
  s__5fstringValue= _selector("_stringValue");
  s__5fvalue_= _selector("_value:");
  s__5fvtbl= _selector("_vtbl");
  s__5fvtbl_= _selector("_vtbl:");
  s__7e_3d= _selector("~=");
  s__7e_7e= _selector("~~");
  s_abort= _selector("abort");
  s_absolutePathName= _selector("absolutePathName");
  s_addAll_= _selector("addAll:");
  s_addArgument_= _selector("addArgument:");
  s_addBlock_= _selector("addBlock:");
  s_addCascade_= _selector("addCascade:");
  s_addFirst_= _selector("addFirst:");
  s_addKeyword_= _selector("addKeyword:");
  s_addLast_= _selector("addLast:");
  s_addNode_extern_= _selector("addNode:extern:");
  s_addStatement_= _selector("addStatement:");
  s_addTemporary_= _selector("addTemporary:");
  s_add_= _selector("add:");
  s_allocate_= _selector("allocate:");
  s_and_= _selector("and:");
  s_applyOption_to_= _selector("applyOption:to:");
  s_applyOption_to_with_= _selector("applyOption:to:with:");
  s_argumentAt_= _selector("argumentAt:");
  s_argumentCount= _selector("argumentCount");
  s_arguments= _selector("arguments");
  s_arity= _selector("arity");
  s_asArray= _selector("asArray");
  s_asByteArray= _selector("asByteArray");
  s_asInteger= _selector("asInteger");
  s_asSortedCollection= _selector("asSortedCollection");
  s_asSortedCollection_= _selector("asSortedCollection:");
  s_asString= _selector("asString");
  s_asSymbol= _selector("asSymbol");
  s_asciiValue= _selector("asciiValue");
  s_asciiValue_= _selector("asciiValue:");
  s_assert= _selector("assert");
  s_assert_= _selector("assert:");
  s_associationsDo_= _selector("associationsDo:");
  s_atAllPut_= _selector("atAllPut:");
  s_atAll_put_= _selector("atAll:put:");
  s_atEnd= _selector("atEnd");
  s_atNewIndex_put_= _selector("atNewIndex:put:");
  s_at_= _selector("at:");
  s_at_ifAbsent_= _selector("at:ifAbsent:");
  s_at_put_= _selector("at:put:");
  s_base= _selector("base");
  s_baseName= _selector("baseName");
  s_basicValue_= _selector("basicValue:");
  s_beNilType= _selector("beNilType");
  s_beSelf= _selector("beSelf");
  s_beTaggedType= _selector("beTaggedType");
  s_beVariadic= _selector("beVariadic");
  s_beginsWith_= _selector("beginsWith:");
  s_between_and_= _selector("between:and:");
  s_bindingAt_= _selector("bindingAt:");
  s_bindingAt_put_= _selector("bindingAt:put:");
  s_bitAnd_= _selector("bitAnd:");
  s_bitOr_= _selector("bitOr:");
  s_bitXor_= _selector("bitXor:");
  s_byteAt_= _selector("byteAt:");
  s_byteAt_put_= _selector("byteAt:put:");
  s_bytesFree= _selector("bytesFree");
  s_cannotReturn_= _selector("cannotReturn:");
  s_cascade= _selector("cascade");
  s_class= _selector("class");
  s_collect_= _selector("collect:");
  s_collection= _selector("collection");
  s_compare_= _selector("compare:");
  s_compile_from_to_withOptions_= _selector("compile:from:to:withOptions:");
  s_contents= _selector("contents");
  s_copyFrom_= _selector("copyFrom:");
  s_copyFrom_to_= _selector("copyFrom:to:");
  s_cr= _selector("cr");
  s_cr_= _selector("cr:");
  s_debugName= _selector("debugName");
  s_declareClass_= _selector("declareClass:");
  s_declareGlobal_= _selector("declareGlobal:");
  s_declareIn_= _selector("declareIn:");
  s_declareLiteral_= _selector("declareLiteral:");
  s_declareLocal_= _selector("declareLocal:");
  s_declareSelector_= _selector("declareSelector:");
  s_declareState_= _selector("declareState:");
  s_declare_as_= _selector("declare:as:");
  s_default_= _selector("default:");
  s_delegate= _selector("delegate");
  s_delegate_= _selector("delegate:");
  s_delegated= _selector("delegated");
  s_delimited_= _selector("delimited:");
  s_digitValue= _selector("digitValue");
  s_digitValue_= _selector("digitValue:");
  s_directoryName= _selector("directoryName");
  s_doWithIndex_= _selector("doWithIndex:");
  s_do_= _selector("do:");
  s_emptyCheck= _selector("emptyCheck");
  s_encodeAdd_= _selector("encodeAdd:");
  s_encodeAnd_= _selector("encodeAnd:");
  s_encodeBinary_= _selector("encodeBinary:");
  s_encodeBitAnd_= _selector("encodeBitAnd:");
  s_encodeBitOr_= _selector("encodeBitOr:");
  s_encodeBitXor_= _selector("encodeBitXor:");
  s_encodeBlock_= _selector("encodeBlock:");
  s_encodeCascade_location_= _selector("encodeCascade:location:");
  s_encodeDiv_= _selector("encodeDiv:");
  s_encodeEQ_= _selector("encodeEQ:");
  s_encodeGE_= _selector("encodeGE:");
  s_encodeGT_= _selector("encodeGT:");
  s_encodeID_= _selector("encodeID:");
  s_encodeIfFalseIfTrue_= _selector("encodeIfFalseIfTrue:");
  s_encodeIfFalse_= _selector("encodeIfFalse:");
  s_encodeIfTrueIfFalse_= _selector("encodeIfTrueIfFalse:");
  s_encodeIfTrue_= _selector("encodeIfTrue:");
  s_encodeIn_= _selector("encodeIn:");
  s_encodeLE_= _selector("encodeLE:");
  s_encodeLT_= _selector("encodeLT:");
  s_encodeLvalue_= _selector("encodeLvalue:");
  s_encodeMacro_= _selector("encodeMacro:");
  s_encodeMod_= _selector("encodeMod:");
  s_encodeMul_= _selector("encodeMul:");
  s_encodeNE_= _selector("encodeNE:");
  s_encodeNI_= _selector("encodeNI:");
  s_encodeOpen_= _selector("encodeOpen:");
  s_encodeOr_= _selector("encodeOr:");
  s_encodeSequence_= _selector("encodeSequence:");
  s_encodeSub_= _selector("encodeSub:");
  s_encodeValue_= _selector("encodeValue:");
  s_encodeWhileFalseArg_= _selector("encodeWhileFalseArg:");
  s_encodeWhileFalse_= _selector("encodeWhileFalse:");
  s_encodeWhileTrueArg_= _selector("encodeWhileTrueArg:");
  s_encodeWhileTrue_= _selector("encodeWhileTrue:");
  s_encode_= _selector("encode:");
  s_ensureReturn= _selector("ensureReturn");
  s_errorCannotModify= _selector("errorCannotModify");
  s_errorEmptyCollection= _selector("errorEmptyCollection");
  s_errorImproperStore_= _selector("errorImproperStore:");
  s_errorKeyNotFound= _selector("errorKeyNotFound");
  s_errorNonIntegerIndex_= _selector("errorNonIntegerIndex:");
  s_errorSubscriptBounds_= _selector("errorSubscriptBounds:");
  s_error_= _selector("error:");
  s_exportFrom_= _selector("exportFrom:");
  s_exportNLR= _selector("exportNLR");
  s_exportOuter= _selector("exportOuter");
  s_exportSelf= _selector("exportSelf");
  s_exportedTo_= _selector("exportedTo:");
  s_exports= _selector("exports");
  s_external_= _selector("external:");
  s_ff= _selector("ff");
  s_findElementOrNil_= _selector("findElementOrNil:");
  s_findFile_= _selector("findFile:");
  s_first= _selector("first");
  s_firstToken_= _selector("firstToken:");
  s_flattened= _selector("flattened");
  s_flushCache= _selector("flushCache");
  s_forGobble_= _selector("forGobble:");
  s_forTopLevel_= _selector("forTopLevel:");
  s_freeTemp= _selector("freeTemp");
  s_freeTemps_= _selector("freeTemps:");
  s_fromString_= _selector("fromString:");
  s_fullCheck= _selector("fullCheck");
  s_garbageCollect= _selector("garbageCollect");
  s_genAdd_= _selector("genAdd:");
  s_genAnd_= _selector("genAnd:");
  s_genBitAnd_= _selector("genBitAnd:");
  s_genBitOr_= _selector("genBitOr:");
  s_genBitXor_= _selector("genBitXor:");
  s_genByte_= _selector("genByte:");
  s_genCascade_= _selector("genCascade:");
  s_genDeclarationIn_= _selector("genDeclarationIn:");
  s_genDefinition_= _selector("genDefinition:");
  s_genDefinitions= _selector("genDefinitions");
  s_genDefinitions_= _selector("genDefinitions:");
  s_genDiv_= _selector("genDiv:");
  s_genEQ_= _selector("genEQ:");
  s_genFull_= _selector("genFull:");
  s_genGE_= _selector("genGE:");
  s_genGT_= _selector("genGT:");
  s_genID_= _selector("genID:");
  s_genIfFalse_= _selector("genIfFalse:");
  s_genIfTrueIfFalse_= _selector("genIfTrueIfFalse:");
  s_genIfTrue_= _selector("genIfTrue:");
  s_genImplementationIn_= _selector("genImplementationIn:");
  s_genImplementation_= _selector("genImplementation:");
  s_genImplementations_= _selector("genImplementations:");
  s_genInitialisationIn_= _selector("genInitialisationIn:");
  s_genInitialisation_= _selector("genInitialisation:");
  s_genInitialisations= _selector("genInitialisations");
  s_genInitialisations_= _selector("genInitialisations:");
  s_genLE_= _selector("genLE:");
  s_genLT_= _selector("genLT:");
  s_genLvalue_= _selector("genLvalue:");
  s_genMod_= _selector("genMod:");
  s_genMul_= _selector("genMul:");
  s_genNE_= _selector("genNE:");
  s_genNI_= _selector("genNI:");
  s_genNLR_= _selector("genNLR:");
  s_genOr_= _selector("genOr:");
  s_genSequence_= _selector("genSequence:");
  s_genStatic_= _selector("genStatic:");
  s_genSub_= _selector("genSub:");
  s_genWhileFalseArg_= _selector("genWhileFalseArg:");
  s_genWhileFalse_= _selector("genWhileFalse:");
  s_genWhileTrueArg_= _selector("genWhileTrueArg:");
  s_genWhileTrue_= _selector("genWhileTrue:");
  s_genWord_= _selector("genWord:");
  s_gen_= _selector("gen:");
  s_gobble_= _selector("gobble:");
  s_grow= _selector("grow");
  s_growSize= _selector("growSize");
  s_hash= _selector("hash");
  s_header= _selector("header");
  s_hex2= _selector("hex2");
  s_hex8= _selector("hex8");
  s_identityHash= _selector("identityHash");
  s_ifFalse_= _selector("ifFalse:");
  s_ifTrue_= _selector("ifTrue:");
  s_ifTrue_ifFalse_= _selector("ifTrue:ifFalse:");
  s_include_= _selector("include:");
  s_includesKey_= _selector("includesKey:");
  s_includes_= _selector("includes:");
  s_indexForInserting_= _selector("indexForInserting:");
  s_initialise= _selector("initialise");
  s_inject_into_= _selector("inject:into:");
  s_innerScopeFor_= _selector("innerScopeFor:");
  s_input= _selector("input");
  s_insert_before_= _selector("insert:before:");
  s_intern_= _selector("intern:");
  s_isBlockNode= _selector("isBlockNode");
  s_isByteArray= _selector("isByteArray");
  s_isClassNode= _selector("isClassNode");
  s_isDigit= _selector("isDigit");
  s_isEmpty= _selector("isEmpty");
  s_isExported= _selector("isExported");
  s_isExternDeclarationNode= _selector("isExternDeclarationNode");
  s_isExternDeclatationNode= _selector("isExternDeclatationNode");
  s_isInteger= _selector("isInteger");
  s_isKindOf_= _selector("isKindOf:");
  s_isLetter= _selector("isLetter");
  s_isMemberOf_= _selector("isMemberOf:");
  s_isMethod= _selector("isMethod");
  s_isNamedVariable= _selector("isNamedVariable");
  s_isNil= _selector("isNil");
  s_isOpenBlock= _selector("isOpenBlock");
  s_isPrimitiveNode= _selector("isPrimitiveNode");
  s_isReadableFile= _selector("isReadableFile");
  s_isRemoteVariable= _selector("isRemoteVariable");
  s_isReturnNode= _selector("isReturnNode");
  s_isSendNode= _selector("isSendNode");
  s_isSmallInteger= _selector("isSmallInteger");
  s_isStatic= _selector("isStatic");
  s_isString= _selector("isString");
  s_isVariableNode= _selector("isVariableNode");
  s_is_5fselector= _selector("is_selector");
  s_key= _selector("key");
  s_key_= _selector("key:");
  s_key_value_= _selector("key:value:");
  s_keys= _selector("keys");
  s_keysAndSortedValuesDo_= _selector("keysAndSortedValuesDo:");
  s_keysAndValuesDo_= _selector("keysAndValuesDo:");
  s_keysDo_= _selector("keysDo:");
  s_last= _selector("last");
  s_lastStatement= _selector("lastStatement");
  s_level= _selector("level");
  s_level_offset_= _selector("level:offset:");
  s_like_= _selector("like:");
  s_line= _selector("line");
  s_list= _selector("list");
  s_list_= _selector("list:");
  s_literalClass= _selector("literalClass");
  s_literalSelector= _selector("literalSelector");
  s_location= _selector("location");
  s_lookupClass_= _selector("lookupClass:");
  s_lookupClass_ifAbsent_= _selector("lookupClass:ifAbsent:");
  s_lookupFree_= _selector("lookupFree:");
  s_lookupSelector_= _selector("lookupSelector:");
  s_lookup_= _selector("lookup:");
  s_lookup_ifAbsent_= _selector("lookup:ifAbsent:");
  s_mainFlag= _selector("mainFlag");
  s_mainFlag_= _selector("mainFlag:");
  s_makeRoomAtFirst= _selector("makeRoomAtFirst");
  s_makeRoomAtLast= _selector("makeRoomAtLast");
  s_mangleSelector_= _selector("mangleSelector:");
  s_mangleSlot_= _selector("mangleSlot:");
  s_mangleVariable_= _selector("mangleVariable:");
  s_mangledName= _selector("mangledName");
  s_max_= _selector("max:");
  s_min_= _selector("min:");
  s_min_max_= _selector("min:max:");
  s_name= _selector("name");
  s_negated= _selector("negated");
  s_new= _selector("new");
  s_newSelector_method_= _selector("newSelector:method:");
  s_newTemp= _selector("newTemp");
  s_new_= _selector("new:");
  s_newln= _selector("newln");
  s_next= _selector("next");
  s_nextExportOffset= _selector("nextExportOffset");
  s_nextPutAll_= _selector("nextPutAll:");
  s_nextPut_= _selector("nextPut:");
  s_next_= _selector("next:");
  s_nl= _selector("nl");
  s_nl_= _selector("nl:");
  s_noCheckAdd_= _selector("noCheckAdd:");
  s_not= _selector("not");
  s_notEmpty= _selector("notEmpty");
  s_notImplemented_= _selector("notImplemented:");
  s_notNil= _selector("notNil");
  s_noteExportNLR= _selector("noteExportNLR");
  s_noteExportOuter= _selector("noteExportOuter");
  s_noteExportSelf= _selector("noteExportSelf");
  s_note_= _selector("note:");
  s_octal3= _selector("octal3");
  s_offset= _selector("offset");
  s_on_= _selector("on:");
  s_or_= _selector("or:");
  s_osError= _selector("osError");
  s_osErrorString= _selector("osErrorString");
  s_osErrorString_= _selector("osErrorString:");
  s_outputStream= _selector("outputStream");
  s_parent= _selector("parent");
  s_parse= _selector("parse");
  s_parseArgument_with_= _selector("parseArgument:with:");
  s_parseArray= _selector("parseArray");
  s_parseArrayLiteral= _selector("parseArrayLiteral");
  s_parseBinary= _selector("parseBinary");
  s_parseBlock= _selector("parseBlock");
  s_parseBlockParameters_= _selector("parseBlockParameters:");
  s_parseByteArray= _selector("parseByteArray");
  s_parseClass_= _selector("parseClass:");
  s_parseDeclaration= _selector("parseDeclaration");
  s_parseExec= _selector("parseExec");
  s_parseExpression= _selector("parseExpression");
  s_parseExtern= _selector("parseExtern");
  s_parseLiteralP= _selector("parseLiteralP");
  s_parseMethod_= _selector("parseMethod:");
  s_parseOption_with_= _selector("parseOption:with:");
  s_parsePrimary= _selector("parsePrimary");
  s_parseSequence_= _selector("parseSequence:");
  s_parseTemporaries_= _selector("parseTemporaries:");
  s_parseUnary= _selector("parseUnary");
  s_parseWordArray= _selector("parseWordArray");
  s_parse_= _selector("parse:");
  s_parse_startingAt_= _selector("parse:startingAt:");
  s_pastEndPut_= _selector("pastEndPut:");
  s_peek= _selector("peek");
  s_perform_= _selector("perform:");
  s_perform_with_= _selector("perform:with:");
  s_positionError= _selector("positionError");
  s_position_= _selector("position:");
  s_primitiveFailed= _selector("primitiveFailed");
  s_print= _selector("print");
  s_printDigitOn_= _selector("printDigitOn:");
  s_printElementsOn_= _selector("printElementsOn:");
  s_printNameOn_= _selector("printNameOn:");
  s_printOn_= _selector("printOn:");
  s_printOn_indent_= _selector("printOn:indent:");
  s_printString= _selector("printString");
  s_print_= _selector("print:");
  s_println= _selector("println");
  s_quit= _selector("quit");
  s_reSort= _selector("reSort");
  s_readFromFileNamed_= _selector("readFromFileNamed:");
  s_readFromFileNamed_ifError_= _selector("readFromFileNamed:ifError:");
  s_readFrom_base_= _selector("readFrom:base:");
  s_readStream= _selector("readStream");
  s_refute= _selector("refute");
  s_refute_= _selector("refute:");
  s_removeFirst= _selector("removeFirst");
  s_removeLast= _selector("removeLast");
  s_repeat= _selector("repeat");
  s_replaceFrom_to_with_startingAt_= _selector("replaceFrom:to:with:startingAt:");
  s_reset= _selector("reset");
  s_resetTemps= _selector("resetTemps");
  s_resetToStart= _selector("resetToStart");
  s_return_= _selector("return:");
  s_scan= _selector("scan");
  s_scanCharacter= _selector("scanCharacter");
  s_scanEscape= _selector("scanEscape");
  s_scanFor_= _selector("scanFor:");
  s_scanKeywords= _selector("scanKeywords");
  s_scanOctal= _selector("scanOctal");
  s_searchPaths= _selector("searchPaths");
  s_second= _selector("second");
  s_selector= _selector("selector");
  s_setCollection_= _selector("setCollection:");
  s_shouldNotImplement= _selector("shouldNotImplement");
  s_size= _selector("size");
  s_sizeof= _selector("sizeof");
  s_skip_= _selector("skip:");
  s_slots= _selector("slots");
  s_sortBlock_= _selector("sortBlock:");
  s_space= _selector("space");
  s_space_= _selector("space:");
  s_species= _selector("species");
  s_string_= _selector("string:");
  s_subclassResponsibility= _selector("subclassResponsibility");
  s_subclassResponsibility_= _selector("subclassResponsibility:");
  s_supered_= _selector("supered:");
  s_tab= _selector("tab");
  s_tab_= _selector("tab:");
  s_tag= _selector("tag");
  s_tempCount= _selector("tempCount");
  s_third= _selector("third");
  s_timesRepeat_= _selector("timesRepeat:");
  s_to_do_= _selector("to:do:");
  s_tokenised_= _selector("tokenised:");
  s_typeName= _selector("typeName");
  s_value= _selector("value");
  s_value_= _selector("value:");
  s_value_value_= _selector("value:value:");
  s_warnBlockReceiver= _selector("warnBlockReceiver");
  s_whileFalse_= _selector("whileFalse:");
  s_whileTrue_= _selector("whileTrue:");
  s_withClass_selector_arguments_= _selector("withClass:selector:arguments:");
  s_withCode_= _selector("withCode:");
  s_withElements_= _selector("withElements:");
  s_withName_= _selector("withName:");
  s_withName_base_slots_= _selector("withName:base:slots:");
  s_withName_line_input_header_= _selector("withName:line:input:header:");
  s_withName_mangledName_= _selector("withName:mangledName:");
  s_withName_mangledName_class_= _selector("withName:mangledName:class:");
  s_withName_mangledName_level_= _selector("withName:mangledName:level:");
  s_withNames_= _selector("withNames:");
  s_withParent_block_= _selector("withParent:block:");
  s_withReceiver_selector_= _selector("withReceiver:selector:");
  s_withStatement_= _selector("withStatement:");
  s_withText_= _selector("withText:");
  s_withValue_= _selector("withValue:");
  s_withVariable_= _selector("withVariable:");
  s_withVariable_value_= _selector("withVariable:value:");
  s_with_= _selector("with:");
  s_with_do_= _selector("with:do:");
  s_wordAt_= _selector("wordAt:");
  s_wordAt_put_= _selector("wordAt:put:");
  s_writeStream= _selector("writeStream");
  s_writeToFileNamed_= _selector("writeToFileNamed:");
  s_writeToFileNamed_ifError_= _selector("writeToFileNamed:ifError:");
  s_xBinary= _selector("xBinary");
  s_xBrace= _selector("xBrace");
  s_xCharacter= _selector("xCharacter");
  s_xColon= _selector("xColon");
  s_xComment= _selector("xComment");
  s_xDigit= _selector("xDigit");
  s_xDot= _selector("xDot");
  s_xIllegal= _selector("xIllegal");
  s_xLetter= _selector("xLetter");
  s_xPunctuator= _selector("xPunctuator");
  s_xSign= _selector("xSign");
  s_xString= _selector("xString");
  s_yourself= _selector("yourself");
  v_Object=_proto(0);
  _method(v_Object, s__5fsizeof, (imp_t)Object__5fsizeof);
  _method(v_Object, s__5fdebugName, (imp_t)Object__5fdebugName);
  v_UndefinedObject=_proto(v_Object);
  _method(v_UndefinedObject, s__5fsizeof, (imp_t)UndefinedObject__5fsizeof);
  _method(v_UndefinedObject, s__5fdebugName, (imp_t)UndefinedObject__5fdebugName);
  v_StaticBlock=_proto(v_Object);
  _method(v_StaticBlock, s__5fsizeof, (imp_t)StaticBlock__5fsizeof);
  _method(v_StaticBlock, s__5fdebugName, (imp_t)StaticBlock__5fdebugName);
  v_BlockClosure=_proto(v_StaticBlock);
  _method(v_BlockClosure, s__5fsizeof, (imp_t)BlockClosure__5fsizeof);
  _method(v_BlockClosure, s__5fdebugName, (imp_t)BlockClosure__5fdebugName);
  v_BlockClosureNLR=_proto(v_BlockClosure);
  _method(v_BlockClosureNLR, s__5fsizeof, (imp_t)BlockClosureNLR__5fsizeof);
  _method(v_BlockClosureNLR, s__5fdebugName, (imp_t)BlockClosureNLR__5fdebugName);
  v_Magnitude=_proto(v_Object);
  _method(v_Magnitude, s__5fsizeof, (imp_t)Magnitude__5fsizeof);
  _method(v_Magnitude, s__5fdebugName, (imp_t)Magnitude__5fdebugName);
  v_Number=_proto(v_Magnitude);
  _method(v_Number, s__5fsizeof, (imp_t)Number__5fsizeof);
  _method(v_Number, s__5fdebugName, (imp_t)Number__5fdebugName);
  v_Integer=_proto(v_Number);
  _method(v_Integer, s__5fsizeof, (imp_t)Integer__5fsizeof);
  _method(v_Integer, s__5fdebugName, (imp_t)Integer__5fdebugName);
  v_SmallInteger=_proto(v_Integer);
  _method(v_SmallInteger, s__5fsizeof, (imp_t)SmallInteger__5fsizeof);
  _method(v_SmallInteger, s__5fdebugName, (imp_t)SmallInteger__5fdebugName);
  v_Collection=_proto(v_Object);
  _method(v_Collection, s__5fsizeof, (imp_t)Collection__5fsizeof);
  _method(v_Collection, s__5fdebugName, (imp_t)Collection__5fdebugName);
  v_SequenceableCollection=_proto(v_Collection);
  _method(v_SequenceableCollection, s__5fsizeof, (imp_t)SequenceableCollection__5fsizeof);
  _method(v_SequenceableCollection, s__5fdebugName, (imp_t)SequenceableCollection__5fdebugName);
  v_ArrayedCollection=_proto(v_SequenceableCollection);
  _method(v_ArrayedCollection, s__5fsizeof, (imp_t)ArrayedCollection__5fsizeof);
  _method(v_ArrayedCollection, s__5fdebugName, (imp_t)ArrayedCollection__5fdebugName);
  v_Array=_proto(v_ArrayedCollection);
  _method(v_Array, s__5fsizeof, (imp_t)Array__5fsizeof);
  _method(v_Array, s__5fdebugName, (imp_t)Array__5fdebugName);
  v_ImmutableArray=_proto(v_Array);
  _method(v_ImmutableArray, s__5fsizeof, (imp_t)ImmutableArray__5fsizeof);
  _method(v_ImmutableArray, s__5fdebugName, (imp_t)ImmutableArray__5fdebugName);
  v_ByteArray=_proto(v_ArrayedCollection);
  _method(v_ByteArray, s__5fsizeof, (imp_t)ByteArray__5fsizeof);
  _method(v_ByteArray, s__5fdebugName, (imp_t)ByteArray__5fdebugName);
  v_ImmutableByteArray=_proto(v_ByteArray);
  _method(v_ImmutableByteArray, s__5fsizeof, (imp_t)ImmutableByteArray__5fsizeof);
  _method(v_ImmutableByteArray, s__5fdebugName, (imp_t)ImmutableByteArray__5fdebugName);
  v_String=_proto(v_ByteArray);
  _method(v_String, s__5fsizeof, (imp_t)String__5fsizeof);
  _method(v_String, s__5fdebugName, (imp_t)String__5fdebugName);
  v_ImmutableString=_proto(v_String);
  _method(v_ImmutableString, s__5fsizeof, (imp_t)ImmutableString__5fsizeof);
  _method(v_ImmutableString, s__5fdebugName, (imp_t)ImmutableString__5fdebugName);
  {
 {
  oop _1;
  _1= v_SmallInteger;
  _1= _bind(_1, s__5fbeTaggedType)(_1);
 }
  }
  {
 {
  oop _1;
  _1= v_UndefinedObject;
  _1= _bind(_1, s__5fbeNilType)(_1);
 }
  }
  {
 {
  oop _1;
  _1= v_Object;
  v_true= _1;
 }
  }
  {
 {
  oop _1;
  _1= v_nil;
  v_false= _1;
 }
  }
  _method(v_Object, s__5fclone_, (imp_t)Object__s__5fclone_);
  _method(v_Object, s__5fclone, (imp_t)Object__s__5fclone);
  _method(v_SmallInteger, s__5fvalue_, (imp_t)SmallInteger__s__5fvalue_);
  _method(v_SmallInteger, s__5fintegerValue, (imp_t)SmallInteger__s__5fintegerValue);
  _method(v_String, s__5fvalue_, (imp_t)String__s__5fvalue_);
  _method(v_String, s__5fstringValue, (imp_t)String__s__5fstringValue);
  _method(v_String, s_size, (imp_t)String__s_size);
  _method(v_Object, s_newln, (imp_t)Object__s_newln);
  _method(v_Object, s_println, (imp_t)Object__s_println);
  _method(v_Object, s_print, (imp_t)Object__s_print);
  _method(v_Object, s_debugName, (imp_t)Object__s_debugName);
  _method(v_UndefinedObject, s__5fdebugName, (imp_t)UndefinedObject__s__5fdebugName);
  _method(v_SmallInteger, s_print, (imp_t)SmallInteger__s_print);
  _method(v_String, s_print, (imp_t)String__s_print);
  v__object=_proto(0);
  _method(v__object, s__5fsizeof, (imp_t)_object__5fsizeof);
  _method(v__object, s__5fdebugName, (imp_t)_object__5fdebugName);
  {
 {
  oop _1, _2;
  _1= v__object;
  _2= v__object;
  _2= _bind(_2, s__5fvtbl)(_2);
  _2= _bind(_2, s_delegate)(_2);
  _1= _bind(_1, s__5fvtbl_)(_1, _2);
 }
  }
  _method(v__object, s__5fdebugName, (imp_t)_object__s__5fdebugName);
  _method(v__object, s__5fsizeof, (imp_t)_object__s__5fsizeof);
  _method(v__object, s__5fvtbl, (imp_t)_object__s__5fvtbl);
  _method(v__object, s__5fvtbl_, (imp_t)_object__s__5fvtbl_);
  v__vtbl=_proto(v__object);
  _method(v__vtbl, s__5fsizeof, (imp_t)_vtbl__5fsizeof);
  _method(v__vtbl, s__5fdebugName, (imp_t)_vtbl__5fdebugName);
  {
 {
  oop _1;
  _1= v__vtbl;
  _1= _bind(_1, s__5fvtbl)(_1);
  v__vtbl= _1;
 }
  }
  _method(v__vtbl, s__5fdebugName, (imp_t)_vtbl__s__5fdebugName);
  _method(v__vtbl, s__5fsizeof, (imp_t)_vtbl__s__5fsizeof);
  _method(v__vtbl, s_delegate, (imp_t)_vtbl__s_delegate);
  _method(v__vtbl, s_delegate_, (imp_t)_vtbl__s_delegate_);
  _method(v__vtbl, s_size, (imp_t)_vtbl__s_size);
  _method(v__vtbl, s_bindingAt_, (imp_t)_vtbl__s_bindingAt_);
  _method(v__vtbl, s_bindingAt_put_, (imp_t)_vtbl__s_bindingAt_put_);
  v__binding=_proto(v__object);
  _method(v__binding, s__5fsizeof, (imp_t)_binding__5fsizeof);
  _method(v__binding, s__5fdebugName, (imp_t)_binding__5fdebugName);
  l_1= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  {
 {
  oop _1, _2, _3;
  _1= v__binding;
  _2= v__vtbl;
  _3= l_1;
  _2= _bind(_2, s_bindingAt_)(_2, _3);
  _2= _bind(_2, s__5fvtbl)(_2);
  _1= _bind(_1, s__5fvtbl_)(_1, _2);
 }
  }
  _method(v__binding, s__5fdebugName, (imp_t)_binding__s__5fdebugName);
  _method(v__binding, s__5fsizeof, (imp_t)_binding__s__5fsizeof);
  _method(v__binding, s_selector, (imp_t)_binding__s_selector);
  _method(v__binding, s__5fmethod, (imp_t)_binding__s__5fmethod);
  _method(v__binding, s__5fmethod_, (imp_t)_binding__s__5fmethod_);
  v__selector=_proto(v__object);
  _method(v__selector, s__5fsizeof, (imp_t)_selector__5fsizeof);
  _method(v__selector, s__5fdebugName, (imp_t)_selector__5fdebugName);
  l_2= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  {
 {
  oop _1, _2, _3;
  _1= v__selector;
  _2= v__vtbl;
  _3= l_2;
  _2= _bind(_2, s_bindingAt_)(_2, _3);
  _2= _bind(_2, s_selector)(_2);
  _2= _bind(_2, s__5fvtbl)(_2);
  _1= _bind(_1, s__5fvtbl_)(_1, _2);
 }
  }
  _method(v__selector, s__5fdebugName, (imp_t)_selector__s__5fdebugName);
  _method(v__selector, s__5fsizeof, (imp_t)_selector__s__5fsizeof);
  _method(v__selector, s_size, (imp_t)_selector__s_size);
  _method(v__selector, s_name, (imp_t)_selector__s_name);
  _method(v__selector, s_next, (imp_t)_selector__s_next);
  _method(v__selector, s_next_, (imp_t)_selector__s_next_);
  _method(v__object, s_sizeof, (imp_t)_object__s_sizeof);
  _method(v__object, s__5fnewPointers_, (imp_t)_object__s__5fnewPointers_);
  _method(v__object, s__5fclone_, (imp_t)_object__s__5fclone_);
  _method(v__object, s__5fclone, (imp_t)_object__s__5fclone);
  _method(v__object, s__5fdelegated, (imp_t)_object__s__5fdelegated);
  l_3= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_4= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v__vtbl, s_delegated, (imp_t)_vtbl__s_delegated);
  _method(v__vtbl, s_allocate_, (imp_t)_vtbl__s_allocate_);
  _method(v__vtbl, s_beNilType, (imp_t)_vtbl__s_beNilType);
  _method(v__vtbl, s_beTaggedType, (imp_t)_vtbl__s_beTaggedType);
  _method(v__object, s__5fbeNilType, (imp_t)_object__s__5fbeNilType);
  _method(v__object, s__5fbeTaggedType, (imp_t)_object__s__5fbeTaggedType);
  _method(v__object, s__5frealloc_size_, (imp_t)_object__s__5frealloc_size_);
  l_5= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v__vtbl, s_grow, (imp_t)_vtbl__s_grow);
  _method(v__binding, s_newSelector_method_, (imp_t)_binding__s_newSelector_method_);
  l_6= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_7= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_8= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_9= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v__vtbl, s_at_put_, (imp_t)_vtbl__s_at_put_);
  l_10= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_11= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v__vtbl, s_at_, (imp_t)_vtbl__s_at_);
  _method(v__object, s__5fmethodAt_put_, (imp_t)_object__s__5fmethodAt_put_);
  _method(v__vtbl, s_flushCache, (imp_t)_vtbl__s_flushCache);
  _method(v__selector, s__5fvalue_, (imp_t)_selector__s__5fvalue_);
  _method(v__object, s_is_5fselector, (imp_t)_object__s_is_5fselector);
  _method(v__selector, s_is_5fselector, (imp_t)_selector__s_is_5fselector);
  _method(v__selector, s__5fstringValue, (imp_t)_selector__s__5fstringValue);
  _method(v__selector, s__5fcString, (imp_t)_selector__s__5fcString);
  _method(v__object, s__5fmemcmp_with_length_, (imp_t)_object__s__5fmemcmp_with_length_);
  l_12= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v__selector, s__3d, (imp_t)_selector__s__3d);
  _method(v__selector, s_list, (imp_t)_selector__s_list);
  _method(v__selector, s_list_, (imp_t)_selector__s_list_);
  _method(v__selector, s_intern_, (imp_t)_selector__s_intern_);
  _method(v__selector, s__5fintern_, (imp_t)_selector__s__5fintern_);
  _method(v__vtbl, s_lookup_, (imp_t)_vtbl__s_lookup_);
  {
 {
  oop _1;
  _1= v__vtbl;
  _1= _bind(_1, s_flushCache)(_1);
 }
  }
  _method(v_Object, s_new, (imp_t)Object__s_new);
  _method(v_Object, s_initialise, (imp_t)Object__s_initialise);
  _method(v_Object, s_yourself, (imp_t)Object__s_yourself);
  _method(v_Object, s_species, (imp_t)Object__s_species);
  _method(v_Object, s_isNil, (imp_t)Object__s_isNil);
  _method(v_Object, s_notNil, (imp_t)Object__s_notNil);
  _method(v_Object, s__5fidentityHash, (imp_t)Object__s__5fidentityHash);
  _method(v_Object, s_identityHash, (imp_t)Object__s_identityHash);
  _method(v_Object, s_hash, (imp_t)Object__s_hash);
  _method(v_Object, s__3d_3d, (imp_t)Object__s__3d_3d);
  _method(v_Object, s__7e_7e, (imp_t)Object__s__7e_7e);
  _method(v_Object, s__3d, (imp_t)Object__s__3d);
  _method(v_Object, s__7e_3d, (imp_t)Object__s__7e_3d);
  _method(v_Object, s_not, (imp_t)Object__s_not);
  _method(v_Object, s_ifTrue_, (imp_t)Object__s_ifTrue_);
  _method(v_Object, s_and_, (imp_t)Object__s_and_);
  _method(v_Object, s_ifFalse_, (imp_t)Object__s_ifFalse_);
  _method(v_Object, s_or_, (imp_t)Object__s_or_);
  _method(v_Object, s_assert, (imp_t)Object__s_assert);
  l_13= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"refutation failed");
  _method(v_Object, s_refute, (imp_t)Object__s_refute);
  _method(v_Object, s_assert_, (imp_t)Object__s_assert_);
  _method(v_Object, s_refute_, (imp_t)Object__s_refute_);
  _method(v_Object, s_isKindOf_, (imp_t)Object__s_isKindOf_);
  _method(v_Object, s_isMemberOf_, (imp_t)Object__s_isMemberOf_);
  l_14= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)32);
  _method(v_Object, s_printString, (imp_t)Object__s_printString);
  _method(v_Object, s_printOn_, (imp_t)Object__s_printOn_);
  _method(v_Object, s__5ferror_, (imp_t)Object__s__5ferror_);
  _method(v_Object, s_error_, (imp_t)Object__s_error_);
  l_15= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" should have overridden a message");
  _method(v_Object, s_subclassResponsibility, (imp_t)Object__s_subclassResponsibility);
  l_16= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" should have overridden ");
  _method(v_Object, s_subclassResponsibility_, (imp_t)Object__s_subclassResponsibility_);
  l_17= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"this message is inappropriate for this object");
  _method(v_Object, s_shouldNotImplement, (imp_t)Object__s_shouldNotImplement);
  l_18= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"a primitive has failed");
  _method(v_Object, s_primitiveFailed, (imp_t)Object__s_primitiveFailed);
  {
 {
  oop _1;
  _1= v_UndefinedObject;
  _1= _bind(_1, s__5fbeNilType)(_1);
 }
  }
  _method(v_UndefinedObject, s_isNil, (imp_t)UndefinedObject__s_isNil);
  _method(v_UndefinedObject, s_notNil, (imp_t)UndefinedObject__s_notNil);
  _method(v_UndefinedObject, s_not, (imp_t)UndefinedObject__s_not);
  _method(v_UndefinedObject, s_ifTrue_, (imp_t)UndefinedObject__s_ifTrue_);
  _method(v_UndefinedObject, s_and_, (imp_t)UndefinedObject__s_and_);
  _method(v_UndefinedObject, s_ifFalse_, (imp_t)UndefinedObject__s_ifFalse_);
  _method(v_UndefinedObject, s_or_, (imp_t)UndefinedObject__s_or_);
  l_19= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"assertion failed");
  _method(v_UndefinedObject, s_assert, (imp_t)UndefinedObject__s_assert);
  _method(v_UndefinedObject, s_refute, (imp_t)UndefinedObject__s_refute);
  _method(v_StaticBlock, s__5fentry__5farity_, (imp_t)StaticBlock__s__5fentry__5farity_);
  _method(v_StaticBlock, s_arity, (imp_t)StaticBlock__s_arity);
  _method(v_StaticBlock, s_value, (imp_t)StaticBlock__s_value);
  _method(v_StaticBlock, s_value_, (imp_t)StaticBlock__s_value_);
  _method(v_StaticBlock, s_value_value_, (imp_t)StaticBlock__s_value_value_);
  _method(v_StaticBlock, s_repeat, (imp_t)StaticBlock__s_repeat);
  _method(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_, (imp_t)BlockClosure__s__5fentry__5farity_receiver_state_outer_);
  _method(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_, (imp_t)BlockClosureNLR__s__5fentry__5farity_receiver_state_envp_);
  l_20= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"cannotReturn");
  _method(v_BlockClosureNLR, s_cannotReturn_, (imp_t)BlockClosureNLR__s_cannotReturn_);
  _method(v_BlockClosureNLR, s_return_, (imp_t)BlockClosureNLR__s_return_);
  v_Association=_proto(v_Object);
  _method(v_Association, s__5fsizeof, (imp_t)Association__5fsizeof);
  _method(v_Association, s__5fdebugName, (imp_t)Association__5fdebugName);
  _method(v_Association, s_key_value_, (imp_t)Association__s_key_value_);
  _method(v_Association, s_key, (imp_t)Association__s_key);
  _method(v_Association, s_value, (imp_t)Association__s_value);
  _method(v_Association, s_key_, (imp_t)Association__s_key_);
  _method(v_Association, s_value_, (imp_t)Association__s_value_);
  _method(v_Association, s_hash, (imp_t)Association__s_hash);
  _method(v_Association, s__3d, (imp_t)Association__s__3d);
  l_21= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v_Collection, s_new, (imp_t)Collection__s_new);
  _method(v_Collection, s_with_, (imp_t)Collection__s_with_);
  _method(v_Collection, s_emptyCheck, (imp_t)Collection__s_emptyCheck);
  l_22= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Collection, s_isEmpty, (imp_t)Collection__s_isEmpty);
  _method(v_Collection, s_notEmpty, (imp_t)Collection__s_notEmpty);
  _method(v_Collection, s_addAll_, (imp_t)Collection__s_addAll_);
  _method(v_Collection, s_includes_, (imp_t)Collection__s_includes_);
  _method(v_Collection, s_do_, (imp_t)Collection__s_do_);
  l_23= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_24= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Collection, s_doWithIndex_, (imp_t)Collection__s_doWithIndex_);
  _method(v_Collection, s_inject_into_, (imp_t)Collection__s_inject_into_);
  _method(v_Collection, s_collect_, (imp_t)Collection__s_collect_);
  _method(v_Collection, s_asArray, (imp_t)Collection__s_asArray);
  l_25= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"this collection is empty");
  _method(v_Collection, s_errorEmptyCollection, (imp_t)Collection__s_errorEmptyCollection);
  l_26= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"this collection cannot be modified");
  _method(v_Collection, s_errorCannotModify, (imp_t)Collection__s_errorCannotModify);
  _method(v_Collection, s_printOn_, (imp_t)Collection__s_printOn_);
  _method(v_Collection, s_printNameOn_, (imp_t)Collection__s_printNameOn_);
  l_27= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(");
  l_28= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_29= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  _method(v_Collection, s_printElementsOn_, (imp_t)Collection__s_printElementsOn_);
  l_30= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(");
  l_32= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_31= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ");
  _method(v_Collection, s_print, (imp_t)Collection__s_print);
  l_33= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_34= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SequenceableCollection, s_with_, (imp_t)SequenceableCollection__s_with_);
  l_35= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_36= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_atAllPut_, (imp_t)SequenceableCollection__s_atAllPut_);
  _method(v_SequenceableCollection, s_atAll_put_, (imp_t)SequenceableCollection__s_atAll_put_);
  l_37= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SequenceableCollection, s_first, (imp_t)SequenceableCollection__s_first);
  l_38= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_second, (imp_t)SequenceableCollection__s_second);
  l_39= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v_SequenceableCollection, s_third, (imp_t)SequenceableCollection__s_third);
  l_40= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_last, (imp_t)SequenceableCollection__s_last);
  l_41= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_42= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_do_, (imp_t)SequenceableCollection__s_do_);
  l_43= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_44= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_with_do_, (imp_t)SequenceableCollection__s_with_do_);
  l_45= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_46= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_doWithIndex_, (imp_t)SequenceableCollection__s_doWithIndex_);
  _method(v_SequenceableCollection, s_collect_, (imp_t)SequenceableCollection__s_collect_);
  l_47= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"subscript is out of bounds");
  _method(v_SequenceableCollection, s_errorSubscriptBounds_, (imp_t)SequenceableCollection__s_errorSubscriptBounds_);
  l_48= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"improper store into indexable object");
  _method(v_SequenceableCollection, s_errorImproperStore_, (imp_t)SequenceableCollection__s_errorImproperStore_);
  l_49= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_50= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SequenceableCollection, s_replaceFrom_to_with_startingAt_, (imp_t)SequenceableCollection__s_replaceFrom_to_with_startingAt_);
  l_51= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SequenceableCollection, s_copyFrom_to_, (imp_t)SequenceableCollection__s_copyFrom_to_);
  _method(v_SequenceableCollection, s_copyFrom_, (imp_t)SequenceableCollection__s_copyFrom_);
  l_52= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_53= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_54= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SequenceableCollection, s__2c, (imp_t)SequenceableCollection__s__2c);
  _method(v_SequenceableCollection, s__3d, (imp_t)SequenceableCollection__s__3d);
  v_OrderedCollection=_proto(v_SequenceableCollection);
  _method(v_OrderedCollection, s__5fsizeof, (imp_t)OrderedCollection__5fsizeof);
  _method(v_OrderedCollection, s__5fdebugName, (imp_t)OrderedCollection__5fdebugName);
  _method(v_OrderedCollection, s_new_, (imp_t)OrderedCollection__s_new_);
  l_55= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" COPY FROM ");
  l_56= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" TO ");
  l_58= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_57= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_59= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  -> ");
  _method(v_OrderedCollection, s_copyFrom_to_, (imp_t)OrderedCollection__s_copyFrom_to_);
  l_60= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  _method(v_OrderedCollection, s_reset, (imp_t)OrderedCollection__s_reset);
  _method(v_OrderedCollection, s_setCollection_, (imp_t)OrderedCollection__s_setCollection_);
  l_61= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  l_62= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_growSize, (imp_t)OrderedCollection__s_growSize);
  l_63= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_64= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_65= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_makeRoomAtFirst, (imp_t)OrderedCollection__s_makeRoomAtFirst);
  l_66= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_67= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_68= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_makeRoomAtLast, (imp_t)OrderedCollection__s_makeRoomAtLast);
  l_69= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_70= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_addFirst_, (imp_t)OrderedCollection__s_addFirst_);
  l_71= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_addLast_, (imp_t)OrderedCollection__s_addLast_);
  _method(v_OrderedCollection, s_add_, (imp_t)OrderedCollection__s_add_);
  l_72= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_removeFirst, (imp_t)OrderedCollection__s_removeFirst);
  l_73= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_removeLast, (imp_t)OrderedCollection__s_removeLast);
  _method(v_OrderedCollection, s_at_, (imp_t)OrderedCollection__s_at_);
  _method(v_OrderedCollection, s_at_put_, (imp_t)OrderedCollection__s_at_put_);
  _method(v_OrderedCollection, s_size, (imp_t)OrderedCollection__s_size);
  l_74= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_75= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_76= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_77= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_78= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_insert_before_, (imp_t)OrderedCollection__s_insert_before_);
  l_79= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_OrderedCollection, s_collect_, (imp_t)OrderedCollection__s_collect_);
  v_SortedCollection=_proto(v_OrderedCollection);
  _method(v_SortedCollection, s__5fsizeof, (imp_t)SortedCollection__5fsizeof);
  _method(v_SortedCollection, s__5fdebugName, (imp_t)SortedCollection__5fdebugName);
  _method(v_SortedCollection, s_new_, (imp_t)SortedCollection__s_new_);
  _method(v_SortedCollection, s_sortBlock_, (imp_t)SortedCollection__s_sortBlock_);
  _method(v_SortedCollection, s_addFirst_, (imp_t)SortedCollection__s_addFirst_);
  _method(v_SortedCollection, s_addLast_, (imp_t)SortedCollection__s_addLast_);
  _method(v_SortedCollection, s_insert_before_, (imp_t)SortedCollection__s_insert_before_);
  _method(v_SortedCollection, s_add_, (imp_t)SortedCollection__s_add_);
  l_80= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_81= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_82= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_83= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_84= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_85= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_86= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SortedCollection, s_indexForInserting_, (imp_t)SortedCollection__s_indexForInserting_);
  _method(v_Collection, s_asSortedCollection_, (imp_t)Collection__s_asSortedCollection_);
  _method(v_Collection, s_asSortedCollection, (imp_t)Collection__s_asSortedCollection);
  _method(v_ArrayedCollection, s__5fsize_value_, (imp_t)ArrayedCollection__s__5fsize_value_);
  _method(v_ArrayedCollection, s_size, (imp_t)ArrayedCollection__s_size);
  _method(v_ArrayedCollection, s__5felements, (imp_t)ArrayedCollection__s__5felements);
  _method(v_Array, s__5fsize_value_, (imp_t)Array__s__5fsize_value_);
  _method(v_Array, s_new_, (imp_t)Array__s_new_);
  _method(v_Array, s_at_, (imp_t)Array__s_at_);
  _method(v_Array, s_at_put_, (imp_t)Array__s_at_put_);
  l_87= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#");
  _method(v_Array, s_printOn_, (imp_t)Array__s_printOn_);
  _method(v_ImmutableArray, s_at_put_, (imp_t)ImmutableArray__s_at_put_);
  _method(v_ImmutableArray, s_species, (imp_t)ImmutableArray__s_species);
  _method(v_Magnitude, s__3c, (imp_t)Magnitude__s__3c);
  _method(v_Magnitude, s__3c_3d, (imp_t)Magnitude__s__3c_3d);
  _method(v_Magnitude, s__3d, (imp_t)Magnitude__s__3d);
  _method(v_Magnitude, s_hash, (imp_t)Magnitude__s_hash);
  _method(v_Magnitude, s__3e_3d, (imp_t)Magnitude__s__3e_3d);
  _method(v_Magnitude, s__3e, (imp_t)Magnitude__s__3e);
  _method(v_Magnitude, s_between_and_, (imp_t)Magnitude__s_between_and_);
  _method(v_Magnitude, s_max_, (imp_t)Magnitude__s_max_);
  _method(v_Magnitude, s_min_, (imp_t)Magnitude__s_min_);
  _method(v_Magnitude, s_min_max_, (imp_t)Magnitude__s_min_max_);
  l_88= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Number, s_negated, (imp_t)Number__s_negated);
  _method(v_Object, s_isInteger, (imp_t)Object__s_isInteger);
  _method(v_Integer, s_isInteger, (imp_t)Integer__s_isInteger);
  {
 {
  oop _1;
  _1= v_SmallInteger;
  _1= _bind(_1, s__5fbeTaggedType)(_1);
 }
  }
  _method(v_Object, s_isSmallInteger, (imp_t)Object__s_isSmallInteger);
  _method(v_SmallInteger, s_isSmallInteger, (imp_t)SmallInteger__s_isSmallInteger);
  _method(v_SmallInteger, s__2b, (imp_t)SmallInteger__s__2b);
  _method(v_SmallInteger, s__2d, (imp_t)SmallInteger__s__2d);
  _method(v_SmallInteger, s__2a, (imp_t)SmallInteger__s__2a);
  _method(v_SmallInteger, s__2f_2f, (imp_t)SmallInteger__s__2f_2f);
  _method(v_SmallInteger, s__5c_5c, (imp_t)SmallInteger__s__5c_5c);
  _method(v_SmallInteger, s_bitAnd_, (imp_t)SmallInteger__s_bitAnd_);
  _method(v_SmallInteger, s_bitOr_, (imp_t)SmallInteger__s_bitOr_);
  _method(v_SmallInteger, s_bitXor_, (imp_t)SmallInteger__s_bitXor_);
  _method(v_SmallInteger, s__3c, (imp_t)SmallInteger__s__3c);
  _method(v_SmallInteger, s__3c_3d, (imp_t)SmallInteger__s__3c_3d);
  _method(v_SmallInteger, s__3d, (imp_t)SmallInteger__s__3d);
  _method(v_SmallInteger, s__3e_3d, (imp_t)SmallInteger__s__3e_3d);
  _method(v_SmallInteger, s__3e, (imp_t)SmallInteger__s__3e);
  l_89= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SmallInteger, s_to_do_, (imp_t)SmallInteger__s_to_do_);
  l_90= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_91= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SmallInteger, s_timesRepeat_, (imp_t)SmallInteger__s_timesRepeat_);
  v_Character=_proto(v_Magnitude);
  _method(v_Character, s__5fsizeof, (imp_t)Character__5fsizeof);
  _method(v_Character, s__5fdebugName, (imp_t)Character__5fdebugName);
  _method(v_Character, s_basicValue_, (imp_t)Character__s_basicValue_);
  v_CharacterArray=_proto(v_Array);
  _method(v_CharacterArray, s__5fsizeof, (imp_t)CharacterArray__5fsizeof);
  _method(v_CharacterArray, s__5fdebugName, (imp_t)CharacterArray__5fdebugName);
  _method(v_Character, s_value_, (imp_t)Character__s_value_);
  _method(v_Character, s_asciiValue_, (imp_t)Character__s_asciiValue_);
  _method(v_Character, s__5fvalue_, (imp_t)Character__s__5fvalue_);
  _method(v_Character, s_value, (imp_t)Character__s_value);
  _method(v_Character, s_asciiValue, (imp_t)Character__s_asciiValue);
  l_92= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)256);
  l_93= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_94= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)255);
  c_23= _bind(v_StaticBlock, s__5fentry__5farity_)(v_StaticBlock, b_23, 1);
  _method(v_CharacterArray, s_initialise, (imp_t)CharacterArray__s_initialise);
  {
 {
  oop _1;
  _1= v_CharacterArray;
  _1= _bind(_1, s_initialise)(_1);
 }
  }
  l_95= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  l_96= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)48);
  l_97= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)87);
  _method(v_Character, s_digitValue_, (imp_t)Character__s_digitValue_);
  l_98= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_99= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_100= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_101= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_102= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_103= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_104= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_105= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_106= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_107= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_108= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_109= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_110= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_111= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_112= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_113= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_114= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_115= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_116= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_117= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_118= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_119= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_120= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_121= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_122= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_123= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_124= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_125= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_126= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_127= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_128= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_129= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_130= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_131= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_132= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_133= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_134= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_135= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_136= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_137= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_138= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_139= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_140= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_141= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_142= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_143= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_144= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_145= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_146= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_147= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_148= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_149= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  l_150= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)4);
  l_151= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)5);
  l_152= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)6);
  l_153= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)7);
  l_154= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_155= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)9);
  l_156= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_157= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_158= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_159= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_160= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_161= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_162= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_163= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  l_164= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)11);
  l_165= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)12);
  l_166= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)13);
  l_167= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)14);
  l_168= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)15);
  l_169= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_170= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)17);
  l_171= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)18);
  l_172= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)19);
  l_173= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)20);
  l_174= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)21);
  l_175= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)22);
  l_176= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)23);
  l_177= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)24);
  l_178= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)25);
  l_179= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)26);
  l_180= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)27);
  l_181= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)28);
  l_182= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)29);
  l_183= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)30);
  l_184= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)31);
  l_185= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)32);
  l_186= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)33);
  l_187= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)34);
  l_188= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)35);
  l_189= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_190= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_191= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_192= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_193= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_194= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_195= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  l_196= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)11);
  l_197= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)12);
  l_198= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)13);
  l_199= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)14);
  l_200= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)15);
  l_201= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_202= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)17);
  l_203= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)18);
  l_204= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)19);
  l_205= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)20);
  l_206= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)21);
  l_207= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)22);
  l_208= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)23);
  l_209= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)24);
  l_210= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)25);
  l_211= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)26);
  l_212= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)27);
  l_213= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)28);
  l_214= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)29);
  l_215= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)30);
  l_216= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)31);
  l_217= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)32);
  l_218= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)33);
  l_219= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)34);
  l_220= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)35);
  l_221= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_222= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_223= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_224= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_225= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_226= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_227= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_228= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_229= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_230= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_231= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_232= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_233= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_234= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_235= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_236= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_237= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_238= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_239= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_240= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_241= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_242= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_243= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_244= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_245= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_246= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_247= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_248= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_249= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_250= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_251= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_252= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_253= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_254= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_255= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_256= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_257= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_258= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_259= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_260= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_261= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_262= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_263= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_264= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_265= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_266= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_267= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_268= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_269= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_270= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_271= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_272= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_273= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_274= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_275= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_276= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_277= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_278= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_279= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_280= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_281= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_282= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_283= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_284= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_285= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_286= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_287= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_288= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_289= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_290= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_291= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_292= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_293= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_294= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_295= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_296= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_297= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_298= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_299= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_300= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_301= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_302= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_303= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_304= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_305= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_306= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_307= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_308= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_309= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_310= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_311= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_312= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_313= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_314= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_315= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_316= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_317= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_318= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_319= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_320= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_321= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_322= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_323= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_324= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_325= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_326= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_327= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_328= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_329= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_330= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_331= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_332= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_333= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_334= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_335= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_336= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_337= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_338= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_339= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_340= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_341= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_342= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_343= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_344= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_345= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_346= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_347= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_348= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_349= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_350= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_351= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_352= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_353= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_354= _bind(v_ImmutableArray, s__5fsize_value_)(v_ImmutableArray, (oop)256, (oop)_l_354);
  _method(v_Character, s_digitValue, (imp_t)Character__s_digitValue);
  l_355= _bind(v_Character, s__5fvalue_)(v_Character, (oop)9);
  _method(v_Character, s_tab, (imp_t)Character__s_tab);
  l_356= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  _method(v_Character, s_nl, (imp_t)Character__s_nl);
  l_357= _bind(v_Character, s__5fvalue_)(v_Character, (oop)12);
  _method(v_Character, s_ff, (imp_t)Character__s_ff);
  l_358= _bind(v_Character, s__5fvalue_)(v_Character, (oop)13);
  _method(v_Character, s_cr, (imp_t)Character__s_cr);
  l_359= _bind(v_Character, s__5fvalue_)(v_Character, (oop)32);
  _method(v_Character, s_space, (imp_t)Character__s_space);
  l_360= _bind(v_Character, s__5fvalue_)(v_Character, (oop)97);
  l_361= _bind(v_Character, s__5fvalue_)(v_Character, (oop)122);
  l_362= _bind(v_Character, s__5fvalue_)(v_Character, (oop)65);
  l_363= _bind(v_Character, s__5fvalue_)(v_Character, (oop)90);
  _method(v_Character, s_isLetter, (imp_t)Character__s_isLetter);
  l_364= _bind(v_Character, s__5fvalue_)(v_Character, (oop)48);
  l_365= _bind(v_Character, s__5fvalue_)(v_Character, (oop)57);
  _method(v_Character, s_isDigit, (imp_t)Character__s_isDigit);
  _method(v_Character, s_hash, (imp_t)Character__s_hash);
  _method(v_Character, s__3c, (imp_t)Character__s__3c);
  _method(v_Character, s__3d, (imp_t)Character__s__3d);
  _method(v_Character, s_asInteger, (imp_t)Character__s_asInteger);
  _method(v_Character, s_asString, (imp_t)Character__s_asString);
  l_366= _bind(v_Character, s__5fvalue_)(v_Character, (oop)36);
  l_367= _bind(v_Character, s__5fvalue_)(v_Character, (oop)32);
  l_368= _bind(v_Character, s__5fvalue_)(v_Character, (oop)92);
  l_369= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)64);
  l_370= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_371= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_372= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_373= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_374= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  _method(v_Character, s_printOn_, (imp_t)Character__s_printOn_);
  _method(v_Character, s_print, (imp_t)Character__s_print);
  l_375= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_376= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  l_377= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  _method(v_Integer, s_printDigitOn_, (imp_t)Integer__s_printDigitOn_);
  l_378= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_379= _bind(v_Character, s__5fvalue_)(v_Character, (oop)45);
  l_380= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  l_381= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  _method(v_Integer, s_printOn_, (imp_t)Integer__s_printOn_);
  l_382= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_383= _bind(v_Character, s__5fvalue_)(v_Character, (oop)43);
  l_384= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_385= _bind(v_Character, s__5fvalue_)(v_Character, (oop)45);
  l_386= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_387= _bind(v_Character, s__5fvalue_)(v_Character, (oop)114);
  l_388= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_389= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal radix in integer constant");
  l_390= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_391= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_392= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal digit in integer constant");
  _method(v_Integer, s_readFrom_base_, (imp_t)Integer__s_readFrom_base_);
  v_WordArray=_proto(v_ArrayedCollection);
  _method(v_WordArray, s__5fsizeof, (imp_t)WordArray__5fsizeof);
  _method(v_WordArray, s__5fdebugName, (imp_t)WordArray__5fdebugName);
  _method(v_WordArray, s_new_, (imp_t)WordArray__s_new_);
  _method(v_WordArray, s_wordAt_, (imp_t)WordArray__s_wordAt_);
  _method(v_WordArray, s_at_, (imp_t)WordArray__s_at_);
  _method(v_WordArray, s_wordAt_put_, (imp_t)WordArray__s_wordAt_put_);
  _method(v_WordArray, s_at_put_, (imp_t)WordArray__s_at_put_);
  l_393= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#{");
  l_394= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_395= _bind(v_Character, s__5fvalue_)(v_Character, (oop)125);
  _method(v_WordArray, s_printOn_, (imp_t)WordArray__s_printOn_);
  v_ImmutableWordArray=_proto(v_WordArray);
  _method(v_ImmutableWordArray, s__5fsizeof, (imp_t)ImmutableWordArray__5fsizeof);
  _method(v_ImmutableWordArray, s__5fdebugName, (imp_t)ImmutableWordArray__5fdebugName);
  _method(v_ImmutableWordArray, s_wordAt_put_, (imp_t)ImmutableWordArray__s_wordAt_put_);
  _method(v_ImmutableWordArray, s_at_put_, (imp_t)ImmutableWordArray__s_at_put_);
  _method(v_ImmutableWordArray, s_species, (imp_t)ImmutableWordArray__s_species);
  _method(v_Object, s_isByteArray, (imp_t)Object__s_isByteArray);
  _method(v_ByteArray, s_isByteArray, (imp_t)ByteArray__s_isByteArray);
  _method(v_ByteArray, s_new_, (imp_t)ByteArray__s_new_);
  _method(v_ByteArray, s_byteAt_, (imp_t)ByteArray__s_byteAt_);
  _method(v_ByteArray, s_at_, (imp_t)ByteArray__s_at_);
  l_396= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_397= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)255);
  _method(v_ByteArray, s_byteAt_put_, (imp_t)ByteArray__s_byteAt_put_);
  _method(v_ByteArray, s_at_put_, (imp_t)ByteArray__s_at_put_);
  l_398= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_399= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_ByteArray, s_replaceFrom_to_with_startingAt_, (imp_t)ByteArray__s_replaceFrom_to_with_startingAt_);
  l_400= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#[");
  l_401= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_402= _bind(v_Character, s__5fvalue_)(v_Character, (oop)93);
  _method(v_ByteArray, s_printOn_, (imp_t)ByteArray__s_printOn_);
  _method(v_ImmutableByteArray, s_byteAt_put_, (imp_t)ImmutableByteArray__s_byteAt_put_);
  _method(v_ImmutableByteArray, s_at_put_, (imp_t)ImmutableByteArray__s_at_put_);
  _method(v_ImmutableByteArray, s_species, (imp_t)ImmutableByteArray__s_species);
  _method(v_Object, s_isString, (imp_t)Object__s_isString);
  _method(v_String, s_isString, (imp_t)String__s_isString);
  _method(v_String, s_at_, (imp_t)String__s_at_);
  _method(v_String, s_at_put_, (imp_t)String__s_at_put_);
  _method(v_String, s_compare_, (imp_t)String__s_compare_);
  l_403= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_404= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)33554431);
  l_405= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)31);
  c_26= _bind(v_StaticBlock, s__5fentry__5farity_)(v_StaticBlock, b_26, 2);
  _method(v_String, s_hash, (imp_t)String__s_hash);
  l_406= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_String, s__3c, (imp_t)String__s__3c);
  l_407= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_String, s__3c_3d, (imp_t)String__s__3c_3d);
  l_408= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_String, s__3d, (imp_t)String__s__3d);
  l_409= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_String, s__3e_3d, (imp_t)String__s__3e_3d);
  l_410= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_String, s__3e, (imp_t)String__s__3e);
  l_411= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_412= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_String, s_beginsWith_, (imp_t)String__s_beginsWith_);
  _method(v_String, s__5fcString, (imp_t)String__s__5fcString);
  l_413= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_414= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_String, s_asByteArray, (imp_t)String__s_asByteArray);
  l_415= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  l_416= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  _method(v_String, s_printOn_, (imp_t)String__s_printOn_);
  _method(v_ImmutableString, s_at_put_, (imp_t)ImmutableString__s_at_put_);
  _method(v_ImmutableString, s_species, (imp_t)ImmutableString__s_species);
  l_417= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_418= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_419= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_420= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_421= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_422= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  _method(v_Integer, s_hex2, (imp_t)Integer__s_hex2);
  l_423= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_424= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_425= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)268435456);
  l_426= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_427= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_428= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16777216);
  l_429= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_430= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_431= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1048576);
  l_432= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_433= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  l_434= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)65536);
  l_435= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_436= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)4);
  l_437= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)4096);
  l_438= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_439= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)5);
  l_440= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)256);
  l_441= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_442= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)6);
  l_443= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_444= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_445= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)7);
  l_446= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  _method(v_Integer, s_hex8, (imp_t)Integer__s_hex8);
  l_447= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  l_448= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_449= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)64);
  l_450= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_451= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_452= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_453= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  l_454= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_455= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  _method(v_Integer, s_octal3, (imp_t)Integer__s_octal3);
  v_Set=_proto(v_Collection);
  _method(v_Set, s__5fsizeof, (imp_t)Set__5fsizeof);
  _method(v_Set, s__5fdebugName, (imp_t)Set__5fdebugName);
  l_456= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Set, s_new_, (imp_t)Set__s_new_);
  _method(v_Set, s_size, (imp_t)Set__s_size);
  l_457= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Sets cannot meaningfully contain nil as an element");
  _method(v_Set, s_add_, (imp_t)Set__s_add_);
  l_458= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_459= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"there is no free space in this set");
  _method(v_Set, s_findElementOrNil_, (imp_t)Set__s_findElementOrNil_);
  l_460= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_461= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_462= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_463= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  _method(v_Set, s_scanFor_, (imp_t)Set__s_scanFor_);
  l_464= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Set, s_atNewIndex_put_, (imp_t)Set__s_atNewIndex_put_);
  l_465= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_466= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)4);
  _method(v_Set, s_fullCheck, (imp_t)Set__s_fullCheck);
  l_467= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)3);
  l_468= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Set, s_growSize, (imp_t)Set__s_growSize);
  l_469= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Set, s_grow, (imp_t)Set__s_grow);
  l_470= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Set, s_noCheckAdd_, (imp_t)Set__s_noCheckAdd_);
  l_471= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Set, s_do_, (imp_t)Set__s_do_);
  l_472= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Set, s_like_, (imp_t)Set__s_like_);
  v_IdentitySet=_proto(v_Set);
  _method(v_IdentitySet, s__5fsizeof, (imp_t)IdentitySet__5fsizeof);
  _method(v_IdentitySet, s__5fdebugName, (imp_t)IdentitySet__5fdebugName);
  l_473= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_474= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_475= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_476= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  _method(v_IdentitySet, s_scanFor_, (imp_t)IdentitySet__s_scanFor_);
  v_Dictionary=_proto(v_Set);
  _method(v_Dictionary, s__5fsizeof, (imp_t)Dictionary__5fsizeof);
  _method(v_Dictionary, s__5fdebugName, (imp_t)Dictionary__5fdebugName);
  l_477= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Dictionary, s_noCheckAdd_, (imp_t)Dictionary__s_noCheckAdd_);
  _method(v_Dictionary, s_at_ifAbsent_, (imp_t)Dictionary__s_at_ifAbsent_);
  _method(v_Dictionary, s_at_, (imp_t)Dictionary__s_at_);
  _method(v_Dictionary, s_at_put_, (imp_t)Dictionary__s_at_put_);
  _method(v_Dictionary, s_includesKey_, (imp_t)Dictionary__s_includesKey_);
  _method(v_Dictionary, s_keys, (imp_t)Dictionary__s_keys);
  _method(v_Dictionary, s_associationsDo_, (imp_t)Dictionary__s_associationsDo_);
  _method(v_Dictionary, s_keysDo_, (imp_t)Dictionary__s_keysDo_);
  _method(v_Dictionary, s_do_, (imp_t)Dictionary__s_do_);
  _method(v_Dictionary, s_keysAndValuesDo_, (imp_t)Dictionary__s_keysAndValuesDo_);
  _method(v_Dictionary, s_keysAndSortedValuesDo_, (imp_t)Dictionary__s_keysAndSortedValuesDo_);
  l_478= _bind(v_Character, s__5fvalue_)(v_Character, (oop)40);
  l_480= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  l_481= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  l_479= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"->");
  _method(v_Dictionary, s_printElementsOn_, (imp_t)Dictionary__s_printElementsOn_);
  v_IdentityDictionary=_proto(v_Dictionary);
  _method(v_IdentityDictionary, s__5fsizeof, (imp_t)IdentityDictionary__5fsizeof);
  _method(v_IdentityDictionary, s__5fdebugName, (imp_t)IdentityDictionary__5fdebugName);
  l_482= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_483= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_484= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_485= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  _method(v_IdentityDictionary, s_scanFor_, (imp_t)IdentityDictionary__s_scanFor_);
  _method(v_IdentityDictionary, s_keys, (imp_t)IdentityDictionary__s_keys);
  v_Symbol=_proto(v_String);
  _method(v_Symbol, s__5fsizeof, (imp_t)Symbol__5fsizeof);
  _method(v_Symbol, s__5fdebugName, (imp_t)Symbol__5fdebugName);
  _method(v_Symbol, s_new_, (imp_t)Symbol__s_new_);
  l_486= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_487= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Symbol, s_string_, (imp_t)Symbol__s_string_);
  v_SymbolTable=_proto(v_Set);
  _method(v_SymbolTable, s__5fsizeof, (imp_t)SymbolTable__5fsizeof);
  _method(v_SymbolTable, s__5fdebugName, (imp_t)SymbolTable__5fdebugName);
  l_488= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1023);
  {
 {
  oop _1, _2;
  _1= v_SymbolTable;
  _2= l_488;
  _1= _bind(_1, s_new_)(_1, _2);
  v_SymbolTable= _1;
 }
  }
  _method(v_Symbol, s_intern_, (imp_t)Symbol__s_intern_);
  _method(v_Symbol, s__5fvalue_, (imp_t)Symbol__s__5fvalue_);
  _method(v_String, s_asSymbol, (imp_t)String__s_asSymbol);
  v_SelectorTable=_proto(v_IdentityDictionary);
  _method(v_SelectorTable, s__5fsizeof, (imp_t)SelectorTable__5fsizeof);
  _method(v_SelectorTable, s__5fdebugName, (imp_t)SelectorTable__5fdebugName);
  {
 {
  oop _1;
  _1= v_SelectorTable;
  _1= _bind(_1, s_new)(_1);
  v_SelectorTable= _1;
 }
  }
  _method(v_SelectorTable, s_intern_, (imp_t)SelectorTable__s_intern_);
  _method(v_Object, s__5fperform_, (imp_t)Object__s__5fperform_);
  _method(v_Object, s_perform_, (imp_t)Object__s_perform_);
  _method(v_Object, s__5fperform_with_, (imp_t)Object__s__5fperform_with_);
  _method(v_Object, s_perform_with_, (imp_t)Object__s_perform_with_);
  v_Stream=_proto(v_Object);
  _method(v_Stream, s__5fsizeof, (imp_t)Stream__5fsizeof);
  _method(v_Stream, s__5fdebugName, (imp_t)Stream__5fdebugName);
  _method(v_Stream, s_nextPutAll_, (imp_t)Stream__s_nextPutAll_);
  _method(v_Stream, s_nextPut_, (imp_t)Stream__s_nextPut_);
  _method(v_Stream, s_print_, (imp_t)Stream__s_print_);
  l_489= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Stream, s_isEmpty, (imp_t)Stream__s_isEmpty);
  _method(v_Stream, s_notEmpty, (imp_t)Stream__s_notEmpty);
  _method(v_Stream, s_contents, (imp_t)Stream__s_contents);
  v_PositionableStream=_proto(v_Stream);
  _method(v_PositionableStream, s__5fsizeof, (imp_t)PositionableStream__5fsizeof);
  _method(v_PositionableStream, s__5fdebugName, (imp_t)PositionableStream__5fdebugName);
  l_490= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_PositionableStream, s_on_, (imp_t)PositionableStream__s_on_);
  l_491= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_PositionableStream, s_reset, (imp_t)PositionableStream__s_reset);
  _method(v_PositionableStream, s_atEnd, (imp_t)PositionableStream__s_atEnd);
  l_492= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_PositionableStream, s_position_, (imp_t)PositionableStream__s_position_);
  _method(v_PositionableStream, s_skip_, (imp_t)PositionableStream__s_skip_);
  _method(v_PositionableStream, s_size, (imp_t)PositionableStream__s_size);
  l_493= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_PositionableStream, s_contents, (imp_t)PositionableStream__s_contents);
  _method(v_PositionableStream, s_collection, (imp_t)PositionableStream__s_collection);
  l_494= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_PositionableStream, s_peek, (imp_t)PositionableStream__s_peek);
  v_ReadStream=_proto(v_PositionableStream);
  _method(v_ReadStream, s__5fsizeof, (imp_t)ReadStream__5fsizeof);
  _method(v_ReadStream, s__5fdebugName, (imp_t)ReadStream__5fdebugName);
  l_495= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_ReadStream, s_next, (imp_t)ReadStream__s_next);
  _method(v_ReadStream, s_readStream, (imp_t)ReadStream__s_readStream);
  _method(v_SequenceableCollection, s_readStream, (imp_t)SequenceableCollection__s_readStream);
  v_WriteStream=_proto(v_PositionableStream);
  _method(v_WriteStream, s__5fsizeof, (imp_t)WriteStream__5fsizeof);
  _method(v_WriteStream, s__5fdebugName, (imp_t)WriteStream__5fdebugName);
  _method(v_WriteStream, s_reset, (imp_t)WriteStream__s_reset);
  l_496= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_WriteStream, s_resetToStart, (imp_t)WriteStream__s_resetToStart);
  l_497= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_498= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_WriteStream, s_on_, (imp_t)WriteStream__s_on_);
  l_499= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_500= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_WriteStream, s_nextPut_, (imp_t)WriteStream__s_nextPut_);
  l_501= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)20);
  l_502= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1000000);
  l_503= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_504= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_505= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_506= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_WriteStream, s_pastEndPut_, (imp_t)WriteStream__s_pastEndPut_);
  _method(v_WriteStream, s_size, (imp_t)WriteStream__s_size);
  l_507= _bind(v_Character, s__5fvalue_)(v_Character, (oop)9);
  _method(v_WriteStream, s_tab, (imp_t)WriteStream__s_tab);
  l_508= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  _method(v_WriteStream, s_nl, (imp_t)WriteStream__s_nl);
  l_509= _bind(v_Character, s__5fvalue_)(v_Character, (oop)13);
  _method(v_WriteStream, s_cr, (imp_t)WriteStream__s_cr);
  l_510= _bind(v_Character, s__5fvalue_)(v_Character, (oop)32);
  _method(v_WriteStream, s_space, (imp_t)WriteStream__s_space);
  _method(v_WriteStream, s_tab_, (imp_t)WriteStream__s_tab_);
  _method(v_WriteStream, s_nl_, (imp_t)WriteStream__s_nl_);
  _method(v_WriteStream, s_cr_, (imp_t)WriteStream__s_cr_);
  _method(v_WriteStream, s_space_, (imp_t)WriteStream__s_space_);
  _method(v_WriteStream, s_contents, (imp_t)WriteStream__s_contents);
  _method(v_WriteStream, s_position_, (imp_t)WriteStream__s_position_);
  _method(v_WriteStream, s_writeStream, (imp_t)WriteStream__s_writeStream);
  _method(v_SequenceableCollection, s_writeStream, (imp_t)SequenceableCollection__s_writeStream);
  _method(v_SequenceableCollection, s_firstToken_, (imp_t)SequenceableCollection__s_firstToken_);
  _method(v_SequenceableCollection, s_tokenised_, (imp_t)SequenceableCollection__s_tokenised_);
  l_511= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  _method(v_SequenceableCollection, s_delimited_, (imp_t)SequenceableCollection__s_delimited_);
  l_512= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_SequenceableCollection, s_flattened, (imp_t)SequenceableCollection__s_flattened);
  v_Smalltalk=_proto(v_Object);
  _method(v_Smalltalk, s__5fsizeof, (imp_t)Smalltalk__5fsizeof);
  _method(v_Smalltalk, s__5fdebugName, (imp_t)Smalltalk__5fdebugName);
  _method(v_Smalltalk, s_quit, (imp_t)Smalltalk__s_quit);
  _method(v_Smalltalk, s_abort, (imp_t)Smalltalk__s_abort);
  _method(v_Smalltalk, s_argumentCount, (imp_t)Smalltalk__s_argumentCount);
  _method(v_Smalltalk, s_argumentAt_, (imp_t)Smalltalk__s_argumentAt_);
  l_513= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_514= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Smalltalk, s_arguments, (imp_t)Smalltalk__s_arguments);
  _method(v_Smalltalk, s_osError, (imp_t)Smalltalk__s_osError);
  _method(v_Smalltalk, s__5fosErrorString_, (imp_t)Smalltalk__s__5fosErrorString_);
  _method(v_Smalltalk, s_osErrorString_, (imp_t)Smalltalk__s_osErrorString_);
  _method(v_Smalltalk, s_osErrorString, (imp_t)Smalltalk__s_osErrorString);
  _method(v_Smalltalk, s_garbageCollect, (imp_t)Smalltalk__s_garbageCollect);
  _method(v_Smalltalk, s_bytesFree, (imp_t)Smalltalk__s_bytesFree);
  v_GetOpt=_proto(v_IdentityDictionary);
  _method(v_GetOpt, s__5fsizeof, (imp_t)GetOpt__5fsizeof);
  _method(v_GetOpt, s__5fdebugName, (imp_t)GetOpt__5fdebugName);
  c_69= _bind(v_StaticBlock, s__5fentry__5farity_)(v_StaticBlock, b_69, 1);
  _method(v_GetOpt, s_new, (imp_t)GetOpt__s_new);
  _method(v_GetOpt, s_default_, (imp_t)GetOpt__s_default_);
  l_515= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_GetOpt, s_parse_, (imp_t)GetOpt__s_parse_);
  _method(v_GetOpt, s_parse_startingAt_, (imp_t)GetOpt__s_parse_startingAt_);
  l_516= _bind(v_Character, s__5fvalue_)(v_Character, (oop)45);
  l_517= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_GetOpt, s_parseArgument_with_, (imp_t)GetOpt__s_parseArgument_with_);
  l_519= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_518= _bind(v_Character, s__5fvalue_)(v_Character, (oop)63);
  _method(v_GetOpt, s_parseOption_with_, (imp_t)GetOpt__s_parseOption_with_);
  l_520= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_521= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"option ");
  l_522= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" should not have an argument");
  _method(v_GetOpt, s_applyOption_to_, (imp_t)GetOpt__s_applyOption_to_);
  l_523= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_524= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"argument missing to option ");
  l_525= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v_GetOpt, s_applyOption_to_with_, (imp_t)GetOpt__s_applyOption_to_with_);
  l_526= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/");
  l_527= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)".");
  l_528= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/");
  _method(v_String, s_directoryName, (imp_t)String__s_directoryName);
  l_529= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/");
  _method(v_String, s_baseName, (imp_t)String__s_baseName);
  _method(v_String, s_absolutePathName, (imp_t)String__s_absolutePathName);
  _method(v_String, s_isReadableFile, (imp_t)String__s_isReadableFile);
  _method(v_String, s_readFromFileNamed_ifError_, (imp_t)String__s_readFromFileNamed_ifError_);
  l_530= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)": ");
  _method(v_String, s_readFromFileNamed_, (imp_t)String__s_readFromFileNamed_);
  _method(v_String, s_writeToFileNamed_ifError_, (imp_t)String__s_writeToFileNamed_ifError_);
  l_531= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)": ");
  _method(v_String, s_writeToFileNamed_, (imp_t)String__s_writeToFileNamed_);
  v_CompilerOptions=_proto(v_Object);
  _method(v_CompilerOptions, s__5fsizeof, (imp_t)CompilerOptions__5fsizeof);
  _method(v_CompilerOptions, s__5fdebugName, (imp_t)CompilerOptions__5fdebugName);
  v_Scanner=_proto(v_Object);
  _method(v_Scanner, s__5fsizeof, (imp_t)Scanner__5fsizeof);
  _method(v_Scanner, s__5fdebugName, (imp_t)Scanner__5fdebugName);
  v_Parser=_proto(v_Scanner);
  _method(v_Parser, s__5fsizeof, (imp_t)Parser__5fsizeof);
  _method(v_Parser, s__5fdebugName, (imp_t)Parser__5fdebugName);
  v_Compiler=_proto(v_Parser);
  _method(v_Compiler, s__5fsizeof, (imp_t)Compiler__5fsizeof);
  _method(v_Compiler, s__5fdebugName, (imp_t)Compiler__5fdebugName);
  v_Scope=_proto(v_Object);
  _method(v_Scope, s__5fsizeof, (imp_t)Scope__5fsizeof);
  _method(v_Scope, s__5fdebugName, (imp_t)Scope__5fdebugName);
  v_TranslationUnit=_proto(v_Object);
  _method(v_TranslationUnit, s__5fsizeof, (imp_t)TranslationUnit__5fsizeof);
  _method(v_TranslationUnit, s__5fdebugName, (imp_t)TranslationUnit__5fdebugName);
  v_Variable=_proto(v_Object);
  _method(v_Variable, s__5fsizeof, (imp_t)Variable__5fsizeof);
  _method(v_Variable, s__5fdebugName, (imp_t)Variable__5fdebugName);
  v_NamedVariable=_proto(v_Variable);
  _method(v_NamedVariable, s__5fsizeof, (imp_t)NamedVariable__5fsizeof);
  _method(v_NamedVariable, s__5fdebugName, (imp_t)NamedVariable__5fdebugName);
  v_GlobalVariable=_proto(v_NamedVariable);
  _method(v_GlobalVariable, s__5fsizeof, (imp_t)GlobalVariable__5fsizeof);
  _method(v_GlobalVariable, s__5fdebugName, (imp_t)GlobalVariable__5fdebugName);
  v_SelfVariable=_proto(v_NamedVariable);
  _method(v_SelfVariable, s__5fsizeof, (imp_t)SelfVariable__5fsizeof);
  _method(v_SelfVariable, s__5fdebugName, (imp_t)SelfVariable__5fdebugName);
  v_ReceiverVariable=_proto(v_NamedVariable);
  _method(v_ReceiverVariable, s__5fsizeof, (imp_t)ReceiverVariable__5fsizeof);
  _method(v_ReceiverVariable, s__5fdebugName, (imp_t)ReceiverVariable__5fdebugName);
  v_LocalVariable=_proto(v_NamedVariable);
  _method(v_LocalVariable, s__5fsizeof, (imp_t)LocalVariable__5fsizeof);
  _method(v_LocalVariable, s__5fdebugName, (imp_t)LocalVariable__5fdebugName);
  v_RemoteReceiverVariable=_proto(v_Variable);
  _method(v_RemoteReceiverVariable, s__5fsizeof, (imp_t)RemoteReceiverVariable__5fsizeof);
  _method(v_RemoteReceiverVariable, s__5fdebugName, (imp_t)RemoteReceiverVariable__5fdebugName);
  v_RemoteVariable=_proto(v_Variable);
  _method(v_RemoteVariable, s__5fsizeof, (imp_t)RemoteVariable__5fsizeof);
  _method(v_RemoteVariable, s__5fdebugName, (imp_t)RemoteVariable__5fdebugName);
  v_ParseNode=_proto(v_Object);
  _method(v_ParseNode, s__5fsizeof, (imp_t)ParseNode__5fsizeof);
  _method(v_ParseNode, s__5fdebugName, (imp_t)ParseNode__5fdebugName);
  v_ValueNode=_proto(v_ParseNode);
  _method(v_ValueNode, s__5fsizeof, (imp_t)ValueNode__5fsizeof);
  _method(v_ValueNode, s__5fdebugName, (imp_t)ValueNode__5fdebugName);
  v_BlockReturnNode=_proto(v_ValueNode);
  _method(v_BlockReturnNode, s__5fsizeof, (imp_t)BlockReturnNode__5fsizeof);
  _method(v_BlockReturnNode, s__5fdebugName, (imp_t)BlockReturnNode__5fdebugName);
  v_ReturnNode=_proto(v_BlockReturnNode);
  _method(v_ReturnNode, s__5fsizeof, (imp_t)ReturnNode__5fsizeof);
  _method(v_ReturnNode, s__5fdebugName, (imp_t)ReturnNode__5fdebugName);
  v_LiteralNode=_proto(v_ValueNode);
  _method(v_LiteralNode, s__5fsizeof, (imp_t)LiteralNode__5fsizeof);
  _method(v_LiteralNode, s__5fdebugName, (imp_t)LiteralNode__5fdebugName);
  v_SymbolNode=_proto(v_LiteralNode);
  _method(v_SymbolNode, s__5fsizeof, (imp_t)SymbolNode__5fsizeof);
  _method(v_SymbolNode, s__5fdebugName, (imp_t)SymbolNode__5fdebugName);
  v_StringNode=_proto(v_LiteralNode);
  _method(v_StringNode, s__5fsizeof, (imp_t)StringNode__5fsizeof);
  _method(v_StringNode, s__5fdebugName, (imp_t)StringNode__5fdebugName);
  v_IntegerNode=_proto(v_LiteralNode);
  _method(v_IntegerNode, s__5fsizeof, (imp_t)IntegerNode__5fsizeof);
  _method(v_IntegerNode, s__5fdebugName, (imp_t)IntegerNode__5fdebugName);
  v_CharacterNode=_proto(v_LiteralNode);
  _method(v_CharacterNode, s__5fsizeof, (imp_t)CharacterNode__5fsizeof);
  _method(v_CharacterNode, s__5fdebugName, (imp_t)CharacterNode__5fdebugName);
  v_ArrayNode=_proto(v_LiteralNode);
  _method(v_ArrayNode, s__5fsizeof, (imp_t)ArrayNode__5fsizeof);
  _method(v_ArrayNode, s__5fdebugName, (imp_t)ArrayNode__5fdebugName);
  v_WordArrayNode=_proto(v_LiteralNode);
  _method(v_WordArrayNode, s__5fsizeof, (imp_t)WordArrayNode__5fsizeof);
  _method(v_WordArrayNode, s__5fdebugName, (imp_t)WordArrayNode__5fdebugName);
  v_ByteArrayNode=_proto(v_LiteralNode);
  _method(v_ByteArrayNode, s__5fsizeof, (imp_t)ByteArrayNode__5fsizeof);
  _method(v_ByteArrayNode, s__5fdebugName, (imp_t)ByteArrayNode__5fdebugName);
  v_VariableNode=_proto(v_ParseNode);
  _method(v_VariableNode, s__5fsizeof, (imp_t)VariableNode__5fsizeof);
  _method(v_VariableNode, s__5fdebugName, (imp_t)VariableNode__5fdebugName);
  v_AssignmentNode=_proto(v_ParseNode);
  _method(v_AssignmentNode, s__5fsizeof, (imp_t)AssignmentNode__5fsizeof);
  _method(v_AssignmentNode, s__5fdebugName, (imp_t)AssignmentNode__5fdebugName);
  v_SendNode=_proto(v_ParseNode);
  _method(v_SendNode, s__5fsizeof, (imp_t)SendNode__5fsizeof);
  _method(v_SendNode, s__5fdebugName, (imp_t)SendNode__5fdebugName);
  v_TemplateNode=_proto(v_ParseNode);
  _method(v_TemplateNode, s__5fsizeof, (imp_t)TemplateNode__5fsizeof);
  _method(v_TemplateNode, s__5fdebugName, (imp_t)TemplateNode__5fdebugName);
  v_PrimitiveNode=_proto(v_ParseNode);
  _method(v_PrimitiveNode, s__5fsizeof, (imp_t)PrimitiveNode__5fsizeof);
  _method(v_PrimitiveNode, s__5fdebugName, (imp_t)PrimitiveNode__5fdebugName);
  v_ExternDeclarationNode=_proto(v_ParseNode);
  _method(v_ExternDeclarationNode, s__5fsizeof, (imp_t)ExternDeclarationNode__5fsizeof);
  _method(v_ExternDeclarationNode, s__5fdebugName, (imp_t)ExternDeclarationNode__5fdebugName);
  v_IncludeNode=_proto(v_ParseNode);
  _method(v_IncludeNode, s__5fsizeof, (imp_t)IncludeNode__5fsizeof);
  _method(v_IncludeNode, s__5fdebugName, (imp_t)IncludeNode__5fdebugName);
  v_ImportNode=_proto(v_ParseNode);
  _method(v_ImportNode, s__5fsizeof, (imp_t)ImportNode__5fsizeof);
  _method(v_ImportNode, s__5fdebugName, (imp_t)ImportNode__5fdebugName);
  v_ExportNode=_proto(v_ParseNode);
  _method(v_ExportNode, s__5fsizeof, (imp_t)ExportNode__5fsizeof);
  _method(v_ExportNode, s__5fdebugName, (imp_t)ExportNode__5fdebugName);
  v_RequireNode=_proto(v_ParseNode);
  _method(v_RequireNode, s__5fsizeof, (imp_t)RequireNode__5fsizeof);
  _method(v_RequireNode, s__5fdebugName, (imp_t)RequireNode__5fdebugName);
  v_ClassNode=_proto(v_ParseNode);
  _method(v_ClassNode, s__5fsizeof, (imp_t)ClassNode__5fsizeof);
  _method(v_ClassNode, s__5fdebugName, (imp_t)ClassNode__5fdebugName);
  v_ExternalClassNode=_proto(v_ParseNode);
  _method(v_ExternalClassNode, s__5fsizeof, (imp_t)ExternalClassNode__5fsizeof);
  _method(v_ExternalClassNode, s__5fdebugName, (imp_t)ExternalClassNode__5fdebugName);
  v_SequenceNode=_proto(v_ParseNode);
  _method(v_SequenceNode, s__5fsizeof, (imp_t)SequenceNode__5fsizeof);
  _method(v_SequenceNode, s__5fdebugName, (imp_t)SequenceNode__5fdebugName);
  v_BlockNode=_proto(v_SequenceNode);
  _method(v_BlockNode, s__5fsizeof, (imp_t)BlockNode__5fsizeof);
  _method(v_BlockNode, s__5fdebugName, (imp_t)BlockNode__5fdebugName);
  v_MethodNode=_proto(v_BlockNode);
  _method(v_MethodNode, s__5fsizeof, (imp_t)MethodNode__5fsizeof);
  _method(v_MethodNode, s__5fdebugName, (imp_t)MethodNode__5fdebugName);
  v_ExecNode=_proto(v_SequenceNode);
  _method(v_ExecNode, s__5fsizeof, (imp_t)ExecNode__5fsizeof);
  _method(v_ExecNode, s__5fdebugName, (imp_t)ExecNode__5fdebugName);
  l_532= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is not yet implemented ");
  _method(v_Object, s_notImplemented_, (imp_t)Object__s_notImplemented_);
  _method(v_ParseNode, s_location, (imp_t)ParseNode__s_location);
  _method(v_ParseNode, s_isOpenBlock, (imp_t)ParseNode__s_isOpenBlock);
  _method(v_ParseNode, s_forTopLevel_, (imp_t)ParseNode__s_forTopLevel_);
  l_533= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  gobble ");
  _method(v_ParseNode, s_forGobble_, (imp_t)ParseNode__s_forGobble_);
  l_534= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"encodeIn:");
  _method(v_ParseNode, s_encodeIn_, (imp_t)ParseNode__s_encodeIn_);
  l_535= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"encode:");
  _method(v_ParseNode, s_encode_, (imp_t)ParseNode__s_encode_);
  l_536= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"gen:");
  _method(v_ParseNode, s_gen_, (imp_t)ParseNode__s_gen_);
  _method(v_ParseNode, s_printOn_indent_, (imp_t)ParseNode__s_printOn_indent_);
  _method(v_ValueNode, s_withValue_, (imp_t)ValueNode__s_withValue_);
  _method(v_ValueNode, s_value, (imp_t)ValueNode__s_value);
  _method(v_ValueNode, s_encode_, (imp_t)ValueNode__s_encode_);
  _method(v_Object, s_isReturnNode, (imp_t)Object__s_isReturnNode);
  _method(v_BlockReturnNode, s_isReturnNode, (imp_t)BlockReturnNode__s_isReturnNode);
  l_537= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  return _");
  l_538= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_BlockReturnNode, s_gen_, (imp_t)BlockReturnNode__s_gen_);
  l_539= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_ReturnNode, s_initialise, (imp_t)ReturnNode__s_initialise);
  l_540= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_541= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_ReturnNode, s_encode_, (imp_t)ReturnNode__s_encode_);
  l_542= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_543= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  return _nlReturn(_self, ((struct t_BlockClosureNLR *)");
  l_544= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_546= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_self)");
  l_547= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_549= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"->_envp, _");
  l_550= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_545= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct t_BlockClosure *)");
  l_548= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"->outer)");
  _method(v_ReturnNode, s_gen_, (imp_t)ReturnNode__s_gen_);
  l_551= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_552= _bind(v_Character, s__5fvalue_)(v_Character, (oop)94);
  l_553= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_ReturnNode, s_printOn_indent_, (imp_t)ReturnNode__s_printOn_indent_);
  v_LiteralNodeTag=_proto(v_Object);
  _method(v_LiteralNodeTag, s__5fsizeof, (imp_t)LiteralNodeTag__5fsizeof);
  _method(v_LiteralNodeTag, s__5fdebugName, (imp_t)LiteralNodeTag__5fdebugName);
  l_554= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  {
 {
  oop _1;
  _1= l_554;
  v_LiteralNodeTag= _1;
 }
  }
  l_555= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_LiteralNode, s_initialise, (imp_t)LiteralNode__s_initialise);
  _method(v_LiteralNode, s_tag, (imp_t)LiteralNode__s_tag);
  _method(v_LiteralNode, s_encode_, (imp_t)LiteralNode__s_encode_);
  l_556= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop l_");
  l_557= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_LiteralNode, s_genDefinition_, (imp_t)LiteralNode__s_genDefinition_);
  l_558= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_559= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= l_");
  l_560= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_LiteralNode, s_gen_, (imp_t)LiteralNode__s_gen_);
  _method(v_SymbolNode, s_fromString_, (imp_t)SymbolNode__s_fromString_);
  l_561= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Symbol");
  _method(v_SymbolNode, s_literalClass, (imp_t)SymbolNode__s_literalClass);
  l_562= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_value:");
  _method(v_SymbolNode, s_literalSelector, (imp_t)SymbolNode__s_literalSelector);
  l_563= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_564= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)\"");
  l_565= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_SymbolNode, s_genInitialisation_, (imp_t)SymbolNode__s_genInitialisation_);
  _method(v_StringNode, s_fromString_, (imp_t)StringNode__s_fromString_);
  l_566= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ImmutableString");
  _method(v_StringNode, s_literalClass, (imp_t)StringNode__s_literalClass);
  l_567= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_value:");
  _method(v_StringNode, s_literalSelector, (imp_t)StringNode__s_literalSelector);
  l_568= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_569= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)\"");
  l_576= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  l_570= _bind(v_Character, s__5fvalue_)(v_Character, (oop)34);
  l_571= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\134\"");
  l_572= _bind(v_Character, s__5fvalue_)(v_Character, (oop)32);
  l_573= _bind(v_Character, s__5fvalue_)(v_Character, (oop)92);
  l_574= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)126);
  l_575= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\134");
  _method(v_StringNode, s_genInitialisation_, (imp_t)StringNode__s_genInitialisation_);
  l_577= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  _method(v_StringNode, s_printOn_indent_, (imp_t)StringNode__s_printOn_indent_);
  l_578= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"0x");
  l_579= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)16);
  l_580= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_581= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)10);
  _method(v_IntegerNode, s_fromString_, (imp_t)IntegerNode__s_fromString_);
  l_582= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SmallInteger");
  _method(v_IntegerNode, s_literalClass, (imp_t)IntegerNode__s_literalClass);
  l_583= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_value:");
  _method(v_IntegerNode, s_literalSelector, (imp_t)IntegerNode__s_literalSelector);
  l_584= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_585= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)");
  l_586= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_IntegerNode, s_genInitialisation_, (imp_t)IntegerNode__s_genInitialisation_);
  l_587= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_588= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)255);
  l_589= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ByteArray element out of range: ");
  l_590= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\134");
  _method(v_IntegerNode, s_genByte_, (imp_t)IntegerNode__s_genByte_);
  _method(v_IntegerNode, s_genWord_, (imp_t)IntegerNode__s_genWord_);
  l_591= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Character");
  _method(v_CharacterNode, s_literalClass, (imp_t)CharacterNode__s_literalClass);
  l_592= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_value:");
  _method(v_CharacterNode, s_literalSelector, (imp_t)CharacterNode__s_literalSelector);
  l_593= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_594= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_Character, s__5fvalue_)(v_Character, (oop)");
  l_595= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_CharacterNode, s_genInitialisation_, (imp_t)CharacterNode__s_genInitialisation_);
  _method(v_ArrayNode, s_withElements_, (imp_t)ArrayNode__s_withElements_);
  l_596= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ImmutableArray");
  _method(v_ArrayNode, s_literalClass, (imp_t)ArrayNode__s_literalClass);
  l_597= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_size:value:");
  _method(v_ArrayNode, s_literalSelector, (imp_t)ArrayNode__s_literalSelector);
  l_598= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop *_l_");
  l_599= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"[");
  l_600= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]= {");
  l_603= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"};");
  l_601= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  &l_");
  l_602= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)",");
  _method(v_ArrayNode, s_genDefinition_, (imp_t)ArrayNode__s_genDefinition_);
  l_604= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_605= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_ImmutableArray, s__5fsize_value_)(v_ImmutableArray, (oop)");
  l_606= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", (oop)_l_");
  l_607= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_ArrayNode, s_genInitialisation_, (imp_t)ArrayNode__s_genInitialisation_);
  l_608= _bind(v_Character, s__5fvalue_)(v_Character, (oop)40);
  l_609= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_ArrayNode, s_printOn_, (imp_t)ArrayNode__s_printOn_);
  l_610= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ImmutableByteArray");
  _method(v_ByteArrayNode, s_literalClass, (imp_t)ByteArrayNode__s_literalClass);
  l_611= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_size:value:");
  _method(v_ByteArrayNode, s_literalSelector, (imp_t)ByteArrayNode__s_literalSelector);
  _method(v_ByteArrayNode, s_withElements_, (imp_t)ByteArrayNode__s_withElements_);
  l_612= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_613= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_ImmutableByteArray, s__5fsize_value_)(v_ImmutableByteArray, (oop)");
  l_614= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", (oop)\"");
  l_615= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_ByteArrayNode, s_genInitialisation_, (imp_t)ByteArrayNode__s_genInitialisation_);
  l_616= _bind(v_Character, s__5fvalue_)(v_Character, (oop)91);
  l_617= _bind(v_Character, s__5fvalue_)(v_Character, (oop)93);
  _method(v_ByteArrayNode, s_printOn_, (imp_t)ByteArrayNode__s_printOn_);
  l_618= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ImmutableWordArray");
  _method(v_WordArrayNode, s_literalClass, (imp_t)WordArrayNode__s_literalClass);
  l_619= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_size:value:");
  _method(v_WordArrayNode, s_literalSelector, (imp_t)WordArrayNode__s_literalSelector);
  _method(v_WordArrayNode, s_withElements_, (imp_t)WordArrayNode__s_withElements_);
  l_620= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"unsigned long _l_");
  l_621= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"[");
  l_622= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]= {");
  l_625= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"};");
  l_623= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_624= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)",");
  _method(v_WordArrayNode, s_genDefinition_, (imp_t)WordArrayNode__s_genDefinition_);
  l_626= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  l_");
  l_627= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_WordArray, s__5fsize_value_)(v_WordArray, (oop)");
  l_628= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", (oop)_l_");
  l_629= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_WordArrayNode, s_genInitialisation_, (imp_t)WordArrayNode__s_genInitialisation_);
  l_630= _bind(v_Character, s__5fvalue_)(v_Character, (oop)123);
  l_631= _bind(v_Character, s__5fvalue_)(v_Character, (oop)125);
  _method(v_WordArrayNode, s_printOn_, (imp_t)WordArrayNode__s_printOn_);
  _method(v_Object, s_isVariableNode, (imp_t)Object__s_isVariableNode);
  _method(v_VariableNode, s_isVariableNode, (imp_t)VariableNode__s_isVariableNode);
  _method(v_VariableNode, s_withName_, (imp_t)VariableNode__s_withName_);
  _method(v_VariableNode, s_name, (imp_t)VariableNode__s_name);
  l_633= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_632= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"super");
  _method(v_VariableNode, s_beSelf, (imp_t)VariableNode__s_beSelf);
  _method(v_VariableNode, s_encodeLvalue_, (imp_t)VariableNode__s_encodeLvalue_);
  _method(v_VariableNode, s_encode_, (imp_t)VariableNode__s_encode_);
  _method(v_VariableNode, s_genLvalue_, (imp_t)VariableNode__s_genLvalue_);
  l_634= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_635= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ");
  l_636= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_VariableNode, s_gen_, (imp_t)VariableNode__s_gen_);
  l_637= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_638= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"VAR(");
  l_639= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_VariableNode, s_printOn_indent_, (imp_t)VariableNode__s_printOn_indent_);
  _method(v_AssignmentNode, s_withVariable_value_, (imp_t)AssignmentNode__s_withVariable_value_);
  _method(v_AssignmentNode, s_encode_, (imp_t)AssignmentNode__s_encode_);
  l_640= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_641= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_642= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_AssignmentNode, s_gen_, (imp_t)AssignmentNode__s_gen_);
  l_643= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_644= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" :=");
  l_645= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_AssignmentNode, s_printOn_indent_, (imp_t)AssignmentNode__s_printOn_indent_);
  _method(v_Object, s_isPrimitiveNode, (imp_t)Object__s_isPrimitiveNode);
  _method(v_PrimitiveNode, s_isPrimitiveNode, (imp_t)PrimitiveNode__s_isPrimitiveNode);
  _method(v_PrimitiveNode, s_withCode_, (imp_t)PrimitiveNode__s_withCode_);
  _method(v_PrimitiveNode, s_forTopLevel_, (imp_t)PrimitiveNode__s_forTopLevel_);
  _method(v_PrimitiveNode, s_encode_, (imp_t)PrimitiveNode__s_encode_);
  l_646= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_647= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ; _");
  l_648= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_PrimitiveNode, s_gen_, (imp_t)PrimitiveNode__s_gen_);
  l_649= _bind(v_Character, s__5fvalue_)(v_Character, (oop)123);
  l_650= _bind(v_Character, s__5fvalue_)(v_Character, (oop)125);
  _method(v_PrimitiveNode, s_printOn_, (imp_t)PrimitiveNode__s_printOn_);
  _method(v_Object, s_isExternDeclarationNode, (imp_t)Object__s_isExternDeclarationNode);
  _method(v_ExternDeclarationNode, s_isExternDeclatationNode, (imp_t)ExternDeclarationNode__s_isExternDeclatationNode);
  _method(v_ExternDeclarationNode, s_withNames_, (imp_t)ExternDeclarationNode__s_withNames_);
  l_651= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{ extern ");
  l_652= _bind(v_Character, s__5fvalue_)(v_Character, (oop)125);
  _method(v_ExternDeclarationNode, s_printOn_, (imp_t)ExternDeclarationNode__s_printOn_);
  _method(v_Object, s_isSendNode, (imp_t)Object__s_isSendNode);
  _method(v_SendNode, s_isSendNode, (imp_t)SendNode__s_isSendNode);
  _method(v_SendNode, s_withReceiver_selector_, (imp_t)SendNode__s_withReceiver_selector_);
  _method(v_SendNode, s_cascade, (imp_t)SendNode__s_cascade);
  _method(v_SendNode, s_addKeyword_, (imp_t)SendNode__s_addKeyword_);
  _method(v_SendNode, s_addArgument_, (imp_t)SendNode__s_addArgument_);
  _method(v_SendNode, s_addCascade_, (imp_t)SendNode__s_addCascade_);
  _method(v_SendNode, s_supered_, (imp_t)SendNode__s_supered_);
  v_MacroEncoders=_proto(v_Dictionary);
  _method(v_MacroEncoders, s__5fsizeof, (imp_t)MacroEncoders__5fsizeof);
  _method(v_MacroEncoders, s__5fdebugName, (imp_t)MacroEncoders__5fdebugName);
  l_653= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"+");
  l_654= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeAdd:");
  l_655= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"-");
  l_656= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeSub:");
  l_657= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"*");
  l_658= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeMul:");
  l_659= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"//");
  l_660= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeDiv:");
  l_661= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"\\\\");
  l_662= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeMod:");
  l_663= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"<");
  l_664= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeLT:");
  l_665= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"<=");
  l_666= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeLE:");
  l_667= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"=");
  l_668= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeEQ:");
  l_669= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"==");
  l_670= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeID:");
  l_671= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"~~");
  l_672= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeNI:");
  l_673= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"~=");
  l_674= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeNE:");
  l_675= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)">=");
  l_676= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeGE:");
  l_677= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)">");
  l_678= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeGT:");
  l_679= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"bitAnd:");
  l_680= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeBitAnd:");
  l_681= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"bitOr:");
  l_682= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeBitOr:");
  l_683= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"bitXor:");
  l_684= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeBitXor:");
  l_685= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"value");
  l_686= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeValue:");
  l_687= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"and:");
  l_688= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeAnd:");
  l_689= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"or:");
  l_690= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeOr:");
  l_691= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ifTrue:");
  l_692= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeIfTrue:");
  l_693= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ifTrue:ifFalse:");
  l_694= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeIfTrueIfFalse:");
  l_695= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ifFalse:");
  l_696= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeIfFalse:");
  l_697= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ifFalse:ifTrue:");
  l_698= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeIfFalseIfTrue:");
  l_699= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"whileTrue");
  l_700= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeWhileTrue:");
  l_701= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"whileTrue:");
  l_702= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeWhileTrueArg:");
  l_703= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"whileFalse");
  l_704= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeWhileFalse:");
  l_705= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"whileFalse:");
  l_706= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"encodeWhileFalseArg:");
  {
 {
  oop _1, _2, _3;
  _1= v_MacroEncoders;
  _1= _bind(_1, s_new)(_1);
  v_MacroEncoders= _1;
  _2= l_653;
  _3= l_654;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_655;
  _3= l_656;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_657;
  _3= l_658;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_659;
  _3= l_660;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_661;
  _3= l_662;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_663;
  _3= l_664;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_665;
  _3= l_666;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_667;
  _3= l_668;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_669;
  _3= l_670;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_671;
  _3= l_672;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_673;
  _3= l_674;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_675;
  _3= l_676;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_677;
  _3= l_678;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_679;
  _3= l_680;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_681;
  _3= l_682;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_683;
  _3= l_684;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_685;
  _3= l_686;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_687;
  _3= l_688;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_689;
  _3= l_690;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_691;
  _3= l_692;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_693;
  _3= l_694;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_695;
  _3= l_696;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_697;
  _3= l_698;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_699;
  _3= l_700;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_701;
  _3= l_702;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_703;
  _3= l_704;
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_705;
  _3= l_706;
  _1= _bind(_1, s_at_put_)(_1, _2, _3);
 }
  }
  _method(v_SendNode, s_encodeBinary_, (imp_t)SendNode__s_encodeBinary_);
  l_707= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genAdd:");
  _method(v_SendNode, s_encodeAdd_, (imp_t)SendNode__s_encodeAdd_);
  l_708= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genSub:");
  _method(v_SendNode, s_encodeSub_, (imp_t)SendNode__s_encodeSub_);
  l_709= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genMul:");
  _method(v_SendNode, s_encodeMul_, (imp_t)SendNode__s_encodeMul_);
  l_710= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genDiv:");
  _method(v_SendNode, s_encodeDiv_, (imp_t)SendNode__s_encodeDiv_);
  l_711= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genMod:");
  _method(v_SendNode, s_encodeMod_, (imp_t)SendNode__s_encodeMod_);
  l_712= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genBitAnd:");
  _method(v_SendNode, s_encodeBitAnd_, (imp_t)SendNode__s_encodeBitAnd_);
  l_713= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genBitOr:");
  _method(v_SendNode, s_encodeBitOr_, (imp_t)SendNode__s_encodeBitOr_);
  l_714= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genBitXor:");
  _method(v_SendNode, s_encodeBitXor_, (imp_t)SendNode__s_encodeBitXor_);
  l_715= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genLT:");
  _method(v_SendNode, s_encodeLT_, (imp_t)SendNode__s_encodeLT_);
  l_716= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genLE:");
  _method(v_SendNode, s_encodeLE_, (imp_t)SendNode__s_encodeLE_);
  l_717= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genEQ:");
  _method(v_SendNode, s_encodeEQ_, (imp_t)SendNode__s_encodeEQ_);
  l_718= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genID:");
  _method(v_SendNode, s_encodeID_, (imp_t)SendNode__s_encodeID_);
  l_719= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genNI:");
  _method(v_SendNode, s_encodeNI_, (imp_t)SendNode__s_encodeNI_);
  l_720= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genNE:");
  _method(v_SendNode, s_encodeNE_, (imp_t)SendNode__s_encodeNE_);
  l_721= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genGE:");
  _method(v_SendNode, s_encodeGE_, (imp_t)SendNode__s_encodeGE_);
  l_722= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genGT:");
  _method(v_SendNode, s_encodeGT_, (imp_t)SendNode__s_encodeGT_);
  l_723= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genValue");
  _method(v_SendNode, s_encodeValue_, (imp_t)SendNode__s_encodeValue_);
  l_724= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"WARNING: sending ");
  l_725= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" to a literal block is probably not what you intended");
  _method(v_SendNode, s_warnBlockReceiver, (imp_t)SendNode__s_warnBlockReceiver);
  l_726= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genAnd:");
  _method(v_SendNode, s_encodeAnd_, (imp_t)SendNode__s_encodeAnd_);
  l_727= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genOr:");
  _method(v_SendNode, s_encodeOr_, (imp_t)SendNode__s_encodeOr_);
  l_728= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genIfTrue:");
  _method(v_SendNode, s_encodeIfTrue_, (imp_t)SendNode__s_encodeIfTrue_);
  l_729= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genIfFalse:");
  _method(v_SendNode, s_encodeIfFalse_, (imp_t)SendNode__s_encodeIfFalse_);
  l_730= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genIfTrueIfFalse:");
  _method(v_SendNode, s_encodeIfTrueIfFalse_, (imp_t)SendNode__s_encodeIfTrueIfFalse_);
  l_731= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SendNode cowardly refusing to encode #ifFalse:ifTrue:");
  _method(v_SendNode, s_encodeIfFalseIfTrue_, (imp_t)SendNode__s_encodeIfFalseIfTrue_);
  l_732= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genWhileTrue:");
  _method(v_SendNode, s_encodeWhileTrue_, (imp_t)SendNode__s_encodeWhileTrue_);
  l_733= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genWhileTrueArg:");
  _method(v_SendNode, s_encodeWhileTrueArg_, (imp_t)SendNode__s_encodeWhileTrueArg_);
  l_734= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genWhileFalse:");
  _method(v_SendNode, s_encodeWhileFalse_, (imp_t)SendNode__s_encodeWhileFalse_);
  l_735= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"genWhileFalseArg:");
  _method(v_SendNode, s_encodeWhileFalseArg_, (imp_t)SendNode__s_encodeWhileFalseArg_);
  _method(v_SendNode, s_encodeMacro_, (imp_t)SendNode__s_encodeMacro_);
  _method(v_SendNode, s_encodeCascade_location_, (imp_t)SendNode__s_encodeCascade_location_);
  l_736= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"super");
  l_737= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"cannot send to super at root of hierarchy");
  _method(v_SendNode, s_encode_, (imp_t)SendNode__s_encode_);
  l_738= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_739= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_740= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_741= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_742= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (oop)((long)_");
  l_743= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" + (long)_");
  l_744= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" - 1);");
  l_745= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_746= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_747= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_748= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_749= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_750= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_751= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_752= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genAdd_, (imp_t)SendNode__s_genAdd_);
  l_753= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_754= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_755= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_756= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_757= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (oop)((long)_");
  l_758= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" - (long)_");
  l_759= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" + 1);");
  l_760= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_761= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_762= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_763= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_764= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_765= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_766= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_767= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genSub_, (imp_t)SendNode__s_genSub_);
  l_768= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_769= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_770= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_771= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_772= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _integerObject(_integerValue(_");
  l_773= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") * _integerValue(_");
  l_774= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"));");
  l_775= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_776= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_777= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_778= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_779= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_780= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_781= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_782= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genMul_, (imp_t)SendNode__s_genMul_);
  l_783= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_784= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_785= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_786= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_787= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _integerObject(_integerValue(_");
  l_788= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") / _integerValue(_");
  l_789= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"));");
  l_790= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_791= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_792= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_793= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_794= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_795= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_796= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_797= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genDiv_, (imp_t)SendNode__s_genDiv_);
  l_798= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_799= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_800= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_801= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_802= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _integerObject(_integerValue(_");
  l_803= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") % _integerValue(_");
  l_804= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"));");
  l_805= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_806= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_807= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_808= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_809= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_810= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_811= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_812= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genMod_, (imp_t)SendNode__s_genMod_);
  l_813= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_814= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_815= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_816= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_817= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (oop)(((long)_");
  l_818= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" & (long)_");
  l_819= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") | 1);");
  l_820= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_821= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_822= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_823= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_824= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_825= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_826= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_827= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genBitAnd_, (imp_t)SendNode__s_genBitAnd_);
  l_828= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_829= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_830= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_831= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_832= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (oop)((long)_");
  l_833= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" | (long)_");
  l_834= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_835= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_836= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_837= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_838= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_839= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_840= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_841= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_842= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genBitOr_, (imp_t)SendNode__s_genBitOr_);
  l_843= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_844= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_845= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_846= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_847= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (oop)(((long)_");
  l_848= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ^ (long)_");
  l_849= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") | 1);");
  l_850= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_851= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_852= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_853= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_854= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_855= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_856= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_857= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genBitXor_, (imp_t)SendNode__s_genBitXor_);
  l_858= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_859= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_860= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_861= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_862= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_863= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" < (long)_");
  l_864= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_865= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_866= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_867= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_868= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_869= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_870= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_871= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_872= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_873= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genLT_, (imp_t)SendNode__s_genLT_);
  l_874= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_875= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_876= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_877= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_878= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_879= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" <= (long)_");
  l_880= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_881= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_882= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_883= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_884= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_885= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_886= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_887= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_888= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_889= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genLE_, (imp_t)SendNode__s_genLE_);
  l_890= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_891= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_892= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_893= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_894= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_895= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" == (long)_");
  l_896= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_897= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_898= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_899= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_900= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_901= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_902= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_903= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_904= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_905= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genEQ_, (imp_t)SendNode__s_genEQ_);
  l_906= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_907= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (_");
  l_908= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" == _");
  l_909= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_910= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  _method(v_SendNode, s_genID_, (imp_t)SendNode__s_genID_);
  l_911= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_912= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= (_");
  l_913= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" != _");
  l_914= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_915= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  _method(v_SendNode, s_genNI_, (imp_t)SendNode__s_genNI_);
  l_916= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_917= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_918= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_919= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_920= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_921= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" != (long)_");
  l_922= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_923= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_924= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_925= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_926= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_927= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_928= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_929= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_930= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_931= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genNE_, (imp_t)SendNode__s_genNE_);
  l_932= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_933= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_934= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_935= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_936= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_937= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" >= (long)_");
  l_938= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_939= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_940= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_941= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_942= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_943= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_944= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_945= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_946= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_947= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genGE_, (imp_t)SendNode__s_genGE_);
  l_948= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_areIntegerObjects(_");
  l_949= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_950= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"))");
  l_951= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_952= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ((long)_");
  l_953= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" > (long)_");
  l_954= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_955= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ? v_true : v_false;");
  l_956= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  else");
  l_957= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"    _");
  l_958= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(_");
  l_959= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_960= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_961= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(_");
  l_962= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  l_963= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genGT_, (imp_t)SendNode__s_genGT_);
  l_964= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_");
  l_965= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") {");
  l_966= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_967= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_968= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_969= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  }");
  _method(v_SendNode, s_genAnd_, (imp_t)SendNode__s_genAnd_);
  l_970= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (!_");
  l_971= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") {");
  l_972= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_973= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_974= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_975= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  }");
  _method(v_SendNode, s_genOr_, (imp_t)SendNode__s_genOr_);
  l_976= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_");
  l_977= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") {");
  l_978= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_979= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_980= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_981= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } else _");
  l_982= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_SendNode, s_genIfTrue_, (imp_t)SendNode__s_genIfTrue_);
  l_983= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_");
  l_984= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") {");
  l_985= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } else {");
  l_986= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } _");
  l_987= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_988= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_SendNode, s_genIfTrueIfFalse_, (imp_t)SendNode__s_genIfTrueIfFalse_);
  l_989= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (!_");
  l_990= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") {");
  l_991= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_992= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _");
  l_993= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_994= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } else _");
  l_995= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_SendNode, s_genIfFalse_, (imp_t)SendNode__s_genIfFalse_);
  l_996= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  do {");
  l_997= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } while (!_");
  l_998= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genWhileFalse_, (imp_t)SendNode__s_genWhileFalse_);
  l_999= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  for (;;) {");
  l_1000= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (_");
  l_1001= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") break;");
  l_1002= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  };");
  _method(v_SendNode, s_genWhileFalseArg_, (imp_t)SendNode__s_genWhileFalseArg_);
  l_1003= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  do {");
  l_1004= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  } while (_");
  l_1005= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_SendNode, s_genWhileTrue_, (imp_t)SendNode__s_genWhileTrue_);
  l_1006= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  for (;;) {");
  l_1007= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (!_");
  l_1008= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") break;");
  l_1009= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  };");
  _method(v_SendNode, s_genWhileTrueArg_, (imp_t)SendNode__s_genWhileTrueArg_);
  _method(v_SendNode, s_gen_, (imp_t)SendNode__s_gen_);
  l_1010= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1011= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_");
  l_1012= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= ");
  l_1013= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_bind(_");
  l_1014= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1015= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")(_");
  l_1016= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_rebind(v_");
  l_1017= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1018= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")(_");
  l_1020= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_1019= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  _method(v_SendNode, s_genCascade_, (imp_t)SendNode__s_genCascade_);
  l_1021= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_1022= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEND ");
  l_1023= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1025= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_1026= _bind(v_Character, s__5fvalue_)(v_Character, (oop)59);
  l_1027= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1024= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_SendNode, s_printOn_indent_, (imp_t)SendNode__s_printOn_indent_);
  _method(v_SequenceNode, s_initialise, (imp_t)SequenceNode__s_initialise);
  _method(v_SequenceNode, s_addTemporary_, (imp_t)SequenceNode__s_addTemporary_);
  _method(v_SequenceNode, s_addStatement_, (imp_t)SequenceNode__s_addStatement_);
  _method(v_SequenceNode, s_lastStatement, (imp_t)SequenceNode__s_lastStatement);
  _method(v_SequenceNode, s_external_, (imp_t)SequenceNode__s_external_);
  _method(v_SequenceNode, s_encodeOpen_, (imp_t)SequenceNode__s_encodeOpen_);
  _method(v_SequenceNode, s_encodeSequence_, (imp_t)SequenceNode__s_encodeSequence_);
  l_1028= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genImplementation:");
  _method(v_SequenceNode, s_genImplementation_, (imp_t)SequenceNode__s_genImplementation_);
  l_1029= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genInitialisationIn:");
  _method(v_SequenceNode, s_genInitialisationIn_, (imp_t)SequenceNode__s_genInitialisationIn_);
  l_1030= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"gen:");
  _method(v_SequenceNode, s_gen_, (imp_t)SequenceNode__s_gen_);
  l_1031= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1032= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" {");
  l_1035= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1036= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop _1");
  l_1037= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_1039= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_1040= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" }");
  l_1033= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop ");
  l_1034= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  l_1038= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", _");
  _method(v_SequenceNode, s_genSequence_, (imp_t)SequenceNode__s_genSequence_);
  v_BlockNodeTag=_proto(v_Object);
  _method(v_BlockNodeTag, s__5fsizeof, (imp_t)BlockNodeTag__5fsizeof);
  _method(v_BlockNodeTag, s__5fdebugName, (imp_t)BlockNodeTag__5fdebugName);
  l_1041= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  {
 {
  oop _1;
  _1= l_1041;
  v_BlockNodeTag= _1;
 }
  }
  l_1042= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_BlockNode, s_initialise, (imp_t)BlockNode__s_initialise);
  _method(v_Object, s_isBlockNode, (imp_t)Object__s_isBlockNode);
  _method(v_BlockNode, s_isBlockNode, (imp_t)BlockNode__s_isBlockNode);
  _method(v_BlockNode, s_beVariadic, (imp_t)BlockNode__s_beVariadic);
  _method(v_BlockNode, s_addArgument_, (imp_t)BlockNode__s_addArgument_);
  _method(v_BlockNode, s_isOpenBlock, (imp_t)BlockNode__s_isOpenBlock);
  l_1043= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"nil");
  _method(v_BlockNode, s_ensureReturn, (imp_t)BlockNode__s_ensureReturn);
  l_1044= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_BlockNode, s_encode_, (imp_t)BlockNode__s_encode_);
  _method(v_BlockNode, s_encodeBlock_, (imp_t)BlockNode__s_encodeBlock_);
  l_1045= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop c_");
  l_1046= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_BlockNode, s_genDefinition_, (imp_t)BlockNode__s_genDefinition_);
  l_1047= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop b_");
  l_1048= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(oop _self");
  l_1050= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_1051= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{");
  l_1052= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1053= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop *_state= (oop *)_newPointers(sizeof(oop) * ");
  l_1054= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_1058= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"}");
  l_1049= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", oop ");
  l_1055= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _state[");
  l_1056= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]= ");
  l_1057= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_BlockNode, s_genImplementation_, (imp_t)BlockNode__s_genImplementation_);
  l_1059= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genInitialisationIn:");
  _method(v_BlockNode, s_genInitialisationIn_, (imp_t)BlockNode__s_genInitialisationIn_);
  l_1060= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  c_");
  l_1061= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_StaticBlock, s__5fentry__5farity_)");
  l_1062= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(v_StaticBlock, b_");
  l_1063= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1064= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_BlockNode, s_genInitialisation_, (imp_t)BlockNode__s_genInitialisation_);
  l_1065= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_1066= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= c_");
  l_1067= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_BlockNode, s_genStatic_, (imp_t)BlockNode__s_genStatic_);
  l_1068= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_1069= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(");
  l_1070= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"v_BlockClosure, ");
  l_1071= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"b_");
  l_1072= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1073= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1074= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self, ");
  l_1075= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct t_BlockClosure *)_self)->receiver, ");
  l_1076= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1077= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_state, ");
  l_1078= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"0, ");
  l_1079= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"0");
  l_1080= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_self");
  l_1081= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_BlockNode, s_genFull_, (imp_t)BlockNode__s_genFull_);
  l_1082= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _");
  l_1083= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _bind(v_BlockClosureNLR, s__5fentry__5farity_receiver_state_envp_)(");
  l_1084= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"v_BlockClosureNLR, ");
  l_1085= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"b_");
  l_1086= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1087= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1088= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self, ");
  l_1089= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct t_BlockClosure *)_self)->receiver, ");
  l_1090= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1091= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_state, ");
  l_1092= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"0, ");
  l_1093= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"&_env);");
  _method(v_BlockNode, s_genNLR_, (imp_t)BlockNode__s_genNLR_);
  _method(v_BlockNode, s_gen_, (imp_t)BlockNode__s_gen_);
  l_1094= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"[ :");
  l_1095= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" | ");
  l_1096= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" |");
  l_1097= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_BlockNode, s_printOn_indent_, (imp_t)BlockNode__s_printOn_indent_);
  _method(v_ParseNode, s_isMethod, (imp_t)ParseNode__s_isMethod);
  _method(v_MethodNode, s_isMethod, (imp_t)MethodNode__s_isMethod);
  _method(v_MethodNode, s_withClass_selector_arguments_, (imp_t)MethodNode__s_withClass_selector_arguments_);
  _method(v_MethodNode, s_class, (imp_t)MethodNode__s_class);
  l_1098= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  _method(v_MethodNode, s_ensureReturn, (imp_t)MethodNode__s_ensureReturn);
  l_1101= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_1099= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"class ");
  l_1100= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"is undeclared");
  _method(v_MethodNode, s_encodeIn_, (imp_t)MethodNode__s_encodeIn_);
  _method(v_MethodNode, s_genDeclarationIn_, (imp_t)MethodNode__s_genDeclarationIn_);
  l_1102= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genDefinition:");
  _method(v_MethodNode, s_genDefinition_, (imp_t)MethodNode__s_genDefinition_);
  l_1103= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop ");
  l_1104= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__");
  l_1105= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"(oop self");
  l_1107= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ...");
  l_1108= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)")");
  l_1109= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{");
  l_1110= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  jmp_buf _env;");
  l_1111= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1112= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop *_state= (oop *)_newPointers(sizeof(oop) * ");
  l_1113= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_1117= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  if (setjmp(_env)) { return _nlAnswer; };");
  l_1118= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"}");
  l_1106= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", oop ");
  l_1114= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _state[");
  l_1115= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]= ");
  l_1116= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_MethodNode, s_genImplementationIn_, (imp_t)MethodNode__s_genImplementationIn_);
  l_1119= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _method(");
  l_1120= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", ");
  l_1121= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", (imp_t)");
  l_1122= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__");
  l_1123= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_MethodNode, s_genInitialisationIn_, (imp_t)MethodNode__s_genInitialisationIn_);
  l_1124= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genImplementation:");
  _method(v_MethodNode, s_genImplementation_, (imp_t)MethodNode__s_genImplementation_);
  l_1125= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"gen:");
  _method(v_MethodNode, s_gen_, (imp_t)MethodNode__s_gen_);
  l_1126= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)">>");
  l_1127= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" | ");
  l_1128= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" | #");
  _method(v_MethodNode, s_printOn_, (imp_t)MethodNode__s_printOn_);
  l_1129= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_1130= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_MethodNode, s_printOn_indent_, (imp_t)MethodNode__s_printOn_indent_);
  _method(v_ExecNode, s_withStatement_, (imp_t)ExecNode__s_withStatement_);
  _method(v_ExecNode, s_isMethod, (imp_t)ExecNode__s_isMethod);
  l_1131= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_1132= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_1133= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"nil");
  l_1134= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_ExecNode, s_encodeIn_, (imp_t)ExecNode__s_encodeIn_);
  _method(v_ExecNode, s_genDeclarationIn_, (imp_t)ExecNode__s_genDeclarationIn_);
  l_1135= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genDefinition:");
  _method(v_ExecNode, s_genDefinition_, (imp_t)ExecNode__s_genDefinition_);
  _method(v_ExecNode, s_genImplementationIn_, (imp_t)ExecNode__s_genImplementationIn_);
  l_1136= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"genImplementation:");
  _method(v_ExecNode, s_genImplementation_, (imp_t)ExecNode__s_genImplementation_);
  l_1137= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  {");
  l_1138= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1139= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop *_state= (oop *)_newPointers(sizeof(oop) * ");
  l_1140= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_1141= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  }");
  _method(v_ExecNode, s_genInitialisationIn_, (imp_t)ExecNode__s_genInitialisationIn_);
  l_1142= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"gen:");
  _method(v_ExecNode, s_gen_, (imp_t)ExecNode__s_gen_);
  l_1143= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Exec(");
  l_1144= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_ExecNode, s_printOn_, (imp_t)ExecNode__s_printOn_);
  _method(v_IncludeNode, s_withName_, (imp_t)IncludeNode__s_withName_);
  _method(v_IncludeNode, s_encodeIn_, (imp_t)IncludeNode__s_encodeIn_);
  l_1145= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#include <");
  l_1146= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)">");
  _method(v_IncludeNode, s_genDeclarationIn_, (imp_t)IncludeNode__s_genDeclarationIn_);
  _method(v_IncludeNode, s_genImplementationIn_, (imp_t)IncludeNode__s_genImplementationIn_);
  _method(v_IncludeNode, s_genInitialisationIn_, (imp_t)IncludeNode__s_genInitialisationIn_);
  l_1147= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Include(");
  l_1148= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_IncludeNode, s_printOn_, (imp_t)IncludeNode__s_printOn_);
  _method(v_ImportNode, s_withNames_, (imp_t)ImportNode__s_withNames_);
  _method(v_ImportNode, s_encodeIn_, (imp_t)ImportNode__s_encodeIn_);
  l_1149= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/* ImportNode genDeclaration */");
  _method(v_ImportNode, s_genDeclarationIn_, (imp_t)ImportNode__s_genDeclarationIn_);
  l_1150= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/* ImportNode genImplementation */");
  _method(v_ImportNode, s_genImplementationIn_, (imp_t)ImportNode__s_genImplementationIn_);
  l_1151= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/* ImportNode genImplementation */");
  l_1152= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1153= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"=_import(\"");
  l_1154= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_ImportNode, s_genInitialisationIn_, (imp_t)ImportNode__s_genInitialisationIn_);
  l_1155= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Import(");
  l_1156= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_ImportNode, s_printOn_, (imp_t)ImportNode__s_printOn_);
  _method(v_ExportNode, s_withNames_, (imp_t)ExportNode__s_withNames_);
  l_1157= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is undeclared in export");
  _method(v_ExportNode, s_encodeIn_, (imp_t)ExportNode__s_encodeIn_);
  _method(v_ExportNode, s_genDeclarationIn_, (imp_t)ExportNode__s_genDeclarationIn_);
  _method(v_ExportNode, s_genImplementationIn_, (imp_t)ExportNode__s_genImplementationIn_);
  l_1158= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1159= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_export(\"");
  l_1160= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\",");
  l_1161= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  _method(v_ExportNode, s_genInitialisationIn_, (imp_t)ExportNode__s_genInitialisationIn_);
  l_1162= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Export(");
  l_1163= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_ExportNode, s_printOn_, (imp_t)ExportNode__s_printOn_);
  _method(v_RequireNode, s_withNames_, (imp_t)RequireNode__s_withNames_);
  _method(v_RequireNode, s_encodeIn_, (imp_t)RequireNode__s_encodeIn_);
  _method(v_RequireNode, s_genDeclarationIn_, (imp_t)RequireNode__s_genDeclarationIn_);
  _method(v_RequireNode, s_genImplementationIn_, (imp_t)RequireNode__s_genImplementationIn_);
  l_1164= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1165= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_require(\"");
  l_1166= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_RequireNode, s_genInitialisationIn_, (imp_t)RequireNode__s_genInitialisationIn_);
  l_1167= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"Require(");
  l_1168= _bind(v_Character, s__5fvalue_)(v_Character, (oop)41);
  _method(v_RequireNode, s_printOn_, (imp_t)RequireNode__s_printOn_);
  _method(v_ClassNode, s_name, (imp_t)ClassNode__s_name);
  _method(v_ClassNode, s_base, (imp_t)ClassNode__s_base);
  _method(v_ClassNode, s_mangledName, (imp_t)ClassNode__s_mangledName);
  _method(v_ClassNode, s_typeName, (imp_t)ClassNode__s_typeName);
  _method(v_ClassNode, s_slots, (imp_t)ClassNode__s_slots);
  _method(v_Object, s_isClassNode, (imp_t)Object__s_isClassNode);
  _method(v_ClassNode, s_isClassNode, (imp_t)ClassNode__s_isClassNode);
  _method(v_ClassNode, s_withName_base_slots_, (imp_t)ClassNode__s_withName_base_slots_);
  l_1169= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ClassNode withName: ");
  _method(v_ClassNode, s_withName_, (imp_t)ClassNode__s_withName_);
  _method(v_ClassNode, s__3d, (imp_t)ClassNode__s__3d);
  _method(v_ClassNode, s_declareIn_, (imp_t)ClassNode__s_declareIn_);
  l_1170= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"t_");
  l_1171= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"base is not a prototype: ");
  l_1174= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_sizeof");
  l_1175= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_debugName");
  l_1172= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"slot name ");
  l_1173= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" already used");
  _method(v_ClassNode, s_encodeIn_, (imp_t)ClassNode__s_encodeIn_);
  l_1176= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"struct t_");
  l_1177= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{");
  l_1178= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  vtbl_t _vtbl[0];");
  l_1181= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"};");
  l_1179= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop ");
  l_1180= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)";");
  _method(v_ClassNode, s_genDeclarationIn_, (imp_t)ClassNode__s_genDeclarationIn_);
  l_1182= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static int   ");
  l_1183= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__5fsizeof(oop self) { return sizeof(struct t_");
  l_1184= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"); }");
  l_1185= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static char *");
  l_1186= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__5fdebugName(oop self) { return \"");
  l_1187= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\"; }");
  _method(v_ClassNode, s_genImplementationIn_, (imp_t)ClassNode__s_genImplementationIn_);
  l_1188= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1189= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"=_proto(");
  l_1190= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)");");
  l_1191= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1192= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"=_proto(0);");
  l_1193= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _method(");
  l_1194= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", s__5fsizeof, (imp_t)");
  l_1195= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__5fsizeof);");
  l_1196= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _method(");
  l_1197= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)", s__5fdebugName, (imp_t)");
  l_1198= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"__5fdebugName);");
  l_1199= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1200= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"=_import(\"");
  l_1201= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_ClassNode, s_genInitialisationIn_, (imp_t)ClassNode__s_genInitialisationIn_);
  l_1202= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"nil");
  l_1203= _bind(v_Character, s__5fvalue_)(v_Character, (oop)58);
  l_1204= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"<extern>");
  _method(v_ClassNode, s_printOn_, (imp_t)ClassNode__s_printOn_);
  l_1205= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  CLASS NODE FOR GOBBLE ");
  _method(v_ClassNode, s_forGobble_, (imp_t)ClassNode__s_forGobble_);
  _method(v_ExternalClassNode, s_on_, (imp_t)ExternalClassNode__s_on_);
  _method(v_ExternalClassNode, s_encodeIn_, (imp_t)ExternalClassNode__s_encodeIn_);
  _method(v_ExternalClassNode, s_genDeclarationIn_, (imp_t)ExternalClassNode__s_genDeclarationIn_);
  _method(v_ExternalClassNode, s_genImplementationIn_, (imp_t)ExternalClassNode__s_genImplementationIn_);
  _method(v_ExternalClassNode, s_genInitialisationIn_, (imp_t)ExternalClassNode__s_genInitialisationIn_);
  l_1206= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{ ");
  l_1207= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" }");
  _method(v_ExternalClassNode, s_printOn_, (imp_t)ExternalClassNode__s_printOn_);
  _method(v_TemplateNode, s_withText_, (imp_t)TemplateNode__s_withText_);
  l_1208= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" encodeIn: ");
  _method(v_TemplateNode, s_encodeIn_, (imp_t)TemplateNode__s_encodeIn_);
  l_1209= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" genDeclarationIn: ");
  l_1210= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  /* ");
  l_1211= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" */");
  _method(v_TemplateNode, s_genDeclarationIn_, (imp_t)TemplateNode__s_genDeclarationIn_);
  l_1212= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" genImplementationIn: ");
  l_1213= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  /* ");
  l_1214= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" */");
  _method(v_TemplateNode, s_genImplementationIn_, (imp_t)TemplateNode__s_genImplementationIn_);
  l_1215= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" genInitialisationIn: ");
  l_1216= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  /* ");
  l_1217= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" */");
  _method(v_TemplateNode, s_genInitialisationIn_, (imp_t)TemplateNode__s_genInitialisationIn_);
  l_1218= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{ ");
  l_1219= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" }");
  _method(v_TemplateNode, s_printOn_, (imp_t)TemplateNode__s_printOn_);
  _method(v_Object, s_isNamedVariable, (imp_t)Object__s_isNamedVariable);
  _method(v_NamedVariable, s_isNamedVariable, (imp_t)NamedVariable__s_isNamedVariable);
  _method(v_NamedVariable, s_withName_mangledName_, (imp_t)NamedVariable__s_withName_mangledName_);
  _method(v_NamedVariable, s_name, (imp_t)NamedVariable__s_name);
  _method(v_NamedVariable, s_mangledName, (imp_t)NamedVariable__s_mangledName);
  _method(v_NamedVariable, s__3d, (imp_t)NamedVariable__s__3d);
  _method(v_NamedVariable, s_gen_, (imp_t)NamedVariable__s_gen_);
  l_1220= _bind(v_Character, s__5fvalue_)(v_Character, (oop)91);
  l_1221= _bind(v_Character, s__5fvalue_)(v_Character, (oop)93);
  _method(v_NamedVariable, s_printOn_, (imp_t)NamedVariable__s_printOn_);
  _method(v_ReceiverVariable, s_withName_mangledName_class_, (imp_t)ReceiverVariable__s_withName_mangledName_class_);
  _method(v_ReceiverVariable, s_class, (imp_t)ReceiverVariable__s_class);
  _method(v_ReceiverVariable, s_isExported, (imp_t)ReceiverVariable__s_isExported);
  _method(v_ReceiverVariable, s_exportedTo_, (imp_t)ReceiverVariable__s_exportedTo_);
  _method(v_ReceiverVariable, s_exportFrom_, (imp_t)ReceiverVariable__s_exportFrom_);
  l_1222= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct ");
  l_1223= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" *)self)->");
  _method(v_ReceiverVariable, s_gen_, (imp_t)ReceiverVariable__s_gen_);
  _method(v_RemoteReceiverVariable, s_withVariable_, (imp_t)RemoteReceiverVariable__s_withVariable_);
  l_1224= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct ");
  l_1225= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" *)((struct t_BlockClosure *)_self)->receiver)->");
  _method(v_RemoteReceiverVariable, s_gen_, (imp_t)RemoteReceiverVariable__s_gen_);
  l_1226= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)-1);
  _method(v_LocalVariable, s_withName_mangledName_level_, (imp_t)LocalVariable__s_withName_mangledName_level_);
  _method(v_LocalVariable, s_isExported, (imp_t)LocalVariable__s_isExported);
  _method(v_LocalVariable, s_level, (imp_t)LocalVariable__s_level);
  _method(v_LocalVariable, s_offset, (imp_t)LocalVariable__s_offset);
  _method(v_LocalVariable, s_exportFrom_, (imp_t)LocalVariable__s_exportFrom_);
  _method(v_LocalVariable, s_exportedTo_, (imp_t)LocalVariable__s_exportedTo_);
  l_1227= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_state[");
  l_1228= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]");
  _method(v_LocalVariable, s_gen_, (imp_t)LocalVariable__s_gen_);
  l_1229= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_GlobalVariable, s_level, (imp_t)GlobalVariable__s_level);
  _method(v_GlobalVariable, s_exportedTo_, (imp_t)GlobalVariable__s_exportedTo_);
  l_1230= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_1231= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  _method(v_SelfVariable, s_new, (imp_t)SelfVariable__s_new);
  _method(v_SelfVariable, s_isExported, (imp_t)SelfVariable__s_isExported);
  l_1232= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"self");
  l_1233= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct t_BlockClosure *)_self)->receiver");
  _method(v_SelfVariable, s_exportedTo_, (imp_t)SelfVariable__s_exportedTo_);
  _method(v_Object, s_isRemoteVariable, (imp_t)Object__s_isRemoteVariable);
  _method(v_RemoteVariable, s_isRemoteVariable, (imp_t)RemoteVariable__s_isRemoteVariable);
  _method(v_RemoteVariable, s_level_offset_, (imp_t)RemoteVariable__s_level_offset_);
  l_1234= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((oop *)");
  l_1236= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_self)");
  l_1237= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1239= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"->_state)[");
  l_1240= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"]");
  l_1235= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"((struct t_BlockClosure *)");
  l_1238= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"->outer)");
  _method(v_RemoteVariable, s_gen_, (imp_t)RemoteVariable__s_gen_);
  v_CompilerOutputStream=_proto(v_WriteStream);
  _method(v_CompilerOutputStream, s__5fsizeof, (imp_t)CompilerOutputStream__5fsizeof);
  _method(v_CompilerOutputStream, s__5fdebugName, (imp_t)CompilerOutputStream__5fdebugName);
  _method(v_CompilerOutputStream, s_gen_, (imp_t)CompilerOutputStream__s_gen_);
  _method(v_TranslationUnit, s_new, (imp_t)TranslationUnit__s_new);
  _method(v_TranslationUnit, s_outputStream, (imp_t)TranslationUnit__s_outputStream);
  l_1241= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_TranslationUnit, s_level, (imp_t)TranslationUnit__s_level);
  _method(v_TranslationUnit, s_note_, (imp_t)TranslationUnit__s_note_);
  l_1242= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"v_");
  _method(v_TranslationUnit, s_mangleVariable_, (imp_t)TranslationUnit__s_mangleVariable_);
  l_1243= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"s_");
  l_1244= _bind(v_Character, s__5fvalue_)(v_Character, (oop)58);
  l_1245= _bind(v_Character, s__5fvalue_)(v_Character, (oop)95);
  l_1246= _bind(v_Character, s__5fvalue_)(v_Character, (oop)95);
  _method(v_TranslationUnit, s_mangleSelector_, (imp_t)TranslationUnit__s_mangleSelector_);
  _method(v_TranslationUnit, s_mangleSlot_, (imp_t)TranslationUnit__s_mangleSlot_);
  _method(v_TranslationUnit, s_declareGlobal_, (imp_t)TranslationUnit__s_declareGlobal_);
  l_1247= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"declaration of class ");
  l_1248= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" conflicts with previous declaration ");
  c_124= _bind(v_StaticBlock, s__5fentry__5farity_)(v_StaticBlock, b_124, 0);
  _method(v_TranslationUnit, s_declareClass_, (imp_t)TranslationUnit__s_declareClass_);
  _method(v_TranslationUnit, s_lookupClass_ifAbsent_, (imp_t)TranslationUnit__s_lookupClass_ifAbsent_);
  l_1249= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"class ");
  l_1250= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is undeclared");
  _method(v_TranslationUnit, s_lookupClass_, (imp_t)TranslationUnit__s_lookupClass_);
  _method(v_TranslationUnit, s_declareSelector_, (imp_t)TranslationUnit__s_declareSelector_);
  l_1251= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"selector ");
  l_1252= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is undeclared");
  _method(v_TranslationUnit, s_lookupSelector_, (imp_t)TranslationUnit__s_lookupSelector_);
  _method(v_TranslationUnit, s_lookup_ifAbsent_, (imp_t)TranslationUnit__s_lookup_ifAbsent_);
  l_1253= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is undeclared");
  _method(v_TranslationUnit, s_lookup_, (imp_t)TranslationUnit__s_lookup_);
  l_1254= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" is undeclared");
  _method(v_TranslationUnit, s_lookupFree_, (imp_t)TranslationUnit__s_lookupFree_);
  _method(v_TranslationUnit, s_innerScopeFor_, (imp_t)TranslationUnit__s_innerScopeFor_);
  l_1255= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_TranslationUnit, s_tempCount, (imp_t)TranslationUnit__s_tempCount);
  l_1256= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static oop ");
  l_1257= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  l_1258= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"static sel_t ");
  l_1259= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= 0;");
  _method(v_TranslationUnit, s_genDefinitions, (imp_t)TranslationUnit__s_genDefinitions);
  l_1260= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  ");
  l_1261= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"= _selector(\"");
  l_1262= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"\");");
  _method(v_TranslationUnit, s_genInitialisations, (imp_t)TranslationUnit__s_genInitialisations);
  l_1263= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1264= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1265= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Scope, s_withParent_block_, (imp_t)Scope__s_withParent_block_);
  _method(v_Scope, s_level, (imp_t)Scope__s_level);
  _method(v_Scope, s_parent, (imp_t)Scope__s_parent);
  _method(v_Scope, s_exports, (imp_t)Scope__s_exports);
  _method(v_Scope, s_exportNLR, (imp_t)Scope__s_exportNLR);
  _method(v_Scope, s_exportSelf, (imp_t)Scope__s_exportSelf);
  _method(v_Scope, s_exportOuter, (imp_t)Scope__s_exportOuter);
  _method(v_Scope, s_isMethod, (imp_t)Scope__s_isMethod);
  _method(v_Scope, s_class, (imp_t)Scope__s_class);
  _method(v_Scope, s_addBlock_, (imp_t)Scope__s_addBlock_);
  l_1266= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Scope, s_resetTemps, (imp_t)Scope__s_resetTemps);
  _method(v_Scope, s_tempCount, (imp_t)Scope__s_tempCount);
  l_1267= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scope, s_newTemp, (imp_t)Scope__s_newTemp);
  l_1268= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scope, s_freeTemp, (imp_t)Scope__s_freeTemp);
  _method(v_Scope, s_freeTemps_, (imp_t)Scope__s_freeTemps_);
  l_1269= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  _method(v_Scope, s_isStatic, (imp_t)Scope__s_isStatic);
  _method(v_Scope, s_mangleVariable_, (imp_t)Scope__s_mangleVariable_);
  _method(v_Scope, s_declareLiteral_, (imp_t)Scope__s_declareLiteral_);
  _method(v_Scope, s_declareSelector_, (imp_t)Scope__s_declareSelector_);
  _method(v_Scope, s_declareState_, (imp_t)Scope__s_declareState_);
  _method(v_Scope, s_declare_as_, (imp_t)Scope__s_declare_as_);
  _method(v_Scope, s_declareLocal_, (imp_t)Scope__s_declareLocal_);
  _method(v_Scope, s_lookupClass_, (imp_t)Scope__s_lookupClass_);
  _method(v_Scope, s_lookup_, (imp_t)Scope__s_lookup_);
  _method(v_Scope, s_lookupFree_, (imp_t)Scope__s_lookupFree_);
  _method(v_Scope, s_innerScopeFor_, (imp_t)Scope__s_innerScopeFor_);
  l_1270= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1271= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scope, s_nextExportOffset, (imp_t)Scope__s_nextExportOffset);
  _method(v_Scope, s_noteExportOuter, (imp_t)Scope__s_noteExportOuter);
  _method(v_Scope, s_noteExportSelf, (imp_t)Scope__s_noteExportSelf);
  _method(v_Scope, s_noteExportNLR, (imp_t)Scope__s_noteExportNLR);
  _method(v_Scope, s_genDefinitions_, (imp_t)Scope__s_genDefinitions_);
  _method(v_Scope, s_genImplementations_, (imp_t)Scope__s_genImplementations_);
  _method(v_Scope, s_genInitialisations_, (imp_t)Scope__s_genInitialisations_);
  _method(v_CompilerOptions, s_new, (imp_t)CompilerOptions__s_new);
  _method(v_CompilerOptions, s_searchPaths, (imp_t)CompilerOptions__s_searchPaths);
  _method(v_CompilerOptions, s_mainFlag, (imp_t)CompilerOptions__s_mainFlag);
  _method(v_CompilerOptions, s_mainFlag_, (imp_t)CompilerOptions__s_mainFlag_);
  v_ScannerContext=_proto(v_Object);
  _method(v_ScannerContext, s__5fsizeof, (imp_t)ScannerContext__5fsizeof);
  _method(v_ScannerContext, s__5fdebugName, (imp_t)ScannerContext__5fdebugName);
  _method(v_ScannerContext, s_withName_line_input_header_, (imp_t)ScannerContext__s_withName_line_input_header_);
  _method(v_ScannerContext, s_name, (imp_t)ScannerContext__s_name);
  _method(v_ScannerContext, s_line, (imp_t)ScannerContext__s_line);
  _method(v_ScannerContext, s_input, (imp_t)ScannerContext__s_input);
  _method(v_ScannerContext, s_header, (imp_t)ScannerContext__s_header);
  _method(v_Scanner, s_new, (imp_t)Scanner__s_new);
  l_1272= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)256);
  l_1273= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xIllegal");
  l_1274= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"0123456789");
  l_1275= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xDigit");
  l_1276= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"abcdefghijklmnopqrstuvwxyz");
  l_1277= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1278= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  l_1279= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1280= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"_");
  l_1281= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1282= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"~!@%&*=\134?/><,|^");
  l_1283= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xBinary");
  l_1284= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"+-");
  l_1285= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xSign");
  l_1286= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#[];()}");
  l_1287= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xPunctuator");
  l_1288= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" \011\012\015\013\014");
  l_1289= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xSpace");
  l_1290= _bind(v_Character, s__5fvalue_)(v_Character, (oop)46);
  l_1291= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xDot");
  l_1292= _bind(v_Character, s__5fvalue_)(v_Character, (oop)58);
  l_1293= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xColon");
  l_1294= _bind(v_Character, s__5fvalue_)(v_Character, (oop)123);
  l_1295= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xBrace");
  l_1296= _bind(v_Character, s__5fvalue_)(v_Character, (oop)36);
  l_1297= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xCharacter");
  l_1298= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  l_1299= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xString");
  l_1300= _bind(v_Character, s__5fvalue_)(v_Character, (oop)34);
  l_1301= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xComment");
  l_1302= _bind(v_Character, s__5fvalue_)(v_Character, (oop)97);
  l_1303= _bind(v_Character, s__5fvalue_)(v_Character, (oop)7);
  l_1304= _bind(v_Character, s__5fvalue_)(v_Character, (oop)98);
  l_1305= _bind(v_Character, s__5fvalue_)(v_Character, (oop)8);
  l_1306= _bind(v_Character, s__5fvalue_)(v_Character, (oop)101);
  l_1307= _bind(v_Character, s__5fvalue_)(v_Character, (oop)27);
  l_1308= _bind(v_Character, s__5fvalue_)(v_Character, (oop)102);
  l_1309= _bind(v_Character, s__5fvalue_)(v_Character, (oop)12);
  l_1310= _bind(v_Character, s__5fvalue_)(v_Character, (oop)110);
  l_1311= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  l_1312= _bind(v_Character, s__5fvalue_)(v_Character, (oop)114);
  l_1313= _bind(v_Character, s__5fvalue_)(v_Character, (oop)13);
  l_1314= _bind(v_Character, s__5fvalue_)(v_Character, (oop)116);
  l_1315= _bind(v_Character, s__5fvalue_)(v_Character, (oop)9);
  l_1316= _bind(v_Character, s__5fvalue_)(v_Character, (oop)118);
  l_1317= _bind(v_Character, s__5fvalue_)(v_Character, (oop)11);
  l_1318= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"<initialisation>");
  l_1319= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scanner, s_initialise, (imp_t)Scanner__s_initialise);
  l_1320= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)":");
  l_1321= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)": ");
  _method(v_Scanner, s_error_, (imp_t)Scanner__s_error_);
  _method(v_Scanner, s_next, (imp_t)Scanner__s_next);
  l_1322= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)".st");
  l_1323= _bind(v_Character, s__5fvalue_)(v_Character, (oop)47);
  l_1325= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)": ");
  l_1324= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"/");
  _method(v_Scanner, s_findFile_, (imp_t)Scanner__s_findFile_);
  l_1326= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scanner, s_include_, (imp_t)Scanner__s_include_);
  l_1327= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"GOBBLE ");
  _method(v_Scanner, s_gobble_, (imp_t)Scanner__s_gobble_);
  _method(v_Scanner, s_on_, (imp_t)Scanner__s_on_);
  l_1328= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xSpace");
  l_1329= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  l_1330= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1331= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"#");
  _method(v_Scanner, s_scan, (imp_t)Scanner__s_scan);
  _method(v_Scanner, s_xSign, (imp_t)Scanner__s_xSign);
  l_1332= _bind(v_Character, s__5fvalue_)(v_Character, (oop)46);
  l_1333= _bind(v_Character, s__5fvalue_)(v_Character, (oop)46);
  l_1334= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ellipsis");
  l_1335= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)".");
  _method(v_Scanner, s_xDot, (imp_t)Scanner__s_xDot);
  l_1336= _bind(v_Character, s__5fvalue_)(v_Character, (oop)61);
  l_1337= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"assign");
  _method(v_Scanner, s_xColon, (imp_t)Scanner__s_xColon);
  _method(v_Scanner, s_xPunctuator, (imp_t)Scanner__s_xPunctuator);
  l_1338= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xBinary");
  l_1339= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  _method(v_Scanner, s_xBinary, (imp_t)Scanner__s_xBinary);
  l_1340= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1341= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1342= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xDigit");
  l_1343= _bind(v_Character, s__5fvalue_)(v_Character, (oop)58);
  l_1344= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  _method(v_Scanner, s_xLetter, (imp_t)Scanner__s_xLetter);
  l_1345= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1346= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1347= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"composite keyword does not end in :");
  _method(v_Scanner, s_scanKeywords, (imp_t)Scanner__s_scanKeywords);
  l_1348= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xLetter");
  l_1349= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"xDigit");
  l_1350= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"integer");
  _method(v_Scanner, s_xDigit, (imp_t)Scanner__s_xDigit);
  l_1351= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)2);
  l_1352= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EOF while scanning octal character escape");
  l_1353= _bind(v_Character, s__5fvalue_)(v_Character, (oop)48);
  l_1354= _bind(v_Character, s__5fvalue_)(v_Character, (oop)55);
  l_1355= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal digit in octal character escape");
  l_1356= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)8);
  _method(v_Scanner, s_scanOctal, (imp_t)Scanner__s_scanOctal);
  l_1357= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EOF while scanning escaped character");
  l_1358= _bind(v_Character, s__5fvalue_)(v_Character, (oop)48);
  l_1359= _bind(v_Character, s__5fvalue_)(v_Character, (oop)55);
  _method(v_Scanner, s_scanEscape, (imp_t)Scanner__s_scanEscape);
  l_1360= _bind(v_Character, s__5fvalue_)(v_Character, (oop)92);
  _method(v_Scanner, s_scanCharacter, (imp_t)Scanner__s_scanCharacter);
  l_1361= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal character: ");
  _method(v_Scanner, s_xIllegal, (imp_t)Scanner__s_xIllegal);
  l_1362= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EOF in character literal");
  l_1363= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"character");
  _method(v_Scanner, s_xCharacter, (imp_t)Scanner__s_xCharacter);
  l_1364= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  l_1365= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  l_1366= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EOF in string literal");
  l_1367= _bind(v_Character, s__5fvalue_)(v_Character, (oop)39);
  l_1368= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"string");
  _method(v_Scanner, s_xString, (imp_t)Scanner__s_xString);
  l_1369= _bind(v_Character, s__5fvalue_)(v_Character, (oop)34);
  l_1370= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  l_1371= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  _method(v_Scanner, s_xComment, (imp_t)Scanner__s_xComment);
  l_1373= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1374= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1375= _bind(v_Character, s__5fvalue_)(v_Character, (oop)125);
  l_1376= _bind(v_Character, s__5fvalue_)(v_Character, (oop)123);
  l_1377= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1378= _bind(v_Character, s__5fvalue_)(v_Character, (oop)10);
  l_1379= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1380= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EOF in external code");
  l_1381= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1382= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1383= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"extern");
  l_1372= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"{");
  _method(v_Scanner, s_xBrace, (imp_t)Scanner__s_xBrace);
  _method(v_Parser, s_on_, (imp_t)Parser__s_on_);
  _method(v_Parser, s_note_, (imp_t)Parser__s_note_);
  l_1384= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"]");
  l_1385= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"integer");
  l_1386= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ByteArrays can only contain integers");
  l_1387= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)0);
  l_1388= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)255);
  l_1389= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ByteArray element not between 0 and 255");
  _method(v_Parser, s_parseByteArray, (imp_t)Parser__s_parseByteArray);
  l_1390= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"}");
  l_1391= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"PARSE_WORD_ARRAY-1");
  l_1392= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"integer");
  l_1393= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"WordArrays can only contain integers");
  _method(v_Parser, s_parseWordArray, (imp_t)Parser__s_parseWordArray);
  l_1394= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1395= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1396= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1397= _bind(v_ImmutableArray, s__5fsize_value_)(v_ImmutableArray, (oop)3, (oop)_l_1397);
  l_1399= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"(");
  l_1400= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"{");
  l_1401= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"[");
  l_1398= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  _method(v_Parser, s_parseArrayLiteral, (imp_t)Parser__s_parseArrayLiteral);
  l_1402= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"ARRAY-1");
  l_1403= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)")");
  l_1404= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") expected at end of literal Array");
  _method(v_Parser, s_parseArray, (imp_t)Parser__s_parseArray);
  l_1405= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"LITERAL-1");
  l_1406= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"integer");
  l_1407= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"character");
  l_1408= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"string");
  l_1409= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"LITERAL-2");
  l_1410= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"#");
  l_1411= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"LITERAL-3");
  l_1412= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1413= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1414= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1415= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"string");
  l_1416= _bind(v_ImmutableArray, s__5fsize_value_)(v_ImmutableArray, (oop)4, (oop)_l_1416);
  l_1418= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"LITERAL-4");
  l_1419= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"(");
  l_1420= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"{");
  l_1421= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"[");
  l_1422= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal literal following #");
  l_1417= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  _method(v_Parser, s_parseLiteralP, (imp_t)Parser__s_parseLiteralP);
  l_1423= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"PRIMARY-1");
  l_1424= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1425= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"(");
  l_1428= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"[");
  l_1429= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"PRIMARY-2");
  l_1430= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"PRIMARY-3");
  l_1431= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"PRIMARY-ABORT");
  l_1432= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"parsePrimary: not implemented");
  l_1426= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)")");
  l_1427= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") expected");
  _method(v_Parser, s_parsePrimary, (imp_t)Parser__s_parsePrimary);
  l_1433= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  _method(v_Parser, s_parseUnary, (imp_t)Parser__s_parseUnary);
  l_1434= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  _method(v_Parser, s_parseBinary, (imp_t)Parser__s_parseBinary);
  l_1435= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EXPR-1");
  l_1436= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EXPR-2");
  l_1437= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1438= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EXPR-3");
  l_1439= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1440= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  l_1441= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1442= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"EXPR-4");
  l_1443= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"assign");
  l_1444= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)";");
  l_1445= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"cascade does not follow a message send");
  l_1446= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)";");
  l_1447= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"");
  l_1448= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1449= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1450= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  l_1451= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1452= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1453= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1454= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"syntax error in cascade");
  _method(v_Parser, s_parseExpression, (imp_t)Parser__s_parseExpression);
  l_1455= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1456= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1457= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"|");
  l_1458= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"identifier or | expected in temporaries");
  _method(v_Parser, s_parseTemporaries_, (imp_t)Parser__s_parseTemporaries_);
  l_1459= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEQ-1");
  l_1460= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1461= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"|");
  l_1462= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEQ-2");
  l_1463= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"]");
  l_1464= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEQ-3");
  l_1465= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"extern");
  l_1466= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1467= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"^");
  l_1468= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)".");
  l_1469= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"]");
  l_1470= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)". or ] expected in block");
  l_1471= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)".");
  l_1472= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"]");
  l_1473= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"] expected at end of block");
  l_1474= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEQ-4");
  l_1475= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"SEQ-5");
  _method(v_Parser, s_parseSequence_, (imp_t)Parser__s_parseSequence_);
  l_1476= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  l_1477= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1478= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"parameter name expected");
  l_1479= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1480= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"||");
  l_1481= _bind(v_Character, s__5fvalue_)(v_Character, (oop)124);
  l_1482= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1483= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"|");
  l_1484= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"| expected at end of block parameters");
  _method(v_Parser, s_parseBlockParameters_, (imp_t)Parser__s_parseBlockParameters_);
  l_1485= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  _method(v_Parser, s_parseBlock, (imp_t)Parser__s_parseBlock);
  _method(v_Parser, s_parseExec, (imp_t)Parser__s_parseExec);
  l_1486= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" include <");
  l_1487= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" <>");
  l_1488= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" include ");
  l_1489= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ");
  l_1490= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" gobble ");
  l_1491= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" ");
  l_1492= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)" template ");
  _method(v_Parser, s_parseExtern, (imp_t)Parser__s_parseExtern);
  l_1493= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  l_1494= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1495= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"base prototype name expected in declaration");
  l_1496= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"(");
  l_1497= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"slot names expected in prototype declaration");
  l_1498= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1499= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)")");
  l_1500= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)") expected after slot names in prototype declaration");
  _method(v_Parser, s_parseClass_, (imp_t)Parser__s_parseClass_);
  l_1501= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"METHOD-1");
  l_1502= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"");
  l_1503= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1504= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"keyword");
  l_1505= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1506= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"missing parameter name");
  l_1507= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"binary");
  l_1508= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1509= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"missing parameter name");
  l_1510= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1511= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"method pattern expected");
  l_1512= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"METHOD-2");
  l_1513= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"ellipsis");
  l_1514= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"[");
  l_1515= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"extern");
  l_1516= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"method body expected");
  l_1517= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"METHOD-3");
  _method(v_Parser, s_parseMethod_, (imp_t)Parser__s_parseMethod_);
  l_1518= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"extern");
  l_1519= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"[");
  l_1520= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"identifier");
  l_1523= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"syntax error");
  l_1521= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)":");
  l_1522= _bind(v_Symbol, s__5fvalue_)(v_Symbol, (oop)"(");
  _method(v_Parser, s_parseDeclaration, (imp_t)Parser__s_parseDeclaration);
  _method(v_Parser, s_parse, (imp_t)Parser__s_parse);
  _method(v_Compiler, s_new, (imp_t)Compiler__s_new);
  l_1524= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"nil");
  l_1525= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"true");
  l_1526= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"false");
  l_1527= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"#include \"idst.h\"");
  l_1530= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"void __init__(void)");
  l_1531= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{");
  l_1532= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  oop self= 0;");
  l_1533= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  (void)self;");
  l_1535= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"}");
  l_1536= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"int main(int argc, char **argv)");
  l_1537= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"{");
  l_1538= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  _idst_initialise(argc, argv);");
  l_1539= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  __init__();");
  l_1540= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"  return 0;");
  l_1541= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"}");
  l_1528= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"declare: ");
  l_1529= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"implement: ");
  l_1534= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"initialise: ");
  _method(v_Compiler, s_compile_from_to_withOptions_, (imp_t)Compiler__s_compile_from_to_withOptions_);
  l_1542= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"encode: ");
  _method(v_Compiler, s_addNode_extern_, (imp_t)Compiler__s_addNode_extern_);
  {
 {
  oop _1;
  
/*
  Local Variables:
  mode: outline-minor
  outline-regexp: "[a-zA_Z[\042{]"
  eval: (hide-body)
  eval: (or font-lock-mode (font-lock-mode))
  End:
  }
*/

  ; _1= 0;
 }
  }
  l_1543= _bind(v_Character, s__5fvalue_)(v_Character, (oop)73);
  l_1544= _bind(v_Character, s__5fvalue_)(v_Character, (oop)109);
  l_1545= _bind(v_Character, s__5fvalue_)(v_Character, (oop)111);
  l_1546= _bind(v_Character, s__5fvalue_)(v_Character, (oop)63);
  l_1548= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1549= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1550= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"no source file specified");
  l_1551= _bind(v_SmallInteger, s__5fvalue_)(v_SmallInteger, (oop)1);
  l_1552= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"multiple source files specified");
  l_1547= _bind(v_ImmutableString, s__5fvalue_)(v_ImmutableString, (oop)"illegal option: -");
  {
  oop *_state= (oop *)_newPointers(sizeof(oop) * 4);
 {
  oop _1, _2, _3, _4, _5;
  _1= v_OrderedCollection;
  _1= _bind(_1, s_new)(_1);
  _state[3]= _1;
  _1= v_CompilerOptions;
  _1= _bind(_1, s_new)(_1);
  _state[0]= _1;
  _1= v_nil;
  _state[1]= _1;
  _1= v_GetOpt;
  _1= _bind(_1, s_new)(_1);
  _2= l_1543;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_180, 2, self, _state, 0);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1544;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_181, 1, self, _state, 0);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1545;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_182, 2, self, _state, 0);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= l_1546;
  _3= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_183, 1, self, _state, 0);
  _bind(_1, s_at_put_)(_1, _2, _3);
  _2= _bind(v_BlockClosure, s__5fentry__5farity_receiver_state_outer_)(v_BlockClosure, b_184, 1, self, _state, 0);
  _bind(_1, s_default_)(_1, _2);
  _2= v_Smalltalk;
  _2= _bind(_2, s_arguments)(_2);
  _3= l_1548;
  _1= _bind(_1, s_parse_startingAt_)(_1, _2, _3);
  _1= _state[3];
  _1= _bind(_1, s_size)(_1);
  _2= l_1549;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 < (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3c)(_1, _2);
  if (_1) {
 {
  _2= _state[2];
  _3= l_1550;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= _state[3];
  _1= _bind(_1, s_size)(_1);
  _2= l_1551;
  if (_areIntegerObjects(_1, _2))
    _1= ((long)_1 > (long)_2) ? v_true : v_false;
  else
    _1= _bind(_1, s__3e)(_1, _2);
  if (_1) {
 {
  _2= _state[2];
  _3= l_1552;
  _2= _bind(_2, s_error_)(_2, _3);
 }
  _1= _2;
  } else _1= 0;
  _1= v_Compiler;
  _2= v_String;
  _3= _state[3];
  _3= _bind(_3, s_first)(_3);
  _2= _bind(_2, s_readFromFileNamed_)(_2, _3);
  _3= _state[3];
  _3= _bind(_3, s_first)(_3);
  _4= _state[1];
  _5= _state[0];
  _1= _bind(_1, s_compile_from_to_withOptions_)(_1, _2, _3, _4, _5);
 }
  }
}

int main(int argc, char **argv)
{
  _idst_initialise(argc, argv);
  __init__();
  return 0;
}

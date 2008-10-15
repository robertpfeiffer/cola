{ import: Object }

Symbol asUnarySelector
[
    ^(self asString copyFrom: 0 to: self size - 2) asSymbol
]

" A prototype is a dictionary of slots. "

Prototype : MemoDictionary ( prototypeFamilyName prototypeSlotNames )

" A new prototype has the same family and slot names as its progenitor. "

Prototype new
[
    ^self named: prototypeFamilyName withSlots: prototypeSlotNames
]

Prototype named: familyName withSlots: slotNames
[
    self := self basicNew.
    prototypeFamilyName := familyName.
    prototypeSlotNames := slotNames.
]

Prototype _debugName
[
    ^prototypeFamilyName _stringValue
]

" Slots are named after their getter, so setters have to be
  transformed into getters for slot access.  For efficiency we'll
  cache a map of setterName -> getterName. "

SetterNameDictionary := [ MemoDictionary new ]

Prototype slotNameForSetter: aSelector
[
    ^SetterNameDictionary at: aSelector ifAbsent: [SetterNameDictionary at: aSelector put: aSelector asUnarySelector]
]

" Set the value the slot named aKey to anObject iff the prototype is
  supposed to have a slot with the given name. "

Prototype at: aKey put: anObject ifAbsent: errorBlock
[
    ^(prototypeSlotNames includes: aKey) ifTrue: [super at: aKey put: anObject] ifFalse: [errorBlock value]
]

" Get the value the slot named aKey. "

Prototype at: aKey ifAbsent: errorBlock
[
    ^(prototypeSlotNames includes: aKey) ifTrue: [super at: aKey] ifFalse: [errorBlock value]
]

" Dynamic access to slots is handled by replying the method closure
  for Prototype.tryToAccessSlot that will be invoked whenever the
  receiver doesNotUnderstand the getter or setter for a slot. "

Prototype tryToAccessSlot :value
[
    | aSelector |
    " The original selector is saved in the __send struct at the message send site. "
    { v_aSelector= ((struct __send *)v__closure)->selector; }.
    ^self tryToAccessSlot: aSelector :value
]

Prototype tryToAccessSlot: aSelector :value
[
    " Determine if aSelector smells like a setter or getter and act
      accordingly.  If aSelector does not name a slot, propagate the
      error to the usual handler. "
    ^aSelector isKeyword
	ifTrue:  [self at: (self slotNameForSetter: aSelector) put: value ifAbsent: [super doesNotUnderstand: aSelector]]
	ifFalse: [self at: aSelector ifAbsent: [super doesNotUnderstand: aSelector]]
]

" #doesNotUnderstand: can recover from a failed method lookup by
  answering the closure of the method that should respond to the
  message.  To avoid looking this up every time , we cache it once. "

PrototypeSlotAccessor := [ (Prototype _vtable findKeyOrNil: #tryToAccessSlot) value ]

Prototype doesNotUnderstand: aSelector
[
    ^PrototypeSlotAccessor
]

" The primordial Prototype should have an empty slot name collection. "

[ Prototype := Prototype named: 'Prototype' withSlots: #() ]

"----------------------------------------------------------------"

DBJrPage23 := [ Prototype named: 'DBJrPage23' withSlots: #(box1 box2 box3) ]

[
    | page23 page24 |
    page23 := DBJrPage23 new println.
    page24 := DBJrPage23 new println.
    page23 box1: 42; box2: 666.
    page24 box1: #quad; box2: #erat; box3: #demonstrandum.
    page23 box1 println.
    page23 box2 println.
    page23 box3 println.
    page24 box1 println.
    page24 box2 println.
    page24 box3 println.
"
    page23 qux: 99.
    page23 qux println.
"
]

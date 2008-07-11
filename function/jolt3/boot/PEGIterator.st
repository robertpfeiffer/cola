{ import: Objects }

PEGIterator : Object ()

PEGIterator structure		:node [ ^self preOrderApply: node second ]
PEGIterator literal		:node []
PEGIterator class		:node []
PEGIterator string		:node []
PEGIterator invoke		:node []
PEGIterator dot			:node []
PEGIterator zeroOne		:node [ ^self preOrderApply: node second ]
PEGIterator zeroMany		:node [ ^self preOrderApply: node second ]
PEGIterator oneMany		:node [ ^self preOrderApply: node second ]
PEGIterator text		:node [ ^self preOrderApply: node second ]
PEGIterator answer		:node []
PEGIterator action		:node []
PEGIterator predicate		:node []
PEGIterator value		:node []
PEGIterator variable		:node []
PEGIterator store		:node [ ^self preOrderApply: node third  ]
PEGIterator and			:node [ ^self preOrderApply: node second ]
PEGIterator not			:node [ ^self preOrderApply: node second ]
PEGIterator sequence		:node [ ^self preOrderRest:  node	 ]
PEGIterator alternatives	:node [ ^self preOrderRest:  node	 ]
PEGIterator parameters		:node [ ^self preOrderApply: node fourth ]
PEGIterator definition		:node [ ^self preOrderApply: node third	 ]
PEGIterator declaration		:node []
PEGIterator grammar		:node [ ^self preOrderRest:  node	 ]

PEGIterator preOrderApply: node
[
    self perform: node first with: node.
]

PEGIterator preOrderRest: node
[
    node from: 1 do: [:subNode | self preOrderApply: subNode]
]

"----------------"

CollectLocals : PEGIterator ( locals )

CollectLocals for: aGrammar
[
    self := self new.
    locals := IdentityDictionary new.
    self preOrderApply: aGrammar.
    ^locals.
]

CollectLocals store :node
[
    locals at: node second put: true.
    super store :node.
]

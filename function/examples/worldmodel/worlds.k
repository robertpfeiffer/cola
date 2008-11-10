

(define WorkingMemory (import "WorkingMemory"))
(define WorldModel (import "WorldModel"))

(define workingMemory [WorkingMemory new])
(define nil 0)

[WorkingMemory update: 'x toValue: '12]
[WorkingMemory update: 'y toValue: '7]
[workingMemory advanceTime]
[WorkingMemory update: 'x toValue: '13]
[WorkingMemory advanceTimeAndUpdate: 'x toValue: '14]

[[[WorkingMemory currentWorld] time] println]
[[workingMemory get: 'x] println]
[[workingMemory get: 'x atTime: '2] println]
[[workingMemory get: 'x atTime: '0] println]
[[workingMemory get: 'x atTime: '1] println]
[[workingMemory get: 'x atTime: '4] println]
[[workingMemory get: 'y] println]




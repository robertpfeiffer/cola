"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;											     ;;;
;;;  WorldModel - 'worlds' model to reference objects by an added axis of 'time'             ;;; 
;;;  		  changes from a particular world can go into child world with               ;;;
;;;               an incremented time step.                                                  ;;;
;;;               lookups done using dynamic scoping from current world, its parent world,   ;;;
;;;		  all the way up to nortial world at time 0.                                 ;;;
;;;                                                               			     ;;;
;;;               a WorkingMemory will contain pointers to all spawned worlds and            ;;;
;;;               the current world, handling all variable lookups and updates,              ;;;
;;;               as well as spawning of new worlds.                                         ;;;
;;;                                     			                             ;;;
;;; Author:        Hesam Samimi                                   			     ;;;
;;;                                                               			     ;;;
;;; Revision:      # 1.0                                      			             ;;;
;;; Last Update:   11-08-2008								     ;;; 
;;;                                                               			     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;;  Module: WorldModel
;;;
;;; Methods: [ WorkingMemory new ]                          <---- constructor
;;;          [ WorkingMemory currentWorld ]                 <---- pointer to current world
;;;          [ WorkingMemory advanceTime ]                  <---- spawn a child world 
;;;                                                                  (of time t + 1)
;;;          [ WorkingMemory update: varName 
;;;                         toValue: value ]                <---- update the value of var
;;;                                                               in the current world
;;;          [ WorkingMemory advanceTimeAndUpdate: varName 
;;;			                  toValue: value ]  <---- spawn a child world, then
;;;								  update the value of var
;;;                                                               in the new world
;;;          [ WorkingMemory get: varName ]                 <---- value of var in current world
;;;          [ WorkingMemory get: varName atTime: time ]    <---- value of var in a world of 
;;;                                                               given time 
;;;          
;;;          [ World time ]                                 <---- time of the world 
;;;
             
"

{ import: Objects }

" Universe of Worlds "
WorkingMemory : Object ( currentWorld worlds )
" A World has bindings for variables and can lookup bindings in its ancestor worlds
  (dynamic scoping) 
  It is identified by a time integer: usually the initial world has time = 0 "
WorldModel : Object ( time parent children variableValueBindings )

WorkingMemory currentWorld
[
    ^currentWorld
]

WorkingMemory worlds
[
    ^worlds
]

WorkingMemory currentWorld: cw
[
    currentWorld := cw
]

"    WorkingMemeory has a dictionary of possible worlds for each time, so its worlds is 
     a dictionarof dictionaries "
WorkingMemory new
[
    | initWorld wldsAtTimeZero |
    self = super new.
    initWorld := WorldModel withTime: 0.
    wldsAtTimeZero := IdentityDictionary new.
    wldsAtTimeZero at: 0 put: initWorld.
    worlds := IdentityDictionary new.
    worlds at: 0 put: wldsAtTimeZero.
    currentWorld := initWorld
]

"    creates a new world to move one time step forward, updates the CurrentWorld
     to point to the new world "
WorkingMemory advanceTime
[
    | newTime newCurrWorld possibleWorlds |
    newTime := currentWorld time + 1.
    newCurrWorld := WorldModel withTime: newTime.
    possibleWorlds := IdentityDictionary new.
    newCurrWorld parent: currentWorld.
    possibleWorlds at: 0 put: newCurrWorld.
    worlds at: newTime put: possibleWorlds.
    currentWorld := newCurrWorld
]

"    updates the binding in the current world "
WorkingMemory update: var toValue: val
[
    self currentWorld update: var toValue: val
]

"    advances time by creating a new world and pointing current world to it, 
     then updates the binding in the new current world "
WorkingMemory advanceTimeAndUpdate: var toValue: val
[
    self advanceTime.
    self update: var toValue: val
]

"    gets the value of a variable at the requested world 
     we're looking for the world that binds this variable starting from given 
     world. if not there, go to the parent and parent of parent, so on,
     until we go enough back to find the world that has the most up-to-date
     value of this property (dynamic scoping of worlds) "
WorkingMemory get: variableName inWorld: targetWorld
[
    | res found |
    res := false.
    found := false.
    [ 
      ( targetWorld variableValueBindings includesKey: variableName )
          ifTrue: [ found := true.
	  	    res := targetWorld variableValueBindings at: variableName ].
      targetWorld parent and: [found not]
    ] whileTrue: [ targetWorld := targetWorld parent ].
    ^res
]

"    same as above, w/o dynamic scoping
     return is an array first elm is foundflag, second is value 
     (because value itself may be nil, so it cannot be the same as foundflag) "
WorkingMemory get: variableName inExactWorld: targetWorld
[
     | bindings res |
     bindings := targetWorld variableValueBindings.
     ( bindings includesKey: variableName )
         ifTrue: [ res := Array with: true with: ( bindings at: variableName ) ]
        ifFalse: [ res := Array with: false with: false ].
     ^res
]	 

"    gets a set of possible world values for a variable given the possible worlds "
WorkingMemory get: variableName inWorlds: possibleWorlds
[
    | pwVals |
    pwVals := Set new.
    possibleWorlds do: [:wld | pwVals add: ( self get: variableName inWorld: wld ) ].
    ^pwVals
] 

"    gets the property value of an object at the requested time 
     if time is not given, implies current time,
     if the time is past, just get the value, 
     if is future then generate a set of possible world values "
WorkingMemory get: variableName atTime: aTime
[
    | currTime res |
    res := false.
    currTime := currentWorld time.
    aTime ifTrue: [ aTime <= currTime
                        ifTrue: [res := self get: variableName inWorld: ( currentWorld getParentAtTime: aTime ) ]
		       ifFalse: [res := self get: variableName inWorlds: ( self getPossibleWorldsIn: ( aTime - currTime ) ) ] ]
         ifFalse: [res := self get: variableName inWorld: currentWorld].
    ^res
]

WorkingMemory get: variableName
[
    ^self get: variableName atTime: false
]

"    FIXME: not implemented
     returns collection of possible worlds nth time unit from now by trying all possible changes "
WorkingMemory getPossibleWorldsIn: timeStepsAhead
[
    ^OrderedCollection new
]

WorldModel withTime: aTime
[ 
    self := super new.
    time := aTime.
    children := IdentityDictionary new.
    variableValueBindings := IdentityDictionary new
]

WorldModel time
[
    ^time
]

WorldModel parent
[
    ^parent
]

WorldModel children
[
    ^children
]

WorldModel variableValueBindings
[
    ^variableValueBindings
]

WorldModel parent: p
[
    parent := p
]

WorldModel update: var toValue: val
[
      variableValueBindings at: var put: val
]

WorldModel getParentAtTime: aTime
[
    | targetWorld |
    targetWorld := self.
    [aTime < targetWorld time] whileTrue:
	   [targetWorld := targetWorld parent].
    ^targetWorld
]

" reduces cached stored children of a world (possible worlds n time unit from it) 
  by prunning all children except for the branch of the given world "
WorldModel pruneChildrenTo: pickedNextWorld
[
    | timeAhead |
    timeAhead := 2.
    [self children] at: 1 put: [OrderedCollection with: pickedNextWorld].
    [[self children] includesKey: timeAhead] WhileTrue:
        [ [self children] at: timeAhead
	                 put: [pickedNextWorld children] at: [timeAhead - 1].
	  timeAhead := timeAhead + 1 ]
]


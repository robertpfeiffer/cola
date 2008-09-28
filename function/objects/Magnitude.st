{ import: Objects }

Magnitude < aMagnitude	[ self subtypeResponsibility: #< ]
Magnitude = aMagnitude	[ self subtypeResponsibility: #= ]

Magnitude <= aMagnitude	[ ^(self < aMagnitude) or: [self = aMagnitude] ]
Magnitude ~= aMagnitude	[ ^(self = aMagnitude) not ]
Magnitude >= aMagnitude [ ^(self < aMagnitude) not ]
Magnitude >  aMagnitude [ ^(aMagnitude < self) ]

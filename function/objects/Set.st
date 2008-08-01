{ import: IdentitySet }

Set : IdentitySet ()

Set hashOf: anObject				[ ^anObject hash ]
Set compare: anEntry with: anObject		[ ^anEntry = anObject ]

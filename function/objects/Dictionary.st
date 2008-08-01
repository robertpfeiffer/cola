{ import: IdentityDictionary }

Dictionary : IdentityDictionary ()

Dictionary hashOf: anObject			[ ^anObject hash ]
Dictionary compare: anEntry with: anObject	[ ^anEntry key = anObject key ]

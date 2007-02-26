{ import: _object }

Object : _object ()					[ Object := _object ]	"alias"
  UndefinedObject : Object ()
  Magnitude : Object ()
    Date : Magnitude ( _seconds _microseconds )
    Time : Magnitude ( _seconds _nanoseconds )
    Number : Magnitude ()
      Float : Number ()
      Integer : Number ()
        SmallInteger : Integer ()
        LargeInteger : Integer ()
  Symbol : Object ( _size _elements )			[ Symbol := _selector ]	"alias"
  Association : Object ( key value )
  Collection : Object ()
    SequenceableCollection : Collection ()
      ArrayedCollection : SequenceableCollection ( size )
        Array : ArrayedCollection ( _oops )
        ByteArray : ArrayedCollection ( _bytes )
          String : ByteArray ()
      OrderedCollection : SequenceableCollection ( firstIndex lastIndex array )
    IdentitySet : Collection ( tally lists )
      IdentityDictionary : IdentitySet ()
        FastIdentityDictionary : IdentityDictionary ()
  SlotDictionary : Object ( _size _tally _keys _values default )
  StaticBlockClosure : Object ( _function _arity )
    BlockClosure : StaticBlockClosure ( outer state _nlr )
  SinkStream : Object ()
  ReadStream : Object ( collection position readLimit )
    WriteStream : ReadStream ( writeLimit )
    FileStream : ReadStream ( file )
    ConsoleFileStream : FileStream ( _prompt )
  File : Object ( _fd name )
  Function : Object ()
  Random : Object ( seed a m q r )
  Link : Object ( prevLink nextLink )
  LinkedList : Object ( firstLink lastLink )
  OS : Object ()

nil   : UndefinedObject ()
true  : Object ()
false : Object ()

{ pragma: type nil   nil   }
{ pragma: type true  true  }
{ pragma: type false false }

{ pragma: type character SmallInteger }
{ pragma: type integer   SmallInteger }
{ pragma: type float     Float }

{ pragma: type byteArray ByteArray }
{ pragma: type string String }

{ pragma: type symbol Symbol }
{ pragma: type objectArray Array }
{ pragma: type staticClosure StaticBlockClosure }
{ pragma: type fullClosure BlockClosure }

StdIn  := []
StdOut := []
StdErr := []

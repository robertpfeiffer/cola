{ import: Object }

{ include "sigalrm.h" }

ProfiledMethod : Object ( _method count next )

ProfiledMethods := [ nil ]

ProfiledMethod withMethod_: _mi
[
    {
	struct __methodinfo *mi= (struct __methodinfo *)v__mi;
	if (mi->meta) return (oop)mi->meta;
    }.
    self := self new.
    _method := _mi.
    count := 0.
    next := ProfiledMethods.
    ProfiledMethods := self.
    {
	struct __methodinfo *mi= (struct __methodinfo *)v__mi;
	mi->meta= (void *)self;
    }.
]

ProfiledMethod _method	[ ^_method ]
ProfiledMethod count	[ ^count ]
ProfiledMethod next	[ ^next ]

ProfiledMethod increment	[ count := count + 1 ]

ProfiledMethod do: unaryBlock
[
    | me |
    me := self.
    [ unaryBlock value: me.
      me := me next] whileTrue.
]

ProfiledMethod report
[
    | stream |
    self sort.
    stream := WriteStream on: (String new: 1024).
    self do: [:method | method reportOn: stream].
    ^stream contents
]

ProfiledMethod sort
[
    (next and: [next sort > count])
	ifTrue:
	   [self exchange: next.
	    next sort].
    ^count
]

ProfiledMethod exchange: other
[
    | _m c |
    _m := other _method.
    c  := other count.
    other setMethod_: _method count: count.
    _method := _m.
    count := c.
]

ProfiledMethod setMethod_: _m count: c
[
    _method := _m.
    count := c.
]

ProfiledMethod reportOn: aStream
[
    count printOn: aStream base: 10 width: 5 padded: $ .
    aStream
	space; nextPutAll: self type;
	space; nextPutAll: self name;
	cr.
    ^count
]

ProfiledMethod type	[ ^String value_: self _type ]
ProfiledMethod name	[ ^String value_: self _name ]

ProfiledMethod _type	{ _return((oop)((struct __methodinfo *)self->v__method)->type); }
ProfiledMethod _name	{ _return((oop)((struct __methodinfo *)self->v__method)->name); }

StaticBlockClosure statisticalProfile
[
    | methods |
    self perform: #profilerTick every: 0.01.
    self value.
    self perform: nil every: 0.
    methods := ProfiledMethods.
    ProfiledMethods := nil.
    ^methods
]

Object profilerTick
[
    | _mi mi |
    { if (!(v__mi= _libid->methodAt(1))) { _return(0); } }.
    mi := ProfiledMethod withMethod_: _mi.
    mi increment.
]

Object perform: aSymbol every: nSeconds
[
    | s us |
    s  := nSeconds asInteger.
    us := (nSeconds * 1000000) asInteger \\ 1000000.
    {
#     if !defined(WIN32)
	long s=  (long)v_s  >> 1;
	long us= (long)v_us >> 1;
	struct itimerval interval= { { s, us }, { s, us } };
	sigalrmReceiver= v_self;
	sigalrmSelector= v_aSymbol;
	signal(SIGALRM, sigalrm);
	setitimer(ITIMER_REAL, (v_aSymbol ? &interval : 0), 0);
#     endif
    }
]

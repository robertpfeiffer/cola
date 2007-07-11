{ import: Stream }

{ include <readline/readline.h }
{ include <readline/history.h }

ConsoleFileStream _atexit
{
    write_history(".jolt-history");
}

ConsoleFileStream refill
[
    | length _buffer _bytes |
    {
	static char *buffer= 0;
        static int   live= 1;
        if (!live)
	    { _return 0; }
	if (buffer)
	{
	    free(buffer);
	    buffer= 0;
	}
	else
	{
	    using_history();
	    stifle_history(1000);
	    read_history(".jolt-history");
	    atexit((void (*)(void))ConsoleFileStream___5fatexit);
	}
	buffer= readline((char *)self->v__prompt);
	if (!buffer) { _return (oop)(live= 0); }
	if (*buffer) add_history(buffer);
	v_length= (oop)((strlen(buffer) + 1) << 1 | 1);
	v__buffer= (oop)buffer;
    }.
    collection size < length ifTrue: [collection := collection new: length].
    _bytes := collection _bytes.
    {
	strcpy((char *)v__bytes, (char *)v__buffer);
    }.
    collection at: length - 1 put: $\n.
    position := 0.
    readLimit := length.
]

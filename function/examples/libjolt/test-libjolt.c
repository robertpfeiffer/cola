#include <stdio.h>
#include <assert.h>
#include "jolt.h"

typedef long (*libjolt_t) (const char *);

int
main (int argc, char **argv, char **envp)
{
    libjolt_t libjolt = (libjolt_t) libjolt_init (&argc, &argv, &envp);
    long two = libjolt ("(+ 1 1)");
    assert (two == 2);

    return 0;
}

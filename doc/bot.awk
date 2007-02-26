#!/usr/bin/awk -f

BEGIN {
    echo=0;
}

/<!--toc-->/ {
    echo=1;
    next;
}

{
    if (echo) print;
}

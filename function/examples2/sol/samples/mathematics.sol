{ sol-program }
start-world mathematics.
create calculator answer variable.
make calculator calc 1 1.
action calculator multiply-answer-and-increment-variable 
       consequence its answer = its answer * its variable and
       		   its variable = its variable + 1.
goal calculator factorial n try its variable = n + 1.
end-file.

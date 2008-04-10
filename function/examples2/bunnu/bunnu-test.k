{ bunnu-program }

println "; running";

var writeln = function (obj)
{
  #[StdOut nextPutAll: [obj asString]];
  #[StdOut cr];
};

writeln("I am writing to you!");

var foo;

for (foo = 0;  foo < 10;  foo = foo + 1)
{
  print "hello\t";
  println foo;
}

var add = function(x, y) { x + y; };

println add(3, 4);

foo = 0;
while (foo < 10) println foo = add(foo, 1);

var sum = function(n)
{
  var m;
  for (m = 0;  n > 0;  n = n - 1) m = m + n;
  m;
};

println sum(4);

var nfibs = function(n)
{
   if (n < 2)
     1;
   else 
     nfibs(n - 1) + nfibs(n - 2) + 1;
};

var time = function() #[Time millisecondClockValue];;

var then = time();
var result = nfibs(32);
var now = time();
println result;
print now - then;
println ' milliseconds';
print result / (now - then) / 1000;
println ' million calls per second';

function Test(x, y)
{
  println x;
  println y;
  println x;
  println y;
}

Test(42, 666);

#!/usr/bin/awk -f

BEGIN { h2=0; h3=0; h4=0; }

/<h2>/ {
	h2=h2+1;
	h3=0;
	h4=0;
	sub("<h2>","<h2>"h2"\\&nbsp;\\&nbsp;\\&nbsp;");
}

/<h3>/ {
	h3=h3+1;
	h4=0;
	sub("<h3>","<h3>"h2"."h3"\\&nbsp;\\&nbsp;\\&nbsp;");
}

/<h4>/ {
	h4=h4+1;
	sub("<h4>","<h4>"h2"."h3"."h4"\\&nbsp;\\&nbsp;\\&nbsp;");
}

{
	print
}

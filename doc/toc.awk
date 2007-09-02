#!/usr/bin/awk -f

BEGIN {
    print "<table cellpadding=\"0px\">"
}

/<h[0-9]>/ {
	sub(".*<h2>","<tr><td><b>");
	sub("</h2>","</b><tr><td>");
	sub(".*<h[0-9]>","<tr><td>");
	sub("</h[0-9]>.*","</td></tr>");
#	sub("\\&nbsp;\\&nbsp;\\&nbsp;","</td><td>\\&nbsp;\\&nbsp;\\&nbsp;");
	print;
}

{
	next;
}

END {
    print "</table>"
}

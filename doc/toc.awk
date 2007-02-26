#!/usr/bin/awk -f

/<h[0-9]>/ {
	sub(".*<h[0-9]>","");
	sub("</h[0-9]>.*","<br>");
	print;
}

{
	next;
}

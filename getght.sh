echo "echo \<html\>" > gencallght$$
go help |
gawk '
BEGIN{al =0;}
{
	if ($0~/Use "go help/){ al=0;};
	if ($0~/Additional help/){ al+=1; }
	if (al>=1 && ($0!~/Additional help/) && ($0!~/^$/)){
		print "echo \\<h2\\>TOPIC: ", $1 ,"\\</h2\\>";
		print "echo BEGINTAG";
		print "go help " $1 " ";
		print "echo ENDTAG";
	}
}
' >> gencallght$$
sh gencallght$$  \
 |	sed s@BEGINTAG@\<div\>\<pre\>@g  \
 |	sed s@ENDTAG@\</pre\>\</div\>\<hr\ /\>@g 
rm -f gencallght

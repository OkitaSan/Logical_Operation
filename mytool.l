%{
	#include <stdio.h>
	#include "mytool.tab.h"
%}
digit	[0-9]
%%
{digit}+ {
yylval.val = atoi(yytext);
return VALUE; 
}
[<] 	{
return LT;
}
[>] 	{
return GT;
}
"==" 	{
return EQ;
}
"!=" 	{
return NE;
}
">=" 	{
return GTEQ;
}
"<=" 	{
return LTEQ;
}
"&&" {
	return AND;
}
"||" {
	return OR;
}
"!" {
	return NOT;
}
"(" {
	return LPARAN;
}
")" {
	return RPARAN;
}
%%
int yywrap(void)
{
	return 1;
}
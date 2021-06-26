%{
	#include <stdio.h>
	#include "mytool.tab.h"
%}
digit	[0-9]
%%
{digit}+ {
yylval = atoi(yytext);
return VALUE; 
}
[<] 	{
yylval = *yytext;
return LT;
}
[>] 	{
yylval = *yytext;
return GT;
}
"==" 	{
yylval = *yytext;
return EQ;
}
"!=" 	{
yylval = *yytext;
return NE;
}
">=" 	{
yylval = *yytext;
return GTEQ;
}
"<=" 	{
yylval = *yytext;
return LTEQ;
}
"&&" {
	yylval = *yytext;
	return AND;
}
"||" {
	yylval = *yytext;
	return OR;
}
"!" {
	yylval = *yytext;
	return NOT;
}
"(" {
	yylval = *yytext;
	return LPARAN;
}
")" {
	yylval = *yytext;
	return RPARAN;
}
%%
int yywrap(void)
{
	return 1;
}
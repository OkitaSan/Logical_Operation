%{
	#include <stdio.h>
	#include "mytool.tab.h"
%}
digit	[0-9]
%%
{digit}+ {
yylval = *yytext;
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

%%
int yywrap(void)
{
	return 1;
}
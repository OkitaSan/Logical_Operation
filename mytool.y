%{
	#include <stdio.h>
	int yylex(void);  
	void yyerror(char const *);      
%}
%token VALUE
%token LT
%left LT
%token GT
%left GT
%token EQ
%left EQ
%token NE
%left NE
%token GTEQ
%left GTEQ
%token LTEQ
%left LTEQ
%%
S: R {{if($1)printf("Output: true.");else printf("Output: false."); return 0;}}
;
R: VALUE LT VALUE {$$ = ($1 < $3);}
| VALUE GT VALUE {$$ = ($1 > $3);}
| VALUE EQ VALUE {$$ = ($1 == $3);}
| VALUE NE VALUE {$$ = ($1 != $3);}
| VALUE GTEQ VALUE {$$ = ($1 >= $3);}
| VALUE LTEQ VALUE {$$ = ($1 <= $3);}
;
%%
int main()
{
	yyparse();
	return 0;
}
void yyerror(char const *msg)  
{  
    fprintf(stderr, "%s\n",msg);  
}  
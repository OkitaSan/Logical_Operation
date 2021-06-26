%{
	#include <stdio.h>
	int yylex(void);  
	void yyerror(char const *);
	int cmptimes = 0;
	int scantimes = 0;      
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
%token  GTEQ
%left GTEQ
%token LTEQ
%left LTEQ
%token AND
%left AND
%token OR
%left OR
%token LPARAN
%token RPARAN
%token NOT
%%
S: LogicalOr {{if($1)printf("Output: true.");else printf("Output: false."); return 0;}}
;
LogicalOr: LogicalAnd {$$ = ($1);}
| LogicalOr OR LogicalAnd {$$ = ($1 || $3);}
;
LogicalAnd: Single {$$ = ($1);}
| LogicalAnd AND Single {{$$ = ($1 && $3);}}
;
Single: R {$$ = ($1);}
| NOT LPARAN LogicalOr RPARAN {$$ = (!($3));}
| LPARAN LogicalOr RPARAN {$$ = ($2);}
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
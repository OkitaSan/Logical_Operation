%{
	#include <stdio.h>
	int yylex(void);  
	void yyerror(char const *);
	int cmptimes = 0;
	int scantimes = 0;
%}
%union {
	struct {
		int res;
		int exec;
		int whole;
	}res;
	int val;
}
%token <val> VALUE
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
%token END
%type <res> LogicalOr LogicalAnd Single
%type <val> R

%%
S: LogicalOr END {{if($1.res)printf("Output: true, %d",($1.whole - $1.exec));else printf("Output: false, %d",($1.whole - $1.exec)); return 0;}}
;
LogicalOr: LogicalAnd {$$.res = ($1.res);}
| LogicalOr OR LogicalAnd {
	$$.res = ($1.res || $3.res);
	$$.whole += $3.whole;
	if($1.res){ // shortcut
		$$.exec = $1.exec;
	}else{
		$$.exec = $1.exec + $3.exec;
	}
}
;
LogicalAnd: Single {
	$$.res = ($1.res);
	$$.exec = $1.exec;
	$$.whole = $1.whole;
}
| LogicalAnd AND Single {{
	$$.res = ($1.res && $3.res);
	$$.whole += $3.whole;
	if(!($1.res)){ // shortcut
		$$.exec = $1.exec;
	}else{
		$$.exec = $1.exec + $3.exec;
	}
}}
;
Single: R {
	$$.res = ($1);
	$$.whole = 1;
	$$.exec = 1;
}
| NOT LPARAN LogicalOr RPARAN {
	$$.res = (!($3.res));
	$$.whole = $3.whole;
	$$.exec = $3.exec;
}
| LPARAN LogicalOr RPARAN {
	$$.res = ($2.res);
	$$.whole = $2.whole;
	$$.exec = $2.exec;
}
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
    fprintf(stderr, "%s\n","Error.");  
}  
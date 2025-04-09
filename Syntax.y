%{
    #include <stdio.h>
    int nbl = 1;
    int yylex(void); // Declaration of yylex function
    int yyerror(char *msg);
%}

%start S
%token cnst aff idf pvg


%%

S: idf aff cnst pvg {printf("syntax correct"); YYACCEPT;}

%%

int main(){
    yyparse();
    return 0;
}
yywrap()
{}
int yyerror(char *msg){
    printf("erreur syntaxic met a la ligne %d;",nbl);
    return 1;
}
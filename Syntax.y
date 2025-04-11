%{
#include <stdio.h>
#include <stdlib.h>
#include "symbole.h"
void yyerror(const char *s);
%}

%union {
    int ival;
    char *strval;
}

%token MAINPRGM VAR BEGINPG ENDPG LET IDF IF THEN ELSE DO WHILE FOR FROM TO STEP INPUT OUTPUT
%token <strval> ID
%token <ival> INT

%%
programme : MAINPRGM IDF ';' VAR declarations BEGINPG '{' instructions '}' ENDPG { printf("Programme valide\n"); };

declarations : declaration declarations | declaration | /* epsilon */;

declaration : LET var_list ':' type pvg
             | LET var_list ':' '[' type pvg ENTIER ']' pvg
             | DEFINE CONST IDF ':' type '=' ENTIER pvg;

var_list: IDF ',' var_list | IDF;

type: INT | FLOAT;

instructions : instruction instructions | /* epsilon */;

instruction : affectation ';'
            | condition
            | boucle
            | io ';';

affectation : IDF AFF expression | IDF "[" ENTIER "]" AFF expression;

condition : IF '(' cheking ')' THEN '{' instructions '}' ELSE '{' instructions '}';

boucle : DO '{' instructions '}' WHILE '(' cheking ')' PVG;
       | FOR IDF FROM INT TO INT STEP ENTIER '{' instructions '}';

io : INPUT '(' IDF ')' pvg
   | OUTPUT '(' OP ')' pvg;

OP : OP2 |OP2,OP; 
OP2: STRING | IDF;

expression : REEL | REELS | ENTIER | ENTIERS | IDF | expression ADD expression | expression SUB expression
           | expression MUL expression | expression DIV expression;

cheking :  | expression AND expression | expression OR expression | NOT expression
           | expression GT expression | expression LT expression
           | expression GTE expression | expression LTE expression
           | expression EQ expression | expression NEQ expression;

          

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur syntaxique: %s\n", s);
}

int main() {
    return yyparse();
}
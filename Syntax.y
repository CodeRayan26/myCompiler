%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
%}

%union {
    int ival;
    char *strval;
}

%token MAINPRGM VAR BEGINPG ENDPG LET IDF IF THEN ELSE DO WHILE FOR FROM TO STEP INPUT OUTPUT
%token INT FLOAT CONST DEFINE 
%token REEL REELS STRING ENTIER ENTIERS

%token ADD SUB MUL DIV AFF
%token AND OR NOT
%token GT LT GE LE EQ NE 
%token PVG

%%
programme : MAINPRGM IDF ';' VAR declarations BEGINPG '{' instructions '}' ENDPG { printf("Programme valide\n"); };

declarations : declaration declarations | declaration | /* epsilon */;

declaration : LET var_list ':' type PVG
             | LET var_list ':' '[' type PVG ENTIER ']' PVG
             | DEFINE CONST IDF ':' type '=' ENTIER PVG;

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

io : INPUT '(' IDF ')' PVG
   | OUTPUT '(' OP ')' PVG;

OP : OP2 |OP2','OP; 
OP2: STRING | IDF;

expression : REEL | REELS | ENTIER | ENTIERS | IDF | expression ADD expression | expression SUB expression
           | expression MUL expression | expression DIV expression;

cheking :  expression AND expression | expression OR expression | NOT expression
           | expression GT expression | expression LT expression | expression EQ expression ;

          

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur syntaxique: %s\n", s);
}

int main() {
    return yyparse();
}
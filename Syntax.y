%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(YYLTYPE *loc,const char *s);
int nbl=1;
%}

%union {
    int ival;
    char *strval;
}
%start programme
%token MAINPRGM VAR BEGINPG ENDPG LET IDF IF THEN ELSE DO WHILE FOR FROM TO STEP INPUT OUTPUT
%token INT FLOAT CONST DEFINE 
%token REEL REELS STRING ENTIER ENTIERS

%token ADD SUB MUL DIV AFF
%token AND OR NOT
%token GT LT GE LE EQ NE 
%token PVG

%left OR
%left AND
%left NOT
%left EQ NE LT GT LE GE
%left ADD SUB
%left MUL DIV

%%
programme : MAINPRGM IDF ';' VAR declarations BEGINPG '{' instructions '}' ENDPG { printf("Programme valide\n"); };

declarations : declaration declarations | declaration | /* epsilon */;

declaration : LET var_list ':' type PVG
             | LET var_list ':' '[' type ';' ENTIER ']' PVG
             | DEFINE CONST IDF ':' type '=' value PVG;

var_list: IDF ',' var_list | IDF;

value : ENTIER | ENTIERS | REEL | REELS;

type: INT | FLOAT;

instructions : instruction instructions | /* epsilon */;

instruction : affectation ';'
            | condition
            | boucle
            | io ';';

affectation : IDF AFF expression | IDF "[" ENTIER "]" AFF expression;

condition : IF '(' cheking ')' THEN '{' instructions '}' ELSE '{' instructions '}';

boucle : DO '{' instructions '}' WHILE '(' cheking ')' PVG;
       | FOR IDF FROM expression TO expression STEP ENTIER '{' instructions '}';

io : INPUT '(' IDF ')' PVG
   | OUTPUT '(' OP ')' PVG;

OP : expression | STRING | OP ',' OP; 


expression : REEL | REELS | ENTIER | ENTIERS | IDF | IDF '[' EXPRESSION ']' expression ADD expression | expression SUB expression
           | expression MUL expression | expression DIV expression;

cheking :  expression AND expression | expression OR expression | NOT expression
           | expression GT expression | expression LT expression | expression EQ expression ;

          

%%

void yyerror(YYLTYPE *loc, const char *s) {
    fprintf(stderr, "Erreur syntaxique: %s\n", s);
}

int main() {
    return yyparse();
}
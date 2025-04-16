%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
int nbl=1;
%}

%union {
    int ival;
    float fval;
    char *strval;
}

%start programme
%token MAINPRGM VAR BEGINPG ENDPG LET IDF IF THEN ELSE DO WHILE FOR FROM TO STEP INPUT OUTPUT
%token INT FLOAT CONST DEFINE 
%token REEL REELS STRING ENTIER ENTIERS
%token EQUAL ERR

%token ADD SUB MUL DIV AFF
%token AND OR NOT
%token GT LT GE LE EQ NE 
%token VG DP PVG PO PF BRO BRF BO BF

%left OR
%left AND
%left NOT
%nonassoc EQ NE LT GT LE GE
%left ADD SUB
%left MUL DIV

%%
programme : MAINPRGM IDF PVG VAR declarations  BEGINPG BRO instructions BRF ENDPG PVG 
  { 
    printf("Programme valide\n");
    return 0; 
    };

declarations : declaration declarations | declaration | /* epsilon */;

declaration : LET var_list DP type PVG
             | LET var_list DP BO type PVG ENTIER BF PVG
             | DEFINE CONST IDF DP type EQUAL value PVG;

var_list: IDF VG var_list | IDF;

value : ENTIER | ENTIERS | REEL | REELS;

type: INT | FLOAT;

instructions : instructions instruction  | /* epsilon */;

instruction : affectation PVG
            | condition
            | boucle
            | io PVG;

affectation : IDF AFF expression | IDF BO ENTIER BF AFF expression;

condition : IF PO cheking PF THEN BRO instructions BRF ELSE BRO instructions BRF;

boucle : DO BRO instructions BRF WHILE PO cheking PF PVG;
       | FOR IDF FROM expression TO expression STEP ENTIER BRO instructions BRF;

io : INPUT PO IDF PF   
   | OUTPUT PO OP PF ;

 
 OP : IDF | STRING | OP VG OP2; 
 OP2 : IDF | STRING ;


expression : REEL | REELS | ENTIER | ENTIERS | IDF | IDF BO expression BF | expression ADD expression | expression SUB expression
           | expression MUL expression | expression DIV expression;

cheking :  expression AND expression | expression OR expression | NOT expression
           | expression GT expression | expression LT expression | expression EQ expression ;

          

%%
int main() {
    return yyparse();
}
void yyerror(const char *s) {
    fprintf(stderr, "Erreur syntaxique ligne %d: %s\n", nbl, s);
}


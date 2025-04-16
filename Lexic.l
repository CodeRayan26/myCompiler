%{
  #include "syntax.tab.h"
  extern int nbl;
%}


/* declaration des commentaires*/
cmnt1 "<!-".*"-!>"
cmnt2 "{--"(.|\n)*"--}"

/* declaration des regex de base*/
ltr [a-z] 
cfr [0-9]
pvg ";"
dp ":"
vg ","
string  \"[^\"]*\"

/*declaration des mot cle*/
mainprgm  "MainPrgm"
var       "Var"
begin     "BeginPg"
end       "EndPg"
let       "let"
int       "Int"
float     "Float"
const     "Const"
debutC    "@define"
cond      "if"
then      "then"
else      "else"
do        "do"
boucle    "while"
boucle2   "for"
from      "from"
to        "to"
stepping  "step"
read      "input"
write     "output"


/* declaration des valeure numerique*/
reel     {cfr}+\.{cfr}*
reels   \([+-]?{cfr}+\.{cfr}*\)
entier   {cfr}+
entiers \([+-]{cfr}+\)

/*declaration idf*/
idf {ltr}({cfr}|{ltr}|_)*

/* Opérateurs arithmétiques */
add       "+"
sub       "-"
mul       "*"
div       "/"
aff       ":="

/* Opérateurs logiques */
and     "AND"
or      "OR"
not     "!"

/* Opérateurs de comparaison */
gt        ">"
lt        "<"
ge        ">="
le        "<="
eq        "=="
ne        "!="

equal "="

/*partie instruction*/
po "("
pf ")"
bo "["
bf "]"
bro"{"
brf"}"




%%

{cmnt1} {printf(" Ligne %d est un commentaire;", nbl);}
{cmnt2} {
    /*i can't explain cmnt2 in a comment, if you didn't understand call me*/
    int newlines = 0;
    for(int i = 0; i < yyleng; i++){
        if(yytext[i] == '\n') newlines++;
    }
    printf(" De Ligne %d a %d est un multi commentaire;", nbl, nbl+newlines);
    nbl = nbl+newlines;
}

{mainprgm}    { printf("%s\n", yytext);return MAINPRGM; }
{var}         { printf("%s\n", yytext);return VAR; }
{begin}       { printf("%s\n", yytext);return BEGINPG; }
{end}         { printf("%s\n", yytext);return ENDPG; }
{let}         { printf("%s\n", yytext);return LET; }
{int}         { printf("%s\n", yytext);return INT; }
{float}       { printf("%s\n", yytext);return FLOAT; }
{const}       { printf("%s\n", yytext);return CONST; }
{debutC}      { printf("%s\n", yytext);return DEFINE; }
{cond}        { printf("%s\n", yytext);return IF; }
{then}        { printf("%s\n", yytext);return THEN; }
{else}        { printf("%s\n", yytext);return ELSE; }
{do}          { printf("%s\n", yytext);return DO; }
{boucle}      { printf("%s\n", yytext);return WHILE; }
{boucle2}     { printf("%s\n", yytext);return FOR; }
{from}        { printf("%s\n", yytext);return FROM; }
{to}          { printf("%s\n", yytext);return TO; }
{stepping}    { printf("%s\n", yytext);return STEP;}
{read}        { printf("%s\n", yytext);return INPUT; }
{write}       { printf("%s\n", yytext);return OUTPUT; }

{string}      { printf("%s\n", yytext);return STRING; }
{pvg}         { printf("%s\n", yytext);return PVG; }
{dp}          { printf("%s\n", yytext);return DP; }
{vg}          { printf("%s\n", yytext);return VG; }

{equal}       { printf("%s\n", yytext);return EQUAL; }

{idf} {
    if(yyleng > 14) {
        printf(" idf trop long;");
    }
    else {
        printf(" %s ", yytext);
        return IDF;
    }
}

{reel}       { printf("%s\n", yytext);return REEL; }
{reels}      { printf("%s\n", yytext);return REELS; }
{entier}     { printf("%s\n", yytext);return ENTIER; }
{entiers}    { printf("%s\n", yytext);return ENTIERS;}


{add}        { printf("%s\n", yytext);return ADD; }
{sub}        { printf("%s\n", yytext);return SUB; }
{mul}        { printf("%s\n", yytext);return MUL; }
{div}        { printf("%s\n", yytext);return DIV; }
{aff}        { printf("%s\n", yytext);return AFF; }



{not}        { printf("%s\n", yytext);return NOT; }
{and}        { printf("%s\n", yytext);return AND; }
{or}         { printf("%s\n", yytext);return OR; }

{gt}         { printf("%s\n", yytext);return GT; }
{lt}         { printf("%s\n", yytext);return LT; }
{ge}         { printf("%s\n", yytext);return GE; }
{le}         { printf("%s\n", yytext);return LE; }
{eq}         { printf("%s\n", yytext);return EQ; }
{ne}         { printf("%s\n", yytext);return NE; }



{po}         { printf("%s\n", yytext);return PO; }
{pf}         { printf("%s\n", yytext);return PF; }
{bo}         { printf("%s\n", yytext);return BO; }
{bf}         { printf("%s\n", yytext);return BF; }
{bro}        { printf("%s\n", yytext);return BRO; }
{brf}        { printf("%s\n", yytext);return BRF; }

[ \t]+ ;   {/* ignorer les espaces et tabulations */}
\n {nbl++; printf("\n");}

. {printf(" '%s' est une erreur à la ligne %d ;\n", yytext, nbl);}

%%

int yywrap(void) { return 1; }

%{
   int nbl;
%}


/* declaration des commentaires*/
cmnt1 "<!-".*"-!>"
cmnt2 "{--"(.|\n)*"--}"

/* declaration des regex de base*/
ltr [a-z] 
cfr [0-9]
pvg ";"


/*declaration des mot cle*/
mainprgm  "MainPrgm"
var       "var"
begin     "BeginPg"
end       "EndPg"
let       "let"
entier    "int"
reel      "float"
const     "const"
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
reel     {cfr}++"."{cfr}*
reels   \([+-]{cfr}++"."{cfr}*\)
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
gt         ">"
lt         "<"
ge         ">="
le         "<="
eq        "=="
ne        "!="

/*partie instruction*/
po "("
pf ")"
bo "["
bf "]"




%%

{cmnt1} {printf(" Ligne %d est un commentaire;", nbl);}
{cmnt2} {
    /*i can't explain cmnt2 in a comment, if you didn't understand call me*/
    int cmnt2 = 0;
    for(int i = 0; i < yyleng; i++){
        if(yytext[i] == '\n') cmnt2++;
    }
    printf(" De Ligne %d a %d est un multi commentaire;", nbl, nbl+cmnt2);
    nbl = nbl+cmnt2;
}

{mainprgm}    { printf("%s\n", yytext); }
{var}         { printf("%s\n", yytext); }
{begin}       { printf("%s\n", yytext); }
{end}         { printf("%s\n", yytext); }
{let}         { printf("%s\n", yytext); }
{entier}      { printf("%s\n", yytext); }
{reel}        { printf("%s\n", yytext); }
{const}       { printf("%s\n", yytext); }
{debutC}      { printf("%s\n", yytext); }
{cond}        { printf("%s\n", yytext); }
{then}        { printf("%s\n", yytext); }
{else}        { printf("%s\n", yytext); }
{do}          { printf("%s\n", yytext); }
{boucle}      { printf("%s\n", yytext); }
{boucle2}     { printf("%s\n", yytext); }
{from}        { printf("%s\n", yytext); }
{to}          { printf("%s\n", yytext); }
{stepping}    { printf("%s\n", yytext); }
{read}        { printf("%s\n", yytext); }
{write}       { printf("%s\n", yytext); }


{pvg}         { printf("%s\n", yytext); }

{idf} {
    if(yyleng > 14) printf(" idf trop long;");
    else printf(" %s idf;", yytext);
}

{reel}       { printf("%s\n", yytext); }
{reels}      { printf("%s\n", yytext); }
{entier}     { printf("%s\n", yytext); }
{entiers}    { printf("%s\n", yytext); }


{add}        { printf("%s\n", yytext); }
{sub}        { printf("%s\n", yytext); }
{mul}        { printf("%s\n", yytext); }
{div}        { printf("%s\n", yytext); }
{aff}        { printf("%s\n", yytext); }

{and}        { printf("%s\n", yytext); }
{or}         { printf("%s\n", yytext); }
{not}        { printf("%s\n", yytext); }

{gt}         { printf("%s\n", yytext); }
{lt}         { printf("%s\n", yytext); }
{ge}         { printf("%s\n", yytext); }
{le}         { printf("%s\n", yytext); }
{eq}         { printf("%s\n", yytext); }
{ne}         { printf("%s\n", yytext); }

{po}         { printf("%s\n", yytext); }
{pf}         { printf("%s\n", yytext); }
{bo}         { printf("%s\n", yytext); }
{bf}         { printf("%s\n", yytext); }

\n {nbl++; printf("\n");}

. {printf(" est une erreur;");}

%%

int yywrap(void) { return 1; }

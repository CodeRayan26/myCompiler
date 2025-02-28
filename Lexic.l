%{
    // c declaration
   
    int yywrap(void) { return 1; }
    int nbl = 1;

%}

/* declaration des commentaires*/
cmnt1 "<!-".*"-!>"
cmnt2 "{--"(.|\n)*"--}"

/* declaration des regex de base*/
ltr [a-zA-Z] /*prof 9atelna bli minuscules brk, rassim a9raa mlih mrakch 3ajbni*/
cfr [0-9]

/* declaration des valeure numerique*/
cfrs \([+-]{cfr}+\)
cnst {cfr}+

/* declaration des idf*/
idf {ltr}({ltr}|{cfr}|_)*





%%

{cmnt1} {printf(" Ligne %d est un commentaire", nbl);}
{cmnt2} {
    /*i can't explain cmnt2 in a comment, if you didn't understand call me*/
    int cmnt2 = 0;
    for(int i = 0; i < yyleng; i++){
        if(yytext[i] == '\n') cmnt2++;
    }
    printf(" De Ligne %d a %d est un multi commentaire", nbl, nbl+cmnt2);
    nbl = nbl+cmnt2;
}


{cfrs} {printf(" %s est un chiffre signee", yytext);}
{cnst} {printf(" %s cnst", yytext);}

{idf} {printf(" %s idf", yytext);}

\n {nbl++; printf("\n");}
. {printf(" est une erreur");}

%%

int main(){
    yylex();
    return 0;
}
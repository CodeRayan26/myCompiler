flex lexic.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -lfl -o L3_soft
L3_soft.exe<test.txt
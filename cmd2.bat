flex lexic.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -lfl -o compile
comp.exe<test.txt
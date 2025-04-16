flex lexic.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -lfl -o comp
comp.exe<test.txt
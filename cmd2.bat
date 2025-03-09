flex Lexic.l
bison -d Syntax.y
gcc lex.yy.c Syntax.tab.c -o myCompiler "C:\Program Files (x86)\GnuWin32\lib\libfl.a"
myCompiler.exe<test.txt
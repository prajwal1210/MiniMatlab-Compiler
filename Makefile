compiler.out : lex.yy.c y.tab.c ass5_15CS30043_translator.h ass5_15CS30043_translator.cxx ass5_15CS30043_target_translator.cxx
	g++ lex.yy.c -lfl -o 'compiler.out'

lex.yy.c : ass5_15CS30043.l
	flex ass5_15CS30043.l

y.tab.c : ass5_15CS30043.y
	bison ass5_15CS30043.y -o 'y.tab.c'


run1:  ass5_15CS30043_test1.c compiler.out
	./compiler.out ass5_15CS30043_test1.c

clean:
	rm -rf lex.yy.c y.tab.c compiler.out


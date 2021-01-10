main: createLex yaccIt compile

createLex: CS315f20_team18.lex
	lex CS315f20_team18.lex

yaccIt: CS315f20_team18.yacc
	yacc CS315f20_team18.yacc

compile: lex.yy.c
	gcc -o parser y.tab.c

clean:
	rm lex.yy.c y.tab.c parser 
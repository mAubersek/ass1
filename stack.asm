prog	START	0

	JSUB	sinit

	LDA	#123

	. push
	STA	@stkp
	JSUB	spush

	. pop
	JSUB	spop
	LDA	@stkp
	
halt	J	halt

. set stkp
sinit	STA	stkA
	LDA	#stk
	STA	stkp
	LDA	stkA
	RSUB

. increase stckp by 3 - word
spush	STA	stkA
	LDA	stkp
	ADD	#3
	STA	stkp
	LDA	stkA
	RSUB

. decrease stckp by 3
spop	STA	stkA
	LDA	stkp
	SUB	#3
	STA	stkp
	LDA	stkA
	RSUB

. used by stack
stkA	WORD	0 	
stkp	WORD	0
stk	RESW	1000

	END 	prog
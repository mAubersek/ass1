prog	START	0

	JSUB	sinit

	+LDA	#12
	JSUB	fact
	STA	ggg


halt	J	halt
ggg	RESW	2

fact	STL	@stkp
	JSUB	spush
	+STA	@stkp
	JSUB	spush

	. base case
	COMP	#1 
	JEQ	bc	

	SUB	#1
	JSUB	fact

bc	JSUB	spop
	+LDX	@stkp
	JSUB	spop
	LDL	@stkp

	MULR	X, A
	RSUB

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

	END	prog

loop	RD	#0xFA
	COMP	#10 . LF
	J	calc

	SUB	#48 . asci -> nr
	RMO	A, S	. S <- 2
	RMO	B, A	. A <- 1
	MUL	#10	. A <- 10
	ADDR	S, A	. A <_ 12
	RMO	A, B
	CLEAR	A
	J	loop

calc	RMO	A, B
	CLEAR	B
	CLEAR	S
	JSUB	fact
	J	loop
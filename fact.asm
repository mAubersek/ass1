prog	START	0

	JSUB	sinit

	. beremo 5x
	JSUB	read
	STA	@stkp
	JSUB	spush

	JSUB	read
	STA	@stkp
	JSUB	spush

	JSUB	read
	STA	@stkp
	JSUB	spush

	JSUB	read
	STA	@stkp
	JSUB	spush

	JSUB	read
	STA	@stkp
	JSUB	spush

halt	J	halt

. recursive
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

. reads from device FA, returns num in A
. clears registers B and S
read	CLEAR	A
	+RD	#0xFA
	COMP	#10 . LF
	JEQ	readEx

	. B holds previous value
	SUB	#48 	. asci -> [0..9]
	RMO	A, S
	RMO	B, A
	MUL	#10	. multiply previous number by 10
	ADDR	S, A	. add current digit
	RMO	A, B	. store in B
	J	read
readEx	RMO	B, A
	CLEAR	B	. cleanup
	CLEAR	S
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

. A holds a number
num	STA	tmpA

	RMO	A, X

	LDA	#digits
	STA	digPtr	

numL	RMO	X, A
	COMP	#0
	JEQ	write

	DIV	#10
	RMO	A, S	. S <- 123
	MUL	#10
	RMO	A, B	. B <- 1230
	RMO	X, A	. A <- 1234
	SUBR	B, A	. A <- 4

	RMO	S, X

	. increment digPtr
	STA	@digPtr
	LDA	digPtr
	ADD	#3
	STA	digPtr

	J	numL

. from digPtr to #digits
write	LDA	#digits	
	COMP	digPtr 
	JEQ	numEx

	LDA	digPtr
	SUB	#3
	STA	digPtr
	LDA	@digPtr
	ADD	#48
	WD	#1	
	J	write

numEx	LDA	tmpA
	RSUB	

nl	STA	tmpA
	LDA	#10
	WD	#1
	LDA	tmpA
	RSUB

. used by write
tmpA    RESW	1
tmpL	RESW	1

txt	BYTE	C'SIX/XE'
	BYTE	0

digits	RESW	5
digPtr	RESW	1

. used by stack
stkA	WORD	0 	
stkp	WORD	0
stk	RESW	1000

	END	prog
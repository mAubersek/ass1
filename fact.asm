prog	START	0

	JSUB	sinit

	. works up to fact(10)
main	JSUB	read
	COMP	#0
	JEQ	halt
	JSUB	fact
	JSUB	write
	J	main

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

	. after base case A contains 1
	. then multiply by each value on stack
bc	JSUB	spop
	MUL	@stkp
	JSUB	spop
	LDL	@stkp
	RSUB

. reads from device FA, returns num in A
read	CLEAR	B
	CLEAR	S

readLp	CLEAR	A
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
	J	readLp

readEx	RMO	B, A
	RSUB

. A holds a number
write	STL	@stkp
	JSUB	spush
	
wloop	RMO	A, B 	. B holds original value
	DIV	#10
	RMO	A, T	. this value will be used in next iteration
	MUL	#10
	RMO	A, S 	. temp save
	RMO	B, A
	SUBR	S, A	. a holds the digit

	. push digit to stack
	STA	@stkp
	JSUB	spush
	. increase len
	LDA	len
	ADD	#1
	STA	len

	RMO	T, A
	COMP	#0	. if next value is 0 continue to print
	JGT	wloop

print   JSUB	spop
	LDA	@stkp
	ADD	#48
	WD	#1
	TIX	len
	JLT	print

	LDA	#10
	WD	#1
	
	JSUB	spop
	LDL	@stkp
	RSUB
len	WORD	0

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
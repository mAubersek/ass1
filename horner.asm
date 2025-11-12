horner	START	0

	LDA	#in

loop	JSUB	calc
	ADD	#3
	COMP	#endIn
	JGT	halt
	J	loop

halt	J	halt

. A contains address
calc	STA	ptr

	LDA	@ptr
	ADD	#2
	MUL	@ptr
	ADD	#3
	MUL	@ptr
	ADD	#4
	MUL	@ptr
	ADD	#5
	STA	@ptr

	LDA	ptr
	RSUB
ptr	RESW	1

in      WORD 	0
	WORD	2
     	WORD 	5
endIn	WORD	42

	END	horner
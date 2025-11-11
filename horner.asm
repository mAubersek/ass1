horner	START	0

	LDA	x
	ADD	#2
	MUL	x
	ADD	#3
	MUL	x
	ADD	#4
	MUL	x
	ADD	#5
	STA	res

halt	J	halt

x	WORD	2
res     RESW	1

	END	horner
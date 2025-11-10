poly	START	0

	LDA	#4
	MUL	x
	ADD	res
	STA	res

	LDA	#3
	MUL	x
	MUL	x
	ADD	res
	STA	res

	LDA	#2
	MUL	x
	MUL	x
	MUL	x
	ADD	res
	STA	res

	LDA	#1
	MUL	x
	MUL	x
	MUL	x
	MUL	x
	ADD	res
	STA	res

halt	J	halt	

x	WORD	2
res     WORD	5

	END	poly
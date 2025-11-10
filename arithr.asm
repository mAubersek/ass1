arithr	START	0
	
	LDA	x
	LDB	y
	RMO	A, S

	ADDR	B, A
	STA	sum

	RMO	S, A
	SUBR	B, A
	STA	diff

	RMO	S, A
	MULR	B, A
	STA	prod

	RMO	S, A
	DIVR	B, A	. A / B -> A
	STA	quot

	.v A je še vedno quot
	MULR	B, A
	SUBR	A, S	. S - A -> S
	STS	mod

halt	J	halt

x       WORD   	22
y	WORD	5
sum	RESW	0
diff	RESW	1
prod	RESW	1
quot	RESW	1
mod	RESW	1
	END    	arithr
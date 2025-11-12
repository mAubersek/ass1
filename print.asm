print	START 	0

		+LDA	#txt
		STA	txtptr

loop	CLEAR	A
		LDCH	@txtptr
		COMP	#0
		JEQ	nl

		WD	#0xAA
		LDA	txtptr
		ADD	#1
		STA	txtptr
		J	loop

nl		LDA	#10
		WD	#0xAA

halt	J	halt

		ORG 	300
txt		BYTE	C'SIX/XE\n'
		BYTE	0
txtptr	WORD	0

		END	print
echo	START 0

		LDA #97
		JSUB char
		JSUB nl
		LDA #txt
		JSUB string
halt	J halt

nl		LDA	#10
		WD	#1

char	WD #1
		RSUB

string	STA	txtptr
sLoop	CLEAR A
		LDCH @txtptr
		COMP #0
		JEQ	sEnd

		WD	#1
		LDA txtptr
		ADD	#1
		STA	txtptr
		J sLoop
sEnd	RSUB	

num		


		ORG 	300
txt		BYTE	C'SIX/XE'
		BYTE	0
txtptr	WORD	0

		END		echo
echo	START 	0

	LDA 	#97	. a
	JSUB 	char
	JSUB 	nl

	LDA	#txt
	JSUB	string
	JSUB 	nl

	LDA	#1234
	JSUB	num

halt	J 	halt

. A holds a char code
char	WD 	#1
	RSUB

nl	STA	tmpA
	LDA	#10
	WD	#1
	LDA	tmpA
	RSUB

. A holds address of string
string	STA	tmpA
	STL	tmpL

	STA	ptr
strL	LDCH	@ptr
	COMP	#0
	JEQ	strEx
	JSUB	char
	. increment ptr
	LDA	ptr
	ADD	#1
	STA	ptr

	J	strL

strEx	LDA	tmpA
	LDL	tmpL
	RSUB

ptr 	RESW	1

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

tmpA    RESW	1
tmpL	RESW	1

txt	BYTE	C'SIX/XE'
	BYTE	0

digits	RESW	5
digPtr	RESW	1


	END	echo
prog	START	0

. S -> x coordinate
. T -> y coordinate
. A -> pixel address
. X -> pixel representation - iirrggbb

	LDS	#0
	LDT	#0
	LDX	#0xFF

render	JSUB	update
	JSUB	clcadr	. calculate address
	RMO	X, A
	STCH	@pixel	. draw pixel
	J	render

halt	J	halt



update	STL	tempL

	. check which key is pressed
	CLEAR	A
	LDCH	@key
	COMP	#0x44
	JEQ	right
	COMP	#0x53
	JEQ	down
	COMP	#0x41
	JEQ	left
	COMP	#0x57
	JEQ	up

right	RMO	S, A
	ADD	#1
	JSUB	out
	RMO	A, S
	J	chcEx

down	RMO	T, A
	ADD	#1
	JSUB	out
	RMO	A, T
	J	chcEx

left	RMO	S, A
	SUB	#1
	JSUB	out
	RMO	A, S
	J	chcEx

up	RMO	T, A
	SUB	#1
	JSUB	out
	RMO	A, T
	J	chcEx

chcEx	LDL	tempL
	RSUB

tempL	RESW	1


. checks if coordinate is out
. continues on opposite side
. same for x and y since display is square
. A holds value of x or y coordiante
out	COMP	width
	JGT	outgt
	COMP	#0
	JLT	outlt
	RSUB

outgt	CLEAR	A
	RSUB

outlt	LDA	width . A is 63
	RSUB


. calculate pixel address based on S and T
. updates pixel value
clcadr	RMO	T, A
	MUL	cols	. x * cols
	ADDR	S, A	. + x
	ADD	screen	. + origin
	STA	pixel
	RSUB

key	WORD	0xC000
dir	WORD	0	. right, down, up, left
pixel	RESW	1

width	WORD	63	. 0..63 = 64
cols	WORD	64
rows	WORD	64
screen	WORD	0xA000

	END	prog


. kaj rabim za snake game
. vedet moram kako zgleda snake
. torej kje je snake

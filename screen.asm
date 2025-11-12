scrn	START	0

	LDCH	#97
	JSUB	scrfill
	JSUB	scrclear

halt	J	halt

. A holds char
scrfill	STA	ch

scrclear LDA	screen
	STA	scrptr
	
loop	LDA	ch
	STCH	@scrptr
	
	LDA	scrptr
	ADD	#1
	STA	scrptr

	TIX	scrlen
	JLT	loop

	CLEAR	A    . cleanup for scrclear
	CLEAR	X
	STA	ch
	RSUB

scrptr	RESW	1
ch	WORD	0

screen	WORD	0xb800
scrcols	WORD	80
scrrows	WORD	25
scrlen	WORD	2000
	END	scrn 
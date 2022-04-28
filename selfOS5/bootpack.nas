[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_sprintf
	EXTERN	_io_hlt
	EXTERN	_io_load_eflags
	EXTERN	_io_cli
	EXTERN	_io_out8
	EXTERN	_io_store_eflags
	EXTERN	_hankaku
[FILE "bootpack.c"]
[SECTION .data]
LC0:
	DB	"ABC 123",0x00
LC1:
	DB	"SELF OS.",0x00
LC2:
	DB	"a=%d",0x00
LC3:
	DB	"cur:(%d, %d)",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	LEA	EBX,DWORD [-76+EBP]
	SUB	ESP,324
	CALL	_init_palette
	MOVSX	EAX,WORD [4086]
	PUSH	EAX
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_init_screen
	PUSH	LC0
	PUSH	7
	PUSH	8
	PUSH	8
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,36
	PUSH	LC1
	PUSH	0
	PUSH	31
	PUSH	31
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	PUSH	LC1
	PUSH	7
	PUSH	30
	PUSH	30
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,48
	PUSH	123
	PUSH	LC2
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	PUSH	7
	MOV	EBX,2
	PUSH	47
	PUSH	8
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,36
	MOVSX	EAX,WORD [4084]
	LEA	ECX,DWORD [-16+EAX]
	MOV	EAX,ECX
	CDQ
	IDIV	EBX
	MOV	ESI,EAX
	MOVSX	EAX,WORD [4086]
	PUSH	14
	LEA	ECX,DWORD [-44+EAX]
	MOV	EAX,ECX
	CDQ
	IDIV	EBX
	MOV	EDI,EAX
	LEA	EAX,DWORD [-332+EBP]
	PUSH	EAX
	CALL	_init_mouse_cursor8
	POP	EAX
	MOVSX	EAX,WORD [4084]
	SUB	EAX,16
	POP	EDX
	CMP	ESI,EAX
	JGE	L25
L20:
	PUSH	14
	LEA	EBX,DWORD [-332+EBP]
	PUSH	EBX
	CALL	_erase_lastmourse
	PUSH	16
	PUSH	EBX
	PUSH	EDI
	INC	EDI
	PUSH	ESI
	INC	ESI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,40
	PUSH	14
	PUSH	EBX
	CALL	_init_mouse_cursor8
	PUSH	16
	PUSH	EBX
	PUSH	EDI
	PUSH	ESI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,40
	XOR	ECX,ECX
L19:
	XOR	EDX,EDX
L18:
	MOV	EAX,99
L17:
	DEC	EAX
	JNS	L17
	INC	EDX
	CMP	EDX,999
	JLE	L18
	INC	ECX
	CMP	ECX,999
	JLE	L19
	MOVSX	EAX,WORD [4084]
	SUB	EAX,16
	CMP	ESI,EAX
	JL	L20
L25:
	PUSH	EDI
	LEA	EBX,DWORD [-76+EBP]
	PUSH	ESI
	PUSH	LC3
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	PUSH	7
	PUSH	63
	PUSH	8
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,40
L21:
	CALL	_io_hlt
	JMP	L21
[SECTION .data]
_table_rgb.0:
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-58
	DB	-58
	DB	-58
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	-124
	DB	-124
	DB	-124
[SECTION .text]
	GLOBAL	_init_palette
_init_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	_table_rgb.0
	PUSH	15
	PUSH	0
	CALL	_set_palette
	LEAVE
	RET
	GLOBAL	_set_palette
_set_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	EAX
	MOV	EBX,DWORD [8+EBP]
	MOV	EDI,DWORD [12+EBP]
	MOV	ESI,DWORD [16+EBP]
	CALL	_io_load_eflags
	MOV	DWORD [-16+EBP],EAX
	CALL	_io_cli
	PUSH	EBX
	PUSH	968
	CALL	_io_out8
	CMP	EBX,EDI
	POP	ECX
	POP	EAX
	JLE	L38
L40:
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_io_store_eflags
L38:
	MOV	AL,BYTE [ESI]
	INC	EBX
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [1+ESI]
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [2+ESI]
	SHR	AL,2
	ADD	ESI,3
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,24
	CMP	EBX,EDI
	JLE	L38
	JMP	L40
	GLOBAL	_boxfill8
_boxfill8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	ECX
	PUSH	ECX
	MOV	AL,BYTE [16+EBP]
	MOV	ECX,DWORD [24+EBP]
	MOV	EDI,DWORD [28+EBP]
	MOV	BYTE [-13+EBP],AL
	CMP	ECX,DWORD [32+EBP]
	JG	L53
	MOV	EBX,DWORD [12+EBP]
	IMUL	EBX,ECX
L51:
	MOV	EDX,DWORD [20+EBP]
	CMP	EDX,EDI
	JG	L55
	MOV	ESI,DWORD [8+EBP]
	ADD	ESI,EBX
	ADD	ESI,EDX
	MOV	DWORD [-20+EBP],ESI
L50:
	MOV	ESI,DWORD [-20+EBP]
	MOV	AL,BYTE [-13+EBP]
	INC	EDX
	MOV	BYTE [ESI],AL
	INC	ESI
	MOV	DWORD [-20+EBP],ESI
	CMP	EDX,EDI
	JLE	L50
L55:
	INC	ECX
	ADD	EBX,DWORD [12+EBP]
	CMP	ECX,DWORD [32+EBP]
	JLE	L51
L53:
	POP	EAX
	POP	EDX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_init_screen
_init_screen:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,12
	MOV	EAX,DWORD [16+EBP]
	MOV	EDI,DWORD [12+EBP]
	SUB	EAX,29
	DEC	EDI
	PUSH	EAX
	PUSH	EDI
	PUSH	0
	PUSH	0
	PUSH	14
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,28
	PUSH	EAX
	PUSH	EDI
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,27
	PUSH	EAX
	PUSH	EDI
	PUSH	EAX
	PUSH	0
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	PUSH	EDI
	SUB	EAX,26
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	ESI,DWORD [16+EBP]
	ADD	ESP,56
	SUB	ESI,24
	PUSH	ESI
	PUSH	59
	PUSH	ESI
	PUSH	3
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	DWORD [-16+EBP],EAX
	PUSH	2
	PUSH	ESI
	PUSH	2
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	DWORD [-16+EBP]
	PUSH	59
	PUSH	DWORD [-16+EBP]
	PUSH	3
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,5
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	PUSH	59
	SUB	EAX,23
	PUSH	EAX
	MOV	DWORD [-20+EBP],EAX
	PUSH	59
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,3
	MOV	DWORD [-24+EBP],EAX
	PUSH	EAX
	PUSH	59
	PUSH	EAX
	PUSH	2
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	PUSH	DWORD [-24+EBP]
	PUSH	60
	PUSH	ESI
	PUSH	60
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EDI,DWORD [12+EBP]
	ADD	ESP,56
	MOV	EBX,DWORD [12+EBP]
	SUB	EBX,4
	SUB	EDI,47
	PUSH	ESI
	PUSH	EBX
	PUSH	ESI
	PUSH	EDI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	PUSH	DWORD [-16+EBP]
	PUSH	EDI
	PUSH	DWORD [-20+EBP]
	PUSH	EDI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	DWORD [-24+EBP]
	PUSH	EBX
	PUSH	DWORD [-24+EBP]
	PUSH	EDI
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [12+EBP]
	PUSH	DWORD [-24+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	ESI
	PUSH	EAX
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putfont8
_putfont8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	MOV	EDI,DWORD [28+EBP]
	MOV	BL,BYTE [24+EBP]
L70:
	MOV	EAX,DWORD [20+EBP]
	MOV	EDX,DWORD [16+EBP]
	ADD	EAX,ESI
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [8+EBP]
	LEA	ECX,DWORD [EDX+EAX*1]
	MOV	DL,BYTE [ESI+EDI*1]
	TEST	DL,DL
	JNS	L62
	MOV	BYTE [ECX],BL
L62:
	MOV	AL,DL
	AND	EAX,64
	TEST	AL,AL
	JE	L63
	MOV	BYTE [1+ECX],BL
L63:
	MOV	AL,DL
	AND	EAX,32
	TEST	AL,AL
	JE	L64
	MOV	BYTE [2+ECX],BL
L64:
	MOV	AL,DL
	AND	EAX,16
	TEST	AL,AL
	JE	L65
	MOV	BYTE [3+ECX],BL
L65:
	MOV	AL,DL
	AND	EAX,8
	TEST	AL,AL
	JE	L66
	MOV	BYTE [4+ECX],BL
L66:
	MOV	AL,DL
	AND	EAX,4
	TEST	AL,AL
	JE	L67
	MOV	BYTE [5+ECX],BL
L67:
	MOV	AL,DL
	AND	EAX,2
	TEST	AL,AL
	JE	L68
	MOV	BYTE [6+ECX],BL
L68:
	AND	EDX,1
	TEST	DL,DL
	JE	L60
	MOV	BYTE [7+ECX],BL
L60:
	INC	ESI
	CMP	ESI,15
	JLE	L70
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putfonts8_asc
_putfonts8_asc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	EBX
	MOV	EBX,DWORD [28+EBP]
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [-13+EBP],AL
	MOV	ESI,DWORD [16+EBP]
	MOV	EDI,DWORD [20+EBP]
	CMP	BYTE [EBX],0
	JNE	L78
L80:
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L78:
	MOVZX	EAX,BYTE [EBX]
	SAL	EAX,4
	INC	EBX
	ADD	EAX,_hankaku
	PUSH	EAX
	MOVSX	EAX,BYTE [-13+EBP]
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	ADD	ESI,8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_putfont8
	ADD	ESP,24
	CMP	BYTE [EBX],0
	JNE	L78
	JMP	L80
[SECTION .data]
_cursor.1:
	DB	"**************.."
	DB	"*OOOOOOOOOOO*..."
	DB	"*OOOOOOOOOO*...."
	DB	"*OOOOOOOOO*....."
	DB	"*OOOOOOOO*......"
	DB	"*OOOOOOO*......."
	DB	"*OOOOOOO*......."
	DB	"*OOOOOOOO*......"
	DB	"*OOOO**OOO*....."
	DB	"*OOO*..*OOO*...."
	DB	"*OO*....*OOO*..."
	DB	"*O*......*OOO*.."
	DB	"**........*OOO*."
	DB	"*..........*OOO*"
	DB	"............*OO*"
	DB	".............***"
[SECTION .text]
	GLOBAL	_init_mouse_cursor8
_init_mouse_cursor8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	XOR	EBX,EBX
	PUSH	EDI
	XOR	EDI,EDI
	MOV	AL,BYTE [12+EBP]
	MOV	ESI,DWORD [8+EBP]
	MOV	BYTE [-13+EBP],AL
L94:
	XOR	EDX,EDX
L93:
	LEA	EAX,DWORD [EDX+EDI*1]
	CMP	BYTE [_cursor.1+EAX],42
	JE	L99
L90:
	CMP	BYTE [_cursor.1+EAX],79
	JE	L100
L91:
	CMP	BYTE [_cursor.1+EAX],46
	JE	L101
L88:
	INC	EDX
	CMP	EDX,15
	JLE	L93
	INC	EBX
	ADD	EDI,16
	CMP	EBX,15
	JLE	L94
	POP	ESI
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L101:
	MOV	CL,BYTE [-13+EBP]
	MOV	BYTE [EAX+ESI*1],CL
	JMP	L88
L100:
	MOV	BYTE [EAX+ESI*1],7
	JMP	L91
L99:
	MOV	BYTE [EAX+ESI*1],0
	JMP	L90
	GLOBAL	_erase_lastmourse
_erase_lastmourse:
	PUSH	EBP
	XOR	ECX,ECX
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	XOR	EBX,EBX
	PUSH	EAX
	MOV	AL,BYTE [12+EBP]
	MOV	ESI,DWORD [8+EBP]
	MOV	BYTE [-13+EBP],AL
L112:
	XOR	EDX,EDX
	LEA	EDI,DWORD [ESI+ECX*1]
L111:
	MOV	AL,BYTE [-13+EBP]
	INC	EDX
	MOV	BYTE [EDI],AL
	INC	EDI
	CMP	EDX,15
	JLE	L111
	INC	EBX
	ADD	ECX,16
	CMP	EBX,15
	JLE	L112
	POP	EAX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putblock8_8
_putblock8_8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	PUSH	EAX
	CMP	ESI,DWORD [16+EBP]
	JGE	L129
L127:
	XOR	EBX,EBX
	CMP	EBX,DWORD [20+EBP]
	JGE	L131
	MOV	ECX,DWORD [32+EBP]
	ADD	ECX,ESI
L126:
	MOV	EAX,DWORD [28+EBP]
	MOV	EDX,DWORD [24+EBP]
	ADD	EAX,EBX
	ADD	EDX,ESI
	IMUL	EAX,DWORD [12+EBP]
	MOV	EDI,DWORD [8+EBP]
	ADD	EAX,EDX
	MOV	DL,BYTE [ECX]
	INC	EBX
	MOV	BYTE [EAX+EDI*1],DL
	ADD	ECX,DWORD [36+EBP]
	CMP	EBX,DWORD [20+EBP]
	JL	L126
L131:
	INC	ESI
	CMP	ESI,DWORD [16+EBP]
	JL	L127
L129:
	POP	EAX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET

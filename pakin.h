_ldhlind				equ		4010h	; ld hl,(hl)
_textShadow           equ       0C0F9h	;holds text contents of home screen (21*8 bytes)
_conv_ahl			  equ		4633h	; decode ABS ahl, a = RAM page, hl = offset
_vputs				  equ		4AA5h	; display a string of variable width characters
_clrLCD				  equ		4A7Eh	; clear LCD screen
_clrScrn			  equ		4A82h	; clear LCD screen and _textShadow
_flushallmenus		  equ		49DCh	; clear the menu key stacks
_asm_exec_ram         equ       0D748h	;start address for all ASM programs
_penCol               equ       0C37Ch	; pen column
_penRow               equ       0C37Dh	; pen row

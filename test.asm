#include "pakin.h"

.org _asm_exec_ram

	nop
	jp ProgStart
	.dw 0
	.dw ShellTitle

ShellTitle:
	.db "test",0

ProgStart:

 ld hl,name-1
 rst 20h
 rst 10h
 ret c
 ex de,hl
 ld a,b
 call _conv_ahl
 add a,64
 out (5),a
 inc a
 out (6),a
 ld de,$c002
 add hl,de
 ld de,$CA00
 call DispRLE
 ld de,$FC00
 call DispRLE


 call OpenGray

loop:
 ld a,%111111
 out (1),a
 in a,(1)
 bit 6,a
 jr nz,loop

 ld a,$d
 out (5),a
 ld a,65
 out (6),a

 call CloseGray
 jp _clrScrn
 

#include "pakin_routines.h"

name:
 .db 8,"pakgraph"



.end

;  Pakin: Ballad of Fallen Angels RPG source code
;  by James Rubingh  http://wrive.com
;  Started on July 29, 2000

.plugin asm86
#include pakin.h
.org _asm_exec_ram
.dw 0c300h,ProgStart,0,ShellTitle
#include "pakin_routines.h"

;+----------------------------------------------------------------------------------------+
;|DONT STEAL MY CODE DAMMIT. STEALING IS BAD. AND DONT SELL MY GAME ON EBAY EITHER        |
;|    This was coded entirely while listening to "Belle and Sebastian", "Nick Drake",     |
;|      "Forest For the Trees", "the notwist", "coldplay" and "Hooverphonic."             |
;+----------------------------------------------------------------------------------------+

Buffer1 = $8000
Buffer2 = $8400
LevelData = $A800   ;~1000h bytes
Tiles = $8800

;reserved memory locations
map = _textShadow       ;which map in the level data to view
TL = _textShadow+1      ;top left corner of screen (the tile number)
LHEIGHT = _textShadow+3
LWIDTH = _textShadow+4
SpecialTableNum = _textShadow+5
SpecialTableLocation = _textShadow+6
X = _textShadow+8
Y = _textShadow+9
Direction = _textShadow+10  ;0 Right, 1 Down, 2 Left, 3 Up
keys = _textShadow+11
titleselection = _textShadow+11


ProgStart:
;   call _flushallmenus ;the game never uses big text, so who cares ... ?
    ld hl,$8000
    ld de,$8001
    ld bc,$83F          ;2 lcd buffers and a 64 byte tile
    ld (hl),0
    ldir
  ld (exit+1),sp        ;prepare for drunken exits ..

    ld hl,necessaryfiles-1
    ld b,4
testnecessaryfiles:
    push hl
    push bc
     rst 20h
     rst 10h
    pop bc
    pop hl
    ret c
    ld de,9
    add hl,de
    djnz testnecessaryfiles
  call OpenGray
  call clrlcd

;show title graphic, request action ...
  xor a
  call ShowPicture      ;show picture 0

  set 3,(iy+5)          ;display text white on black
  ld hl,continuetext
  ld bc,$0948
  call showtext
  ld hl,newgametext
  ld bc,$134f
  call showtext
  ld hl,exittext
  ld bc,$1d5a
  call showtext
  res 3,(iy+5)          ;invert the already inverted text colors ...
  
  ld c,0
  call invert_selection

title_keyloop:
  ld d,%1111
  call Delay
  ld a,-1
  out (1),a
  ld a,%1111110
  out (1),a
  in a,(1)
  bit 3,a
  jr z,title_up
  bit 0,a
  jr z,title_down
  ld a,%111111
  out (1),a
  in a,(1)
  bit 5,a
  jr z,title_select
 jr title_keyloop

title_down:
 call invert_selection
 inc c
 ld a,c
 cp 3
 jr z,title_maxed
finish_title_change
   call invert_selection
   jr title_keyloop
title_maxed:
 xor a
 ld c,a
  jr finish_title_change

title_up:
 call invert_selection
 ld a,c
 or a
 jr z,title_minimum
  dec c
   jr finish_title_change
title_minimum:
  ld c,2
  jr finish_title_change

invert_selection:
 ld a,c
 add a,c
 ld hl,title_mini_table+1
 add a,l
 ld l,a
 adc a,h
 sub l
 ld h,a
  ld a,(hl)             ;oh, this is just beautiful ... *tear rolls down cheek*
  dec hl
  ld l,(hl)
  or $fc
  ld h,a
 ld b,7
title_invert_loop_outside:
 push bc
   ld b,8
title_invert_loop:
    push bc
    ld a,(hl)
    cpl
    ld (hl),a
    inc hl
    pop bc
   djnz title_invert_loop
  ld de,8
  add hl,de
 pop bc
 djnz title_invert_loop_outside

 ret

title_mini_table
  .dw 152,312,472

showtext:
 ld (_penCol),bc
 jp _vputs

title_select:
 ld a,c
 cp 2
 jp z,exit
 dec a
 jr nz,continuegame

 ;-------========-------======--------======------======------========-----
newgamesetup:
 ld a,0
 ld (map),a         ;start on map 0
 ld hl,0            ;position the screen on the level
 ld (TL),hl
 ld a,1
 ld (Y),a
 inc a
 ld (X),a

 ld hl,tiles1-1
 call LoadTiles
 call LoadLevel
 jr main

continuegame:
 ld hl,tiles1-1
 call LoadTiles
 ld a,0
 ld (map),a
 call LoadLevel
 ld hl,14
 ld (TL),hl
 ld a,1
 ld (Y),a
 inc a
 ld (X),a
 ;jr main
  
main:
 ld a,-1
 out (1),a
 ld a,%111111
 out (1),a
 in a,(1)
 bit 6,a
 jp z,exit
 ld a,%1111110
   out (1),a
   in a,(1)
        ld (keys),a     ;save results for easy access :)
   bit 0,a
   call z,move_down
   ld a,(keys)
   bit 1,a
   call z,move_left
   ld a,(keys)
   bit 2,a
   call z,move_right
   ld a,(keys)
   bit 3,a
   call z,move_up
;   ld a,(keys)
;   bit 7,a
;   call z,status_menu

 call DrawScreen
 call ShowGuy
    ld hl,Buffer1       ;set up to copy Buffers (reduces the flicker)
    ld de,Gray1
    ld bc,$400
    ldir
    ;ld hl,Buffer2
    ld de,Gray2
    ld bc,$400
    ldir
 jr main

move_down:
 ld a,1
 ld (Direction),a

do_scroll_down:     ;shift screen up
 ld hl,(TL)
 ld a,(LWIDTH)
 call DivHlByA
 ld a,(LHEIGHT)
 sub 4
 cp l
 jr z,dont_try_scroll_down

  ld hl,(TL)
  ld de,LevelData
  add hl,de
  ld a,(LWIDTH)
  ld e,a
  ld d,0
  add hl,de
  add hl,de
  add hl,de
  add hl,de
  
    ld de,0         ;top left corner
    ld b,8          ;draw 8 tiles
Prepare_For_Down:
    push bc 
      ld b,(hl)
        push hl
        push de
          ex de,hl
          call DrawTileBatHL
        pop de
        pop hl
         inc de     ;move to next 16x16 area on vid mem
         inc de
         inc hl     ;move to next tile in LevelData
    pop bc
    djnz Prepare_For_Down

 ld b,16
 ld hl,0
ScrollDownCopyLine:
   push bc
   push hl
 ld hl,Gray1+16
 ld de,Gray1
 ld bc,$400-16
 ldir
 ld hl,Gray2+16
 ld de,Gray2
 ld bc,$400-16
 ldir

   pop hl
   push hl
 ld bc,Buffer1
 add hl,bc
 ld de,Gray1+$3F0
 ld bc,16
 ldir
   pop hl
   push hl
 ld bc,Buffer2
 add hl,bc
 ld de,Gray2+$3F0
 ld bc,16
 ldir
   pop hl
    ld bc,16
    add hl,bc
   pop bc
 djnz ScrollDownCopyLine
  ld hl,(TL)
  ld a,(LWIDTH)
  ld c,a
  ld b,0
  add hl,bc
  ld (TL),hl

 call DrawScreen
dont_try_scroll_down:
 ret


;-------
move_left:
 ld a,2
 ld (Direction),a


do_scroll_left:     ;shift screen right
 ld hl,(TL)
 ld a,(LWIDTH)
 call DivHlByA
 or a
 jp z,dont_scroll_left
   ld hl,(TL)
   ld de,LevelData-1
   add hl,de

   ld de,0
   ld b,4
Prepare_Scroll_Left:
  push bc
   ld b,(hl)
    push hl
    push de
    ex de,hl
      call DrawTileBatHL
    pop hl
    pop de
     inc h
;   ld bc,256
;   add hl,bc
      ex de,hl
      ld a,(LWIDTH)         ;next row down on the level map
      add a,l
      ld l,a
      adc a,h
      sub l
      ld h,a
  pop bc
  djnz Prepare_Scroll_Left

  ld c,16 
ScrollLeftLoopOutside:

  ld b,64
  ld hl,0
ScrollLeftLoop:
 push bc
 push hl
  ld bc,Gray1
  add hl,bc
  ex de,hl
 pop hl
 push hl
  ld bc,Buffer1
  add hl,bc
  rr (hl) \ inc hl \ rr (hl)
  ex de,hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl)
 pop hl
 push hl
  ld bc,Gray2
  add hl,bc
  ex de,hl
 pop hl
 push hl
  ld bc,Buffer2
  add hl,bc
  rr (hl) \ inc hl \ rr (hl)
  ex de,hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl) \ inc hl
  rr (hl) \ inc hl \ rr (hl)
 pop hl
 ld a,16
 add a,l
 ld l,a
 adc a,h
 sub l
 ld h,a

 pop bc
 dec b
 jp nz, ScrollLeftLoop

 dec c
 jp nz, ScrollLeftLoopOutside

 ld HL,(TL)
 dec hl
 ld (TL),HL
 call DrawScreen


dont_scroll_left:
 ret


;-------
move_right:
 xor a
 ld (Direction),a
do_scroll_right:    ;shift screen left
 ld hl,(TL)
 ld bc,8
 ld a,(LWIDTH)
 add hl,bc
 call DivHlByA
 or a  
 jp z,dont_scroll_right

  ld hl,(TL)
  ld bc,LevelData+8
  add hl,bc

   ld de,14
   ld b,4
Prepare_Scroll_Right:
  push bc
   ld b,(hl)
    push hl
    push de
    ex de,hl
      call DrawTileBatHL
    pop hl
    pop de
     inc h
;   ld bc,256
;   add hl,bc
      ex de,hl
      ld a,(LWIDTH)         ;next row down on the level map
      add a,l
      ld l,a
      adc a,h
      sub l
      ld h,a
  pop bc
  djnz Prepare_Scroll_Right

 ld c,16
ScrollRightLoopOuter:
 ld b,64
 ld hl,15
ScrollRightLoop:
 push bc
 push hl
  ld bc,Gray1
  add hl,bc
  ex de,hl
 pop hl
 push hl
  ld bc,Buffer1
  add hl,bc
  rl (hl) \ dec hl \ rl (hl)
  ex de,hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl)
 pop hl
 push hl
  ld bc,Gray2
  add hl,bc
  ex de,hl
 pop hl
 push hl
  ld bc,Buffer2
  add hl,bc
  rl (hl) \ dec hl \ rl (hl)
  ex de,hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl) \ dec hl
  rl (hl) \ dec hl \ rl (hl)
 pop hl
  ld a,16
  add a,l
  ld l,a
  adc a,h
  sub l
  ld h,a
 pop bc
 dec b
 jp nz,ScrollRightLoop

 dec c
 jp nz,ScrollRightLoopOuter 

  ld hl,(TL)
  inc hl
  ld (TL),hl


dont_scroll_right:
 ret


;-------
move_up:
 ld a,3
 ld (Direction),a
;test to see if scroll necessary ect.
do_scroll_up:       ;shift screen down
 ld hl,(TL)
 ld a,(LWIDTH)
 call DivHlByA
 ld a,h
 or l
 jr z,dont_try_scroll_up
    ld hl,(TL)
    ld a,(LWIDTH)
    ld e,a
    xor a
    ld d,a
    sbc hl,de
    ld de,LevelData
    add hl,de       ;next row up on level map

    ld de,0
    ld b,8
Prepare_For_Up:
    push bc 
      ld b,(hl)
        push hl
        push de
          ex de,hl
          call DrawTileBatHL
        pop de
        pop hl
         inc de
         inc de
         inc hl
    pop bc
    djnz Prepare_For_Up

  ld hl,$F0
  ld b,16
ScrollUpCopyLine:
  push bc
  push hl
 ld hl,Gray2+(16*63)-1
 ld de,Gray2+(16*64)-1
 ld bc,$400-16
 lddr
 ld hl,Gray1+(16*63)-1
 ld de,Gray1+(16*64)-1
 ld bc,$400-16
 lddr
   pop hl
   push hl
 ld bc,Buffer1
 add hl,bc
 ld bc,16
 ld de,Gray1
 ldir
   pop hl
   push hl
 ld bc,Buffer2
 add hl,bc
 ld de,Gray2
 ld bc,16
 ldir

  pop hl
   ld bc,-16
   add hl,bc
  pop bc
 djnz ScrollUpCopyLine

 ld hl,(TL)
 ld a,(LWIDTH)
 ld e,a
 xor a
 ld d,a
 sbc hl,de
 ld (TL),hl
 call DrawScreen

dont_try_scroll_up:     ;reached border of level data

 ret

ShowGuy:
 ret

DrawScreen:
 ld hl,(TL)
 ld bc,LevelData
 add hl,bc
 ex de,hl               ;de is the tile location top left 
 ld hl,0
 ld c,4
DrawingLoopCol_:
 ld b,8
DrawingLoopRow_:
 push bc
 push hl
 push de
  ex de,hl
  ld b,(hl)     ;ld b,(de)
  ex de,hl
  call DrawTileBatHL
 pop de
 pop hl
   inc de           ;next byte on level map
   inc hl           ;move over on the Screen
   inc hl
 pop bc
  djnz DrawingLoopRow_
    ld a,(LWIDTH)   ;move pointers to next line down
    sub 8
    add a,e
    ld e,a
    adc a,d
    sub e
    ld d,a
   ld a,240
   add a,l
   ld l,a
   adc a,h
   sub l
   ld h,a
   dec c
   jp nz,DrawingLoopCol_
 ret

DrawTileBatHL:  ;hl is an offset from 0
 push hl
 ld hl,Tiles
 ld c,l
 srl b
 rr c
 srl b
 rr c
 add hl,bc
 ex de,hl
 pop hl
 push hl
 ld bc,Buffer2
 add hl,bc
 call CopyPlane
 pop hl
 ld bc,Buffer1
 add hl,bc
CopyPlane:
 ld b,16
CopyPlane2:
 ld a,(de)
 ld (hl),a
 inc de
 inc hl
 ld a,(de)
 ld (hl),a
 inc de
 ld a,15
 add a,l
 ld l,a
 adc a,h
 sub l
 ld h,a
 djnz CopyPlane2
 ret

LoadTiles:
; input:    HL = FIND_SYM style name of level data string
; intended output:  LevelData = correct map
;                   Width and Height = correct values
 rst 20h        ;hl already equals name of variable
 rst 10h
 ld a,b
 ex de,hl           ;AHL now equals location of paktiles.86s
 call _conv_ahl
 add a,64
 out (5),a
 ld a,65            ;rst 10h changes (5) 
 out (6),a
 ld de,$c002
 add hl,de
 ld c,(hl)
 call inchl1
 ld b,(hl)
 call inchl1
 ld de,Tiles+$40
 call move          ;the tiles have been loaded
 ld bc,$1AC0
 ld de,Tiles+$540   ;copy the next tile to the 21st spot
 call move
 jp reset5and6

LoadLevel:
 ld hl,leveldata-1
 rst 20h
 rst 10h
 ex de,hl
 ld a,b
 call _conv_ahl
 add a,64
 out (5),a
 ld a,65            ;rst 10h messes up 
 out (6),a
 ld de,$c002
 add hl,de
 ld a,(map)
 call GetLevelPointerAndSize
 ld de,LevelData
 call move
  ex de,hl
  ld de,6
  ld a,(SpecialTableNum)
  or a
  jr z,skiplocatespecialtable
  ld b,a
locatespecialtable:
   sbc hl,de
   djnz locatespecialtable 
skiplocatespecialtable:
  ld (SpecialTableLocation),hl
 jp reset5and6

GetLevelPointerAndSize:
 ;get the length of the level data to move (plus point to it)
 add a,a
 ld b,a
 or a
 jr z,SkipTheIncreaseLevelPointer
GetLevelPointer:
 call inchl1
 djnz GetLevelPointer
SkipTheIncreaseLevelPointer:
 ld c,(hl)
 call inchl1
 ld b,(hl)
 call inchl1
SkipLevelsLoop:
 call inchl1
 dec bc
 ld a,c
 or b
 jr nz,SkipLevelsLoop
 ld a,(hl)
 ld (LHEIGHT),a
 call inchl1
 ld a,(hl)
 ld (LWIDTH),a
 call inchl1
 ld a,(hl)
 ld (SpecialTableNum),a ;how many special tiles
 call inchl1
 ld c,(hl)
 call inchl1
 ld b,(hl)
 jp inchl1

ShowPicture:
 push af
 ld hl,graphics-1
 rst 20h
 rst 10h
 ex de,hl
 ld a,b
 call _conv_ahl
 add a,64
 out (5),a
 inc a
 out (6),a
 ld de,$c002
 add hl,de
 pop af
 add a,a
 add a,l
 ld l,a
 adc a,h
 sub l
 ld h,a
 ld e,(hl)
 inc hl
 ld d,(hl)
 add hl,de
 ld de,$Ca00
 call DispRLE
 ld de,$fc00
 call DispRLE
 jp reset5and6

move:
 ;move data from (5) page to somewhere else
 ;flip the page if you get to the end though! that's the special part
 ld a,(hl)
 ld (de),a
 call inchl1
 inc de
 dec bc
 ld a,b
 or c
 jr nz,move
 ret

inchl1:
 inc hl
 bit 7,h
 ret z
  ld h,$40
    in a,(5)
    inc a
    out (5),a
  ret

reset5and6:
 ld a,$d
 out (5),a
 ld a,$41
 out (6),a
 ret
  
DivHlByA:
 ld b,16
 ld c,a
 xor a
Div_Loop:
 add hl,hl
 rla
 cp c
 jp c,Div_Skip
 sub c
 inc l
Div_Skip:
 djnz Div_Loop
 ret

Delay:
 ;push de
 halt
 dec d
 jr nz,Delay
 ;pop de
 ret

clrlcd:
 ld hl,$ca00
 ld de,$ca01
 ld (hl),0
 ld bc,$400-1
 ldir
 ld hl,$fc00
 ld de,$fc01
 ld (hl),0
 ld bc,$400-1
 ldir
 ret

exit:
  ld sp,420
  call CloseGray
  jp _clrScrn
  ;ret

#include guy.gfx

necessaryfiles:
tiles1:
 .db 8,"paktiles"
leveldata:
 .db 8,"paklevel"
graphics:
 .db 8,"pakgraph"
textdata:
 .db 8,"pakdialg"

ShellTitle:
.db "Pakin: Fallen Angels",0
continuetext:
 .db "Continue Game",0
newgametext:
 .db "New Game",0
exittext:
 .db "Exit",0


; Basic Memory map: (delete later?)
;   $8000 = buffer1     [400h]
;   $8400 = buffer2     [400h]
;   $8800 = tiles       [2000h] - 128 tiles
;   $a800 = leveldata   [1000h] - 4000 bytes
;   $ca00 = Bitplane 1  [400h]
;   $fc00 = Bitplane 0  [400h]
.end

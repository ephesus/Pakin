.plugin string86

.org 0

.dw Map0DataStart-2
.dw Map1DataStart-4
.dw Map2DataStart-6

Map0DataStart:
.db MAP_HEIGHT_0	;height by tiles
.db	MAP_WIDTH_0	;width by tiles
.db (Special0End-Special0)/6
.dw Map0DataEnd-Map0count
Map0count:

.db 47,47,47,29,29,29,8
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,4,4

.db 47,47,47,28,75,28,7
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,1,4,1,1
.db 1,1,27,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,26,4,1,1
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,1,1,4,1,1
.db 1,1,1,27,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,1,4,1,1
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,26,4,1,1
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,4,1,1,1
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

.db 1,1,1,4,1,1,1
.db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4

Special0:
 .dw 26
 .db 0,1	;0 signifies open new map. 1 signifies map 1
 .dw 0		;tile

Special0End:
Map0DataEnd:

Map1DataStart
.db MAP_HEIGHT_1
.db	MAP_WIDTH_1
.db (Special1End-Special1)/6	;number of specials
.dw Map1DataEnd-Map1count
Map1count:
 .db 40,41,41,41,41,41,41,41,42

 .db 39,23,5,10,10,10,48,10,43

 .db 39,22,5,10,10,10,10,10,43

 .db 39,10,10,10,10,10,10,10,43

 .db 39,10,10,10,10,10,10,10,43
;  the eleven here is tile 46
 .db 39,11,12,10,10,10,10,10,43

 .db 38,37,37,37,37,37,37,37,44
Special1:
 .dw 46
 .db 0,0		;open map 0
 .dw (22*0)+1	;tile
   .dw 47
   .db 1,0	;1 signifies talk, 0 signifies conversation 0
   .dw 0
 .dw 52
 .db 0,2
 .dw 9
Special1End:
Map1DataEnd:

Map2DataStart
.db MAP_HEIGHT_2
.db	MAP_WIDTH_2
.db (Special2End-Special2)/6
.dw Map2DataEnd-Map2count
Map2count:
 .db 00,00,01,31,31,31,01,01,01

 .db 00,00,01,31,31,31,08,01,01

 .db 00,01,01,30,76,30,07,01,01

 .db 00,00,01,01,01,01,01,01,01

 .db 50,51,52,53,06,55,56,57,50

 .db 52,53,54,55,06,56,57,50,51


Special2:
 .dw 8
 .db 0,1	;open map 0, set TILE to 23
 .dw 0

Special2End:
Map2DataEnd:


MAP_HEIGHT_0 = 8
MAP_WIDTH_0  = 22
MAP_HEIGHT_1 = 7
MAP_WIDTH_1  = 9
MAP_HEIGHT_2 = 6
MAP_WIDTH_2  = 9
.end

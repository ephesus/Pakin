.plugin string86

.org 0

.dw Pic1-1  ;add to current location Pic1-1 (currently pointer points to second byte...)

Pic1:
 .db $91,$FF,$30,$F8,$FF,$6F,$91,$FF,$0D,$FD,$3F,$EB,$91,$FF,$0D,$FE
 .db $EF,$E3,$91,$FF,$0E,$AB,$F1,$7F,$91,$FF,$0D,$92,$F2,$3F,$91,$FF
 .db $0D,$C4,$F1,$1F,$91,$FF,$0D,$E3,$18,$0F,$91,$FF,$0D,$F0,$94,$4F
 .db $3F,$91,$FF,$0C,$FC,$C5,$06,$FA,$91,$FF,$0C,$FE,$30,$42,$5D,$91
 .db $FF,$0D,$04,$93,$06,$7F,$91,$FF,$0C,$E2,$24,$40,$91,$FF,$0C,$F3
 .db $FD,$BB,$94,$91,$FF,$0C,$E8,$FE,$70,$0D,$3F,$91,$FF,$0B,$E0,$7F
 .db $F7,$BF,$5F,$91,$FF,$0B,$FC,$38,$11,$E7,$8F,$91,$FF,$0B,$EF,$31
 .db $E1,$FD,$07,$91,$FF,$0B,$D7,$FE,$71,$FE,$D3,$91,$FF,$0B,$AF,$FF
 .db $D8,$FF,$49,$91,$FF,$0B,$1F,$E7,$F1,$E7,$E4,$91,$FF,$0A,$FE,$7F
 .db $E3,$FD,$F1,$A4,$91,$FF,$0A,$FC,$FF,$F1,$FE,$E7,$F0,$91,$FF,$0A
 .db $F9,$7F,$F8,$06,$6A,$F4,$91,$FF,$0A,$F1,$04,$3E,$03,$38,$C9,$91
 .db $FF,$0A,$F8,$4C,$7F,$C9,$0E,$13,$91,$FF,$0A,$FE,$7D,$FF,$FC,$03
 .db $B8,$91,$FF,$0A,$FE,$73,$FF,$E6,$20,$7C,$7F,$91,$FF,$0A,$E7,$FF
 .db $CC,$10,$12,$5F,$91,$FF,$0A,$DF,$FF,$C7,$00,$69,$8F,$91,$FF,$09
 .db $FE,$3F,$FF,$C1,$08,$2C,$41,$91,$FF,$09,$FE,$79,$FF,$C1,$86,$30
 .db $78,$91,$FF,$09,$F9,$F3,$FF,$81,$4D,$59,$84,$91,$FF,$09,$F7,$E7
 .db $FF,$C0,$00,$43,$34,$7F,$91,$FF,$08,$E7,$C7,$FF,$F0,$00,$87,$8A
 .db $7F,$91,$FF,$09,$DF,$FF,$F8,$00,$01,$0E,$7F,$91,$FF,$0B,$FE,$03
 .db $18,$03,$7F,$91,$FF,$09,$7F,$FF,$FF,$00,$52,$B3,$7F,$91,$FF,$09
 .db $3F,$FF,$FF,$0F,$82,$91,$91,$01,$7F,$91,$FF,$09,$7F,$FF,$FF,$FC
 .db $E2,$6D,$91,$FF,$0E,$BC,$07,$91,$FF,$0E,$CF,$6D,$91,$FF,$09,$FC
 .db $91,$FF,$04,$FD,$DF,$91,$FF,$09,$FD,$91,$FF,$4F,$F8,$3F,$FF,$E7
 .db $FF,$F0,$3F,$91,$FF,$09,$FD,$CF,$C7,$EF,$FF,$FB,$FF,$E6,$FF,$FF
 .db $FE,$91,$FF,$03,$DF,$FF,$FE,$CF,$EF,$FF,$FF,$FD,$FF,$EE,$91,$FF
 .db $03,$7F,$FF,$FF,$DF,$FF,$FE,$EF,$EF,$FF,$FF,$FD,$FF,$EE,$91,$FF
 .db $03,$3F,$FF,$FF,$DF,$FF,$FE,$CB,$2E,$C8,$3D,$FD,$B4,$6E,$FA,$0F
 .db $FD,$B1,$7F,$7C,$DC,$FF,$FF,$DD,$69,$EC,$DF,$FF,$BA,$EE,$E9,$37
 .db $FF,$BB,$B7,$34,$DB,$7F,$FE,$FE,$EF,$ED,$DF,$FD,$FD,$EE,$DF,$77
 .db $FC,$BB,$B3,$AF,$DC,$FF,$FE,$FB,$61,$ED,$DF,$FD,$F6,$EE,$DF,$77
 .db $FB,$9B,$BB,$EF,$DC,$7F,$FE,$FB,$6C,$ED,$DF,$FD,$F6,$EE,$EF,$77
 .db $FF,$CB,$BB,$F7,$DB,$7F,$F8,$FD,$A6,$C0,$8D,$F1,$F9,$0C,$60,$23
 .db $E7,$C1,$10,$70,$88,$91,$FF,$0D,$F7,$BF,$91,$FF,$0E,$F7,$BF,$91
 .db $FF,$0E,$F1,$7F,$91,$FF,$12

 .db $91,$FF,$32,$9F,$91,$FF,$0D,$FE,$FF,$C7,$91,$FF,$0E,$1F,$F1,$91
 .db $FF,$0E,$C7,$F8,$91,$FF,$0E,$E1,$FC,$7F,$91,$FF,$0D,$F8,$7E,$3F
 .db $91,$FF,$0D,$FC,$3F,$1F,$91,$FF,$0E,$0F,$8F,$91,$FF,$0E,$03,$87
 .db $1D,$91,$FF,$0D,$C1,$87,$8C,$91,$FF,$0D,$F8,$60,$CC,$91,$FF,$0D
 .db $FC,$78,$E6,$7F,$91,$FF,$0B,$EF,$FE,$7C,$62,$7F,$91,$FF,$0B,$F7
 .db $FF,$FF,$F2,$7F,$91,$FF,$0E,$C0,$3F,$91,$FF,$0B,$F3,$FF,$FF,$F8
 .db $1F,$91,$FF,$0B,$F0,$FE,$1F,$FE,$CF,$91,$FF,$0B,$EF,$FF,$8F,$FF
 .db $27,$91,$FF,$0B,$DF,$FF,$E7,$FF,$B3,$91,$FF,$0D,$FE,$FF,$99,$91
 .db $FF,$0D,$FE,$6F,$D9,$91,$FF,$0E,$39,$CD,$91,$FF,$0E,$9D,$C9,$91
 .db $FF,$0E,$C7,$E1,$91,$FF,$0B,$B3,$FF,$FF,$F1,$E1,$91,$FF,$0B,$83
 .db $FF,$FF,$FC,$01,$91,$FF,$0B,$8F,$91,$FF,$03,$80,$91,$FF,$0B,$1F
 .db $FF,$F3,$FF,$EC,$3F,$91,$FF,$0A,$3F,$FF,$F8,$FF,$F6,$07,$91,$FF
 .db $0C,$FE,$FF,$F3,$83,$91,$FF,$0C,$FE,$7F,$FF,$81,$91,$FF,$0C,$FE
 .db $B3,$FF,$F8,$91,$FF,$0E,$FC,$F8,$91,$FF,$0E,$78,$7C,$91,$FF,$0E
 .db $FE,$7C,$91,$FF,$0E,$E7,$FC,$91,$FF,$0E,$ED,$CC,$91,$FF,$0D,$F0
 .db $7D,$EE,$91,$FF,$0E,$1D,$F2,$91,$FF,$0E,$C3,$F9,$91,$FF,$0E,$F0
 .db $9F,$91,$FF,$0E,$FE,$3F,$91,$FF,$5B,$EF,$EF,$91,$FF,$03,$EE,$91
 .db $FF,$06,$DF,$FF,$FC,$1F,$EF,$FF,$FF,$F8,$1F,$CC,$91,$FF,$03,$7F
 .db $FF,$FF,$DF,$FF,$FD,$EF,$EF,$FF,$FF,$FB,$FF,$EE,$FF,$FF,$FE,$7F
 .db $FF,$FF,$DF,$FF,$FD,$EF,$EF,$FF,$FF,$FB,$FF,$EE,$FF,$FF,$FD,$7F
 .db $FC,$FF,$DF,$FF,$FD,$EC,$6D,$ED,$9D,$FB,$F8,$EE,$E1,$67,$FF,$3A
 .db $3B,$31,$DB,$7F,$FC,$1B,$AF,$ED,$DF,$F8,$77,$6E,$DD,$77,$FD,$B9
 .db $BB,$6E,$DB,$FF,$FD,$FF,$23,$ED,$DF,$FB,$FE,$6E,$C7,$77,$FB,$1B
 .db $BB,$61,$D9,$FF,$FD,$FD,$AB,$ED,$DF,$FB,$FB,$6E,$DF,$77,$FF,$DB
 .db $BA,$6F,$DE,$7F,$FD,$FB,$AD,$ED,$DF,$FB,$F7,$6E,$CD,$77,$F7,$DB
 .db $BF,$E6,$DF,$7F,$FC,$F8,$0C,$ED,$DD,$F9,$F0,$66,$E3,$77,$F7,$CB
 .db $B8,$31,$DB,$7F,$91,$FF,$1C,$F7,$91,$FF,$0F,$F8,$91,$FF,$13

.end
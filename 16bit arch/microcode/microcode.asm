#bits 32
; register save and load
RAS = 1 << 0
RAL = 1 << 1
RBS = 1 << 2
RBL = 1 << 3
PCS = 1 << 4
PCL = 1 << 5
SBS = 1 << 6
SBL = 1 << 7
SPS = 1 << 8
SPL = 1 << 9
RCS = 1 << 10
RCL = 1 << 11
RDS = 1 << 12
RDL = 1 << 13
RIS = 1 << 14
TMS = 1 << 15
TML = 1 << 21
; register address bus
RAA = 0 << 16
RBA = 1 << 16
PCA = 2 << 16
SBA = 3 << 16
SPA = 4 << 16
RCA = 5 << 16
RDA = 6 << 16
TMA = 7 << 16
; save[addresss] or load[address]
STA = 1 << 19
LDA = 1 << 20
; misc
CNT = 1 << 22
HLT = 1 << 23
; alu ops
;FEQ = 1 << 24  ;Flag EQual
;FGT = 1 << 25 ;Flag Greater Than
;FC = 1 << 26  ;Flac Carry
;FZ = 1 << 27  ;Flag Zero
FRS = 1 << 31 ;Flag Register Save
PCO = 1 << 29 ;Program Counter Operation (replace REG A with PC)
CLPC = 1 << 28;Conditional Load Program COunter
ADD = 1  << 24
SUB = 2  << 24
INC = 3  << 24
DEC = 4  << 24
AND = 5  << 24
OR  = 6  << 24
NOT = 7  << 24
XOR = 8  << 24
SHL = 9  << 24
SHR = 10 << 24
NEG = 12 << 24
MUL = 11 << 24

#ruledef {
	done {value} => value`32
	done => 0`32
	exec {value} => (value | 1 << 22)`32
	fetch => asm {
		exec PCO | INC | PCS
		done PCA | LDA | RIS
	}
}
nop:
	fetch

#addr 8
hlt:
	exec HLT
	fetch
#addr 16
add:
	exec ADD | RAS
	fetch
#addr 24
addi:
	exec PCO | INC | PCS
	exec RBL | TMS
	exec PCA | LDA | RBS
	exec ADD | RAS
	exec TML | RBS
	fetch
#addr 32
sub:
	exec SUB | RAS
	fetch
#addr 40
subi:
	exec PCO | INC | PCS
	exec RBL | TMS
	exec PCA | LDA | RBS
	exec SUB | RAS
	exec TML | RBS
	fetch
#addr 48
isub:
	exec PCO | INC | PCS
	exec PCA | LDA | RAS
	exec SUB | RAS
	fetch
#addr 56
lda:
	exec PCO | INC | PCS
	exec PCA | LDA | RAS
	exec RAA | LDA | RAS
	fetch
#addr 64
ldb:
	exec PCO | INC | PCS
	exec PCA | LDA | RBS
	exec RBA | LDA | RBS
	fetch
#addr 72
ldc:
	exec PCO | INC | PCS
	exec PCA | LDA | RCS
	exec RCA | LDA | RCS
	fetch
#addr 80
ldd:
	exec PCO | INC | PCS
	exec PCA | LDA | RDS
	exec RDA | LDA | RDS
	fetch
#addr 88
sta:
	exec PCO | INC | PCS
	exec PCA | LDA | TMS
	exec RAL | TMA | STA
	fetch
#addr 96
stb:
	exec PCO | INC | PCS
	exec PCA | LDA | TMS
	exec RBL | TMA | STA
	fetch
#addr 104
stc:
	exec PCO | INC | PCS
	exec PCA | LDA | TMS
	exec RCL | TMA | STA
	fetch
#addr 112
std:
	exec PCO | INC | PCS
	exec PCA | LDA | TMS
	exec RDL | TMA | STA
	fetch
#addr 120
psha:
	exec SPA | RAL | STA | TMS
	exec SPL | RAS
	exec INC | SPS
	exec TML | RAS
	fetch
#addr 128
pshb:
	exec SPA | RBL | STA
	exec RAL | TMS
	exec SPL | RAS
	exec INC | SPS
	exec TML | RAS
	fetch
#addr 136
pshc:
	exec SPA | RCL | STA
	exec RAL | TMS
	exec SPL | RAS
	exec INC | SPS
	exec TML | RAS
	fetch
#addr 144
pshd:
	exec SPA | RDL | STA
	exec RAL | TMS
	exec SPL | RAS
	exec INC | SPS
	exec TML | RAS
	fetch
#addr 152
popa:
	exec SPL | RAS
	exec DEC | SPS
	exec SPA | LDA | RAS
	fetch
#addr 160
popb:
	exec RAL | TMS
	exec SPL | RAS
	exec DEC | SPS
	exec SPA | LDA | RBS
	exec TML | RAS
	fetch
#addr 168
popc:
	exec RAL | TMS
	exec SPL | RAS
	exec DEC | SPS
	exec SPA | LDA | RCS
	exec TML | RAS
	fetch
#addr 176
popd:
	exec RAL | TMS
	exec SPL | RAS
	exec DEC | SPS
	exec SPA | LDA | RDS
	exec TML | RAS
	fetch
#addr 184
jump:
	exec PCO | INC | PCS
	exec PCA | LDA | PCS
	done PCA | LDA | RIS ;fetch last step
#addr 192
joc: ; Jump On Condition
	exec PCO | INC | PCS
	exec PCA | LDA | TMS
	exec PCO | INC | PCS
	exec PCA | LDA | PCS | CLPC
	done PCA | LDA | RIS ;fetch last step
#addr 200
ima:
	exec PCO | INC | PCS
	exec PCA | LDA | RAS
	fetch
#addr 208
imb:
	exec PCO | INC | PCS
	exec PCA | LDA | RBS
	fetch
#addr 216
imc:
	exec PCO | INC | PCS
	exec PCA | LDA | RCS
	fetch
#addr 224
imd:
	exec PCO | INC | PCS
	exec PCA | LDA | RDS
	fetch
#addr 232
atob:
	exec RAL | RBS
	fetch
#addr 240
atoc:
	exec RAL | RCS
	fetch
#addr 248
atod:
	exec RAL | RDS
	fetch
#addr 256
btoa:
	exec RBL | RAS
	fetch
#addr 264
btoc:
	exec RBL | RCS
	fetch
#addr 272
btod:
	exec RBL | RDS
	fetch
#addr 280
ctoa:
	exec RCL | RAS
	fetch
#addr 288
ctob:
	exec RCL | RBS
	fetch
#addr 296
ctod:
	exec RCL | RDS
	fetch
#addr 304
dtoa:
	exec RDL | RAS
	fetch
#addr 312
dtob:
	exec RDL | RBS
	fetch
#addr 320
dtoc:
	exec RDL | RCS
	fetch
#addr 328
jmpra:
	exec RBL | TMS
	exec RAL | RBS
	exec PCO | ADD | PCS
	exec TML | RBS
	fetch
#addr 336
jmprb:
	exec PCO | ADD | PCS
	fetch
#addr 344
cmp:
	exec FRS
	fetch
#addr 352
pshpc:
	exec SPA | PCL | STA
	exec RAL | TMS
	exec SPL | RAS
	exec INC | SPS
	exec TML | RAS
	fetch
#addr 360
poppc:
	exec RAL | TMS
	exec SPL | RAS
	exec DEC | SPS
	exec SPA | LDA | PCS
	exec TML | RAS
	done PCA | LDA | RIS ;fetch last step
#addr 368
cmpi:
	exec RBL | TMS
	exec PCO | INC | PCS
	exec PCA | LDA | RBS
	exec FRS
	exec TML | RBS
	fetch
#addr 376
icmp:
	exec RAL | TMS
	exec PCO | INC | PCS
	exec PCA | LDA | RAS
	exec FRS
	exec TML | RAS
	fetch
#addr 384
staab:
	exec RAL | RBA | STA
	fetch
#addr 392
staac:
	exec RAL | RCA | STA
	fetch
#addr 400
staad:
	exec RAL | RDA | STA
	fetch
#addr 408
stbaa:
	exec RBL | RAA | STA
	fetch
#addr 416
stbac:
	exec RBL | RCA | STA
	fetch
#addr 424
stbad:
	exec RBL | RDA | STA
	fetch
#addr 432
stcaa:
	exec RCL | RAA | STA
	fetch
#addr 440
stcab:
	exec RCL | RBA | STA
	fetch
#addr 448
stcad:
	exec RCL | RDA | STA
	fetch
#addr 456
stdaa:
	exec RDL | RAA | STA
	fetch
#addr 464
stdab:
	exec RDL | RBA | STA
	fetch
#addr 472
stdac:
	exec RDL | RCA | STA
	fetch
#addr 480
ldaab:
	exec RAS | RBA | LDA
	fetch
#addr 488
ldaac:
	exec RAS | RCA | LDA
	fetch
#addr 496
ldaad:
	exec RAS | RDA | LDA
	fetch
#addr 504
ldbaa:
	exec RBS | RAA | LDA
	fetch
#addr 512
ldbac:
	exec RBS | RCA | LDA
	fetch
#addr 520
ldbad:
	exec RBS | RDA | LDA
	fetch
#addr 528
ldcaa:
	exec RCS | RAA | LDA
	fetch
#addr 536
ldcab:
	exec RCS | RBA | LDA
	fetch
#addr 544
ldcad:
	exec RCS | RDA | LDA
	fetch
#addr 552
lddaa:
	exec RDS | RAA | LDA
	fetch
#addr 560
lddab:
	exec RDS | RBA | LDA
	fetch
#addr 568
lddac:
	exec RDS | RCA | LDA
	fetch
#addr 576
immsp:
	exec PCO | INC | PCS
	exec SPS | PCA | LDA
	fetch
#addr 584
iadd:
	exec PCO | INC | PCS
	exec RAL | TMS
	exec PCA | LDA | RAS
	exec ADD | RBS
	exec RAS | TML
	fetch
#addr 592
shl:
	exec SHL | RAS
	fetch
#addr 600
shli:
	exec PCO | INC | PCS
	exec RBL | TMS
	exec PCA | LDA | RBS
	exec SHL | RAS
	exec TML | RBS
	fetch
#addr 608
shr:
	exec SHR | RAS
	fetch
#addr 616
shri:
	exec PCO | INC | PCS
	exec RBL | TMS
	exec PCA | LDA | RBS
	exec SHR | RAS
	exec TML | RBS
	fetch
#addr 624
mul:
	exec MUL | RAS
	fetch
#addr 632
muli:
	exec PCO | INC | PCS
	exec RBL | TMS
	exec PCA | LDA | RBS
	exec MUL | RAS
	exec TML | RBS
	fetch
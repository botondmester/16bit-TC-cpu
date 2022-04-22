#include "extension.asm" ;¯\_(ツ)_/¯
#bits 16

#fn string(inp) => 0x0000 @ utf16be(inp)
screen = 0xC000
RAM = 0x8000
RAND = 0xC001
default_SP = RAM + 32

main:
	nop
	mov Ra, screen
	sta RAM+1
	.loop:
		nop
		lda RAM+1
		cmpi screen + 1920
		jeq loop2
		lda RAND
		ldc RAM+1
		shli 15
		shri 15
		muli 45
		addi 47
		sta [Rc]
		mov Rc, Ra
		addi 1
		sta RAM+1
		jmp .loop
loop2:
	nop
	jmp loop2
#include "extension.asm" ;—\_(?)_/—
#bits 16

#fn string(inp) => 0x0000 @ utf16be(inp)
screen = 0xC000
RAM = 0x8000
default_SP = RAM + 32

main:
	nop
	mov Sp, default_SP
	mov Rd, message
	std RAM + 2
	jmp print
	loop2:
	nop
	jmp loop2
print:
	; Rd: start of the null-terminated string
	nop
	mov Ra, screen - 1
	sta RAM + 1
	.loop:
		nop
		lda RAM + 1
		ldb RAM + 2
		addi 1
		iadd 1
		ldc [Rb]
		stc [Ra]
		sta RAM + 1
		stb RAM + 2
		mov Rc, Ra
		cmpi 0
		
		jeq .done
		jmp .loop
	.done:
	nop
	jmp loop2
hlt
what:
jmp what
message:
#d string("Hello, World!")
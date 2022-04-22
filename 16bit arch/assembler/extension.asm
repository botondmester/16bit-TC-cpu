#bits 16
#include "syntax.asm"

#ruledef {
	call {num: u16} => asm {
		pshpc
		jmp num
	}
	ret => 0x002D
}
# 16bit-TC-cpu
This is a 16bit cpu made in Turing Complete
## Registers
This cpu has 4 general purpose registers and 5 other registers
### "Usable" Registers
These are the registers that can directly be manipulated trough instructions like the add instruction
#### REG A
By default every operation is done to this register, like add, sub  
Also this is always the first value inputted to the ALU, like REG A + REG B => REG A  
#### REG B
This if the "Secondary register", this holds the second input to the ALU
#### REG C and D
These are registers that used for data that will be used, like passing arguments to functions   
(pieces of code that are executed using the "CALL" instruction and that return to other code using the "RET" instruction)
### "Unusable" Registers
These registers cannot be direcly manipulated trough instructions, because they serve a specific purpose  
and these are manipulated trough Microcode
#### SP (stack pointer)
This register serves the purpose of storing the current address of the stack pointer's current address,  
this register can only be manipulated with the "PUSHX" and "POPX" (The X is referring to any of the general purpose registers)
#### SB (stack base, currently unused)
If you have a use case for this register, let me know
#### PC (program counter)
This holds the currently loaded instruction's addresss (execution always starts at address hex 0x0000),  
and can only be manipulated with the jump instruction
#### INS (instruction register)
This register holds the current instruction, and does not hold any arguments,  
the microcode of the specific instruction handles argument loading
#### TM (temporary register)
Stores temporary data for Instructions, so that it doesn't need to overwrite any data in any register
## Microcode
This cpu uses microcode, that it gets from a LUT (look-up table, Ingame this is the File rom),  
the current "address" in the LUT is determined by the current value in the INStruction register
# Tools Used
Turing Complete: https://turingcomplete.game  
CustomAsm: https://github.com/hlorenzi/customasm  
HxD: https://mh-nexus.de/en/hxd  
# TODO list
- [ ] Finish writing basic information
- [ ] Fix parts that can be misunderstood
- [ ] Finish writing detailed information
- [ ] Fix Call and Ret Instructions
- [ ] Write more test programs

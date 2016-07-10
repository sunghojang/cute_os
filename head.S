.globl _start

 .equ IRQ32MOD, 0x12
 .equ SVC32MOD, 0x13
 .equ SYS32MOD, 0x1f
 .equ NOINT, 0xc0
 
_start:

	@bl mmusetup

stack_setup:
	@ldr r0,=_start	
	@sub sp,r0,#4
	@ldr pc,=kmain
	
	msr cpsr_c,#NOINT | SVC32MOD

	@mov r0,=STACK
	ldr r0,_STACK_ADDR_BASE
	mov r1,#8192
	add sp,r0,r1	

	@ ldr r0,=ExceptStack
	@ mov r1,#8192	
	@ add r0,r0,r1
	@ sub r0,r0,#4

	@ msr cpsr_c,#NOINT | IRQ32MOD
	@ mov sp,r0

	@ msr cpsr_c,#NOINT | SYS32MOD
	@ mov sp,r0

	@msr cpsr_c,#NOINT | SVC32MOD
	
	ldr pc,=kmain

_STACK_ADDR_BASE:
	.word STACK_ADDR_BASE

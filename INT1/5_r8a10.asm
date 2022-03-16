; 5_r8a10

global main

section .text
main:
    nop         ; ne fait rien

    mov r15, -1
    mov r8, 234
    mov r9,234
    mov r10,234
    
	cmp r8,r9
	jz _sinon	;si different alors 0
		mov r15,0
		jmp fin

_sinon:
	cmp r8,r10
	jz _egal	;si different alors 0
		mov r15,0
		jmp fin
		
_egal:
	mov r15,1

fin:            ; fin
    mov rax, 60
    mov rdi, 0
    syscall

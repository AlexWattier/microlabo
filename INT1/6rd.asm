; 5_r8a10

global main

section .rodata 

	a dq 2434155632
	b dq -9100941
	
section .data

	max dq 1
	
section .text
main:
    nop         ; ne fait rien

	mov rax , [a]
	mov rbx , [b]
	cmp rax , rbx
	jns _sinon 
		mov [max] , rbx
		jmp fin

_sinon:
	mov rcx , rax
	mov [max] , rax
	
    
    
fin:            ; fin
    mov rax, 60
    mov rdi, 0
    syscall

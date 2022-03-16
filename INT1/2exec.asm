; 1_comprehension_log.asm

global main

section .data

	v1 dw 0x10_20
	v2 db 0x10
	v3 dw 0x10_20_30_40_50_60_70_80

section .text
main:
   
   nop 
   
   mov cl,[v1]
   
   nop
   
   mov ecx,[v1]
   
   nop
   
   mov rcx,[v1]
   
   nop
   
   mov dword [v1], 0x10_20_30_40
   mov cl , [v1 + 1]
   
   nop
   
   mov cl , [v2 - 1]
   
   nop
   

    ; fin
    mov rax, 60
    mov rdi, 0
    syscall


global _start

section .data
	var1 DB 1
	var2 DB 2
	var3 DW 0x0304
	var4 DQ 0x000000008000FFFF
; la section des données occupe ? bytes


section .text
_start:
	mov rax, var1 ;
	mov al, [var1] ; al contient 
	mov ax, [var1] ; ax contient 
	mov al, [var3] ; al contient 
	mov ax, [var3] ; ax contient 
	mov rax, -1 ; rax contient 
	mov eax, [var4] ; rax contient : 

	mov rax, 60
	mov rdi, 0
	syscall

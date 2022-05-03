; ex1_val.asm

global _start

section .bss

    tab     RESW    10
    
section .text
_start:

    mov rax , 0
tant_que:
    cmp rax,3
    jz iftrois
    inc rax     
    jmp tant_que
iftrois:
   mov word[tab + rax] , rax
   inc rax
    
tant_queD:
    cmp rax,8
    jz ifhuit
    inc rax     
    jmp tant_que

ifhuit:
 mov word[tab + rax] , rax
 
fin:
    mov     rax, 60
    mov     rdi, 0
    syscall

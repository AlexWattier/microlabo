; ex1_val.asm


global main
section .bss

    tab     RESW    10
    
section .text
main:

    mov rax , 0
tant_que:
    cmp rax , 2
    jz iftrois
    inc rax     
    jmp tant_que
    
iftrois:
    mov word [tab + rax*2] , 3     ; multiplier par 2 car 
                                    ; RESW donc 2 bytes par case
    inc rax
    
tant_queD:
    cmp rax , 7
    jz ifhuit
    inc rax     
    jmp tant_que

ifhuit:
    mov word [tab + rax*2] , 8     ; multiplier par 2 car 
                                    ; RESW donc 2 bytes par case
 
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall

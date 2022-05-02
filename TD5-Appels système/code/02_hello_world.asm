; 02_hello_world.asm

global _start

section .rodata
    msg     DB      `Hello, World!\n`
    lgrMsg  DQ      lgrMsg - msg

section .text
_start:
    ; affichage
    mov     rax, 1          ; write
    mov     rdi, 1          ; stdout, sortie standard
    mov     rsi, msg        ; adresse du 1er caractère
    mov     rdx, [lgrMsg]   ; nombre de caractères
    syscall

fin:
    mov     rax, 60         ; exit
    mov     rdi, 0          ; ok
    syscall

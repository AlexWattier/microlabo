; 04_adressage_registre_complet.asm

global _start

section .text
_start:

    mov     rcx, -1

    mov     rbx, rcx
    ; le registre rcx est utilisé pour renseigner la source
    ; le registre rdx est utilisé pour renseigner la destination

    mov     rax, 60
    mov     rdi, 0
    syscall

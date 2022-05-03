; td05_ex5.asm

global main

section .bss

    var     resq    1   ; Réserve 1x8 bytes

section .rodata
    nomPair     db      `pair`, 0
    nomImpair   db      `impair`, 0

section .text

main:

    mov rcx, 77
    mov qword [var], rcx ; sauver le contenu de rcx

    bt rcx, 0           ; CF prend la valeur du 0eme bit de rcx
    jc impaire

    mov rax, 2          ; open
    mov rdi, nomPair    ; adresse du 1er caractère du nom
    mov rsi, 1q         ; WRONLY
    syscall
    jmp ecrit

impaire:
    mov rax, 2          ; open
    mov rdi, nomImpair  ; adresse du 1er caractère du nom
    mov rsi, 1q         ; WRONLY
    syscall

ecrit:
    mov rbx, rax        ; sauver le descripteur
    mov rax, 1          ; write
    mov rdi, rbx        ; descripteur du fichier
    mov rsi, var        ; adresse de ce qui doit être écrit
    mov rdx, 8          ; Nombre de bytes à écrire
    syscall

fin: ; end
    mov rax, 60
    mov rdi, 0
    syscall
    
    
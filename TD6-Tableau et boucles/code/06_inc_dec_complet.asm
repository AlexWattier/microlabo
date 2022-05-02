; 06_inc_dec_complet.asm

global _start

section .data

    i8      DQ      29

section .text
_start:

    ; copie du contenu de la variable i8 dans rdi
    ; rdi prend la valeur 29
    mov     rdi, [i8]

    ; incrémentation de rdi : rdi passe à 30
    inc     rdi

    ; décrémentation de la variable i8 : elle passe à 28
    ; notez l'obligation d'utiliser un spécificateur de taille
    dec     qword [i8]

    ; fin
    mov     rax, 60
    mov     rdi, 0
    syscall

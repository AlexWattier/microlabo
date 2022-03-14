; 2_ascii_minVersMaj_partiel.asm

global main

section .text
main:
    nop         ; ne fait rien

    mov al, 'd' ; on charge une lettre minuscule dans al 

    mov bl ,al      ; à compléter de sorte que ah contienne
    btr bx , 5      ; la même lettre que al mais en majuscule
    ; ........       ; (cela doit fonctionner pour toutes les
                     ;  lettres, on suppose que le contenu de
                    ;  al est bien une lettre minuscule)
    ;mov ah , al
    ;mov bl , 01011111b
    ;and ah , bl


    ; fin
    mov rax, 60
    mov rdi, 0
    syscall


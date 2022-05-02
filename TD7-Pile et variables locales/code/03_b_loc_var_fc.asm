; 03_b_loc_var_fc.asm
;
; nasm -f elf64 -F dwarf 03_b_loc_var_fc.asm
; ld -o 03_b_loc_var_asm 03_b_loc_var_fc.o
; kdbg 03_b_loc_var_asm

global _start

section .text
_start:         ; point d'entrée du programme

; ici il peut y avoir du code : i et j n'existent pas

    ; pile vide
    ;                     petites adresses
    ;           |      |
    ; rsp --->  +------+  grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; sauvegarde du pointeur de contexte de pile (stack frame pointer)
    ; https://en.wikipedia.org/wiki/Call_stack#Structure
    ; rem. : c'est inutile ici puisqu'on est dans _start
    ;
    ; début du bloc où vivent i et j
    ; les 2 instructions qui suivent sont équivalentes à l'accolade
    ; ouvrante ({) du code en langage C
    push    rbp
    ; le contenu de rbp est sauvegardé sur la pile
    ; la valeur 0x00 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x00 | 0x7fffffffd3b8
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; mise à jour du pointeur de contexte de pile (stack frame pointer)
    mov     rbp, rsp
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x00 | 0x7fffffffd3b8  <--- rbp
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; définition de 2 variables de 8 bytes chacune
    sub     rsp, 2 * 8      ; équivalent définition de i et j
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x?? | 0x7fffffffd3a8 (j)
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? | 0x7fffffffd3b0 (i)
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ; rbp --->  | 0x00 | 0x7fffffffd3b8
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; ici les contenus de i et j sont indéterminés...
    ; ça dépend de ce qui traîne sur la pile

    mov     qword [rbp - 8], 23     ; i = 23
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x?? | 0x7fffffffd3a8 (j)
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x?? |
    ;           | 0x17 | 0x7fffffffd3b0 (i)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ; rbp --->  | 0x00 | 0x7fffffffd3b8
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; mov mem, mem interdit
    ;  => utilisation d'un registre intermédiaire
    mov     r8, [rbp - 8]           ; r8 registre intermédiaire
    mov     [rbp - 16], r8          ; j = i;
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x17 | 0x7fffffffd3a8 (j)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x17 | 0x7fffffffd3b0 (i)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ; rbp --->  | 0x00 | 0x7fffffffd3b8
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; fin du bloc où vivent i et j
    ; les 2 lignes qui suivent sont équivalentes à l'accolade
    ; fermante (}) du code en langage C
    ;
    ; destruction des variables locales
    mov     rsp, rbp
    ;
    ;           |      | petites adresses
    ;           | 0x17 | 0x7fffffffd3a8 (j)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x17 | 0x7fffffffd3b0 (i)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ; rsp --->  | 0x00 | 0x7fffffffd3b8  <--- rbp
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; restauration de la valeur initiale de rbp
    ; rem. : c'est inutile ici car on est dans _start
    pop     rbp
    ;
    ;           |      | petites adresses
    ;           | 0x17 | 0x7fffffffd3a8 (j)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x17 | 0x7fffffffd3b0 (i)
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 | 0x7fffffffd3b8
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ; rsp --->  +------+ grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

; ici il peut y avoir du code : i et j n'existent plus

    ; les 3 lignes qui suivent sont équivalentes à return 0;
    mov     rax, 60
    mov     rdi, 0
    syscall

; on n'arrive jamais ici

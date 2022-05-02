; 04_cat_local_variable_fc.asm
;
; nasm -f elf64 -F dwarf 04_cat_local_variable_fc.asm
; ld -o 04_cat 04_cat_local_variable_fc.o

global _start

section .text
_start:

    ; pile vide
    ;                     petites adresses
    ;           |      |
    ; rsp --->  +------+  grandes adresses 0x7fffffffd3c0
    ; rem. : le contenu initial de rsp peut varier

    ; sauvegarde du pointeur de contexte de pile (stack frame pointer)
    ; https://en.wikipedia.org/wiki/Call_stack#Structure
    ; rem. : c'est inutile ici puisqu'on est dans _start
    push    rbp         ; sauvegarde du contenu original de rbp
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
    mov     rbp, rsp    ; rbp pointe sur sa sauvegarde sur la pile
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

    ; création / initialisation des variables locales
    sub     rsp, 1      ; trou dans la pile : ici 1! byte
    ; on n'a pas besoin d'initialiser cette variable
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x?? | 0x7fffffffd3b7 : adresse de la variable locale
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

    ; à partir d'ici : utilisation possible des variables locales

    ; préparation de rsi :
    ; 2e argument de read / write :
    ; pointe sur le buffer où read écrit le résultat de la lecture
    ; pointe sur le buffer où write récupère la donnée à écrire
    mov     rsi, rbp        ; adresse du byte où stocker / récupérer
    dec     rsi             ;  le résultat de la lecture
    ; lea     rsi, [rbp - 1]  ; alternative aux 2 lignes avant
    ; rem. : on utilise rbp car il pourrait y avoir eu des push / pop
    ;        => utiliser rsp est en général plus compliqué que rbp qui
    ;           _ne change pas de valeur_ tout au long de la fonction
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x?? | 0x7fffffffd3b7  <--- rsi (pointeur)
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

    ; préparation de rdx :
    ; 3e argument de read / write :
    ; nombre de bytes à lire (read) / à écrire (write)
    mov     rdx, 1          ; nombre de bytes à lire / écrire

 boucle:
    ; lecture d'un byte sur stdin
    mov     rax, 0          ; numéro de l'appel système : read
    mov     rdi, 0          ; 1er argument : file descriptor : stdin
    ; rsi et rdx sont prêts
    syscall

    cmp     rax, 1
    jnz     fin_boucle      ; rax == 1 => arrêt si pas 1 byte lu

    ; écriture d'un byte sur stdout
    mov     rax, 1          ; numéro de l'appel système : write
    mov     rdi, 1          ; 1er argument : file descriptor : stdout
    ; rsi et rdx sont prêts
    syscall

    jmp     boucle

 fin_boucle:

    ; à partir d'ici : fin de l'utilisation des variables locales

    ; destruction des variables locales
    mov     rsp, rbp
    ;
    ;           |      | petites adresses
    ;           | 0x?? | 0x7fffffffd3b7 : variable locale détruite
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
    pop     rbp     ; récupération de la valeur sauvegardée de rbp
    ; le contenu initial de rbp est restauré depuis la pile
    ;   rsp <-- rsp + 8
    ;
    ;           |      | petites adresses
    ;           | 0x?? | 0x7fffffffd3b7 : variable locale détruite
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

 fin:
    mov     rax, 60
    mov     rdi, 0
    syscall

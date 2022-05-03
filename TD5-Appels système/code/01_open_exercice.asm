; 01_open_exercice.asm

global    main

section .rodata
    nomFichier      DB      `brol`, 0   ; ne pas oublier le 0

section .text
main:
    ; ouverture de brol en écriture seule avec placement
    ; de la tête d'écriture en fin de fichier
    mov     rax, 2          ; open
    mov     rdi, nomFichier ; /adresse/ du 1er caractère du nom
    ;mov     rsi, 1q | 2000q ; WRONLY + O_APPEND
    
    mov rsi, 1q | 100q |2000q
    mov rdx, 755q
    syscall

    mov     rax, 60
    mov     rdi,0
    syscall
    
    
;1) Quand le fichier exisite avec droit rax =3 car quand tout se passe bien j'ai une valeur positive
; Quand le fichier ne possède pas les droits j'obtiens rax=-13 car quand il ya une erreur j'obtiens une valeur n"gative
;J'obitens egalement une valeur négative rax = -2 qui signifie que j'ai eu une erreur

;2) Il me donne 3 car tous ses bien passe ,il y a pas eu d'erreur
;Quand le fichier ne possède pas les droits j'obtiens rax=-13 car quand il ya une erreur j'obtiens une valeur n"gative
;j'obtiens 3 est me créé un fichier nommée brol

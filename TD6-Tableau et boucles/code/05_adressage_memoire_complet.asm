; 05\_adressage\_memoire\_complet.asm

global _start

section .rodata

    s       DB      `hello`, 0  ; chaîne de caractères zéro-terminée

; contenu de la section .rodata (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       s
;  ... | 68 | 65 | 6C | 6C | 6F | 00 | ...
;                                       ---> grande adresses --->

section .data

    i       DQ      -234
    t       DQ      -1, 1, -1   ; tableau de 3 quadwords

; contenu de la section .data (byte par byte, hexadécimal) :
; ---> petites adresses --->
;        i                                       t
;  .... | 16 | FF | FF | FF | FF | FF | FF | FF | FF | FF | .
;
;      . FF | FF | FF | FF | FF | FF | 01 | 00 | 00 | 00 | ..
;
;     .. 00 | 00 | 00 | 00 | FF | FF | FF | FF | FF | FF | ...
;
;    ... FF | FF | ....
;                                       ---> grande adresses --->

section .bss

    msg     RESB    5           ; tableau de 5 bytes

; contenu de la section .bss (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       msg
;  ... | 00 | 00 | 00 | 00 | 00 | ...
;                                       ---> grande adresses --->

section .text
_start:
    ; ------------------------------------------------------
    ; adressage direct : via un immédiat seul : déplacement
    ; ------------------------------------------------------

    ; le byte à l'adresse 0x402000 est copié dans r10b
    ; chez moi s = 0x402000 ce qui aboutit à copier `h` dans r10b
    ; rem. : utiliser mov r10b, [s]
    mov     r10b, [0x402000]

    ; les 8 bytes qui commencent à l'adresse i sont copiés dans r8
    ; ce qui aboutit à copier -234 dans r8
    mov     r8, [i]

    ; les 8 bytes qui commencent à l'adresse t + 2 * 8, c.-à-d. le
    ; 3e élement du tableau t, sont copiés dans r9, ce qui aboutit
    ; à copier -1 dans r9
    ; explication : t est l'adresse du 1er byte d'un tableau
    ;               2 est l'indice de l'élément désiré (3e élément)
    ;               8 est la taille d'un élément
    ; en Java, on aurait simplement r9 = t[2]
    mov     r9, [t + 2 * 8]

    ; ------------------------------------------------
    ; adresse via un registre seul : base
    ; on parle d'adressage indirect (indirect offset)
    ; ------------------------------------------------

    ; on prépare rbx pour l'instruction suivante
    ; rbx contient l'adresse de la variable i
    ; rbx pointe sur la variable i
    mov     rbx, i

    ; ici adresse via registre (rbx)
    ; rbx joue le rôle de base dans cet exemple
    ; ici on récupère dans r12 les 8 bytes qui commencent là
    ; où pointe rbx, ce qui aboutit à copier -234 dans r12
    mov     r12, [rbx]

    ; rem. : ici rbx pointe sur une variable globale (i)
    ;        dont on peut utiliser l'étiquette directement
    ;        sans passer par un registre pour accéder à son
    ;        contenu
    ;        lorsqu'on travaille avec des variables locales,
    ;        sans label associé, on n'a pas d'autre choix que
    ;        d'utiliser l'adressage indirect avec un registre
    ;        de base

    ; -------------------------------------------------------
    ; adresse via immédiat + registre : déplacement + indice
    ; -------------------------------------------------------

    mov     rax, 0
    ; récupération dans r13b du caractère d'indice rax (ici 0),
    ; donc le 1er élément, de la chaîne de caractères s, ce qui
    ; aboutit à copier `h` dans r13b
    mov     r13b, [s + rax]

    mov     rax, 4
    ; récupération dans r14b du caractère d'indice rax (ici 4),
    ; donc le 5e élément, de la chaîne de caractères s, ce qui
    ; aboutit à copier `o` dans r14b
    mov     r14b, [s + rax]

    ; -------------------------------------------------------
    ; adresse via immédiat + registre $\times$ immédiat :
    ;              déplacement + indice $\times$ facteur d'échelle
    ; -------------------------------------------------------

    mov     rax, 0
    ; récupération dans rsi de l'élément d'indice rax (ici 0),
    ; donc le 1er élément, du tableau t, ce qui aboutit à copier -1
    ; dans rsi
    mov     rsi, [t + rax * 8]

    mov     rax, 1
    ; récupération dans rdi de l'élément d'indice rax (ici 1),
    ; donc du 2e élément, du tableau t, ce qui aboutit à copier 1
    ; dans rdi
    mov     rdi, [t + rax * 8]

    ; -------------------------------------------------
    ; adresse via registre + registre ($\times$ immédiat) :
    ;              base + indice ($\times$ facteur d'échelle)
    ; -------------------------------------------------

    ; rbx pointe sur le 1er élément de la chaîne de caractères s
    mov     rbx, s

    mov     rax, 1
    ; récupération dans r14b de l'élément d'indice rax (ici 1),
    ; donc le 2e élément, de la chaîne de caractères pointée
    ; par rbx, donc de la chaîne s, ce qui aboutit à copier `e`
    ; dans r14b
    mov     r14b, [rbx + rax]

    mov     rax, 2
    ; récupération dans r14b de l'élément d'indice rax (ici 2),
    ; donc le 3e élément, de la chaîne de caractères pointée
    ; par rbx, donc de la chaîne s, ce qui aboutit à copier `l`
    ; dans r15b
    mov     r15b, [rbx + rax]

    ; rbx pointe sur le 1er élément du tableau t
    mov     rbx, t

    mov     rax, 0
    ; récupération dans rcx de l'élément d'indice rax (ici 0),
    ; donc le 1er élément, du tableau pointé par rbx, donc
    ; du tableau t, ce qui aboutit à copier -1 dans rcx
    mov     rcx, [rbx + rax * 8]

    mov     rax, 1
    ; récupération dans rdx de l'élément d'indice rax (ici 1),
    ; donc du 2e élément, du tableau pointé par rbx, donc
    ; du tableau t, ce qui aboutit à copier 1 dans rdx
    mov     rdx, [rbx + rax * 8]

    ; rem. : ici rbx pointe sur 2 variables globales (s et t)
    ;        dont on peut utiliser les étiquettes directement
    ;        sans passer par un registre pour accéder au
    ;        contenu
    ;        lorsqu'on travaille avec des variables locales,
    ;        sans label associé, on n'a pas d'autre choix que
    ;        d'utiliser un registre de base pour un adressage
    ;        indirect

    ; rem. générale : ci-dessus accès mémoire en lecture (source)
    ;                 pour accès en écriture (destination), la
    ;                 syntaxe d'accès (offsets) est identique

    ; ---------------------------------
    ; divers accès mémoire en écriture
    ; ---------------------------------

    ; écriture du caractère `a` dans le 1er byte de msg
    ; [déplacement]
    mov     byte [msg], `a`

    ; écriture du caractère `b` dans le 2e byte de msg
    ; [déplacement] : pas d'indice ici car nasm réalise le calcul
    ;                 (somme de 2 immédiats) lors de l'assemblage
    mov     byte [msg + 1], `b`

    ; écriture du caractère `c` dans le 3e byte (indice 2) de msg
    ; [déplacement + indice] : ici facteur d'échelle vaut 1
    mov     r8, 2                   ; r8 : indice
    mov     byte [msg + r8], `c`

    ; écriture du caractère `d` dans le 4e byte (indice 3) de msg
    ; [base + indice] : ici facteur d'échelle vaut 1
    mov     r9, msg                 ; r9 : base, pointe sur msg
    mov     r8, 3                   ; r8 : indice
    mov     byte [r9 + r8], `d`

    mov     rax, 60
    mov     rdi, 0
    syscall

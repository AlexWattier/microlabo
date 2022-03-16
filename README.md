# laboratoire assembleur


## General Info
 
### Instructions logiques
****************************************
| Instruction  | Effet                  |
| :------------|:-----------------------|
| and X, Y     | X ← X ET Y (bit à bit) |
| or X, Y      | X ← X OU Y (bit à bit) | 
| xor X, Y     | X ← X XOR Y (bit à bit)|  
| not X        | X ← - X (bit à bit)    |
#### Contrainte 
Registres ou variables de 8, 16, 32 ou 64 bits,pas deux variables,Y peut être un immédiat(8, 16 ou 32 bits).
#### Flag affectés
CF ← 0 \
OF ← 0 \
SF ← bit de signe a du r´esultat \
ZF ← 1 si r´esultat nul, 0 sinon 

### Masque
****************************************
en reutilisant les instruction du dessus et en crée un masque nous obtenons ceci pour les differentes instruction. 
|            |           |
| :----------|:----------|
|al          | 11100101b |
|bl (masque) | 11110000b |
|or al, bl   |           |
|al          | 11110101b |

|            |           |
| :----------|:----------|
|al          | 11100101b |
|bl (masque) | 11110000b |
|xor al, b   |           |
|al          | 00010101b |

|            |           |
| :----------|:----------|
|al          | 11100101b |
|bl (masque) | 11110000b |
|and al, b   |           |
|al          | 00000101b |

### Manipulation de bits

* bts met ce bit du premier opérande à 1 \
* btr met ce bit du premier opérande à 0 \
* btc complémente ce bit du premier opérande.

Le zero flag (ZF) n’est pas modifié. L’overflow flag (OF) et le sign flag (SF) sont indéfinis. 

## Instruction de saut et alternatives

### Comparaison
****************************************

| Instruction  | Effet        |
| :------------|:-------------|
| cmp X, Y     | temp ← X - Y |

#### Contrainte 
Registres ou variables de 8, 16, 32 ou 64 bits, pas deux variables à la fois, Y peut être un immédiat (8, 16 ou 32 bits).
#### Flag affectés
OF, CF selon arithmétique \
X - Y \
ZF ← 1 si temp = 0 (X = Y), \
0 sinon \
SF ← bit de signe de temp : \
1 si X < Y, 0 sinon 

### Label
****************************************

Les labels sont des repère que le programmeur met dans le code afin de donner un nom à une ligne du programme.

### Saut inconditionnel
****************************************

L’instruction jmp permet d’effectuer un saut vers un certain label. Mais n'effectuera pas les instructions se trouvant entre le jmp et ce label.

### Sauts conditionnels
****************************************

Les instructions de saut conditionnel permettent d’effectuer un saut si une certaine condition est vraie.

| Instruction | Nom         | Effet |
| :--------|:-------------|:-|
| jc label | jump carry | Si CF = 1, on effectue le saut vers le label, sinon on passe à l’instruction suivante|
| jz label | jump zero | Si ZF = 1, on effectue le saut vers le label, sinon on passe à l’instruction suivante|
| js label | jump sign | Si SF = 1, on effectue le saut vers le label, sinon on passe à l’instruction suivante|
| jnc label | jump not carry | Si CF = 0, on effectue le saut vers le label, sinon on passe à l’instruction suivante|
| jnz label | jump not zero | Si ZF = 0, on effectue le saut vers le label, sinon on passe à l’instruction suivante|
| jns label | jump not sign | Si SF = 0, on effectue le saut vers le label, sinon on passe à l’instruction suivante|

| Instruction               | Effet                  | Note |
| :-------------------------|:-----------------------|:-------|
|bt rax, 0 <br>  jc label   | Saut si rax est impair |rax : représentation par position ou complément à 2 |
|cmp rax, rbx <br> js label | Saut si rax < rbx      |rax et rbx : cpt. à 2 |
|cmp rax, rbx <br> jnz label| Saut si rax ̸= rbx      |rax et rbx : rep. / position ou cpt. à 2 |


## Variables globales

les variables globales sont au nombre de trois : .data, .rodata et .bss. Elles sont créées en mémoire lors du chargement de l’exécutable et y résident jusqu’à sa fin.
* La section .bss est utilisée pour les variables implicitement initialisées à zéro au démarrage du programme.
* Les section .data et .rodata sont initialisées avec les valeurs qu’elles ont dans le fichier exécutable.
    * la section .rodata n'est disponible qu en lecture seule.
    * la section .data permet de modifier les valeurs des variables qui ont été defini dedans.

|Taille (en bytes) |Pseudo-instruction |Signification     |
|:-----------------|:------------------|:-----------------|
|                1 | DB                |Define Byte       |
|                2 | DW                |Define Word       |
|                4 | DD                |Define Doubleword |
|                8 | DQ                |Define Quadword   |


|Taille (en bytes) |Pseudo-instruction |Signification     |
|:-----------------|:------------------|:-----------------|
|                1 | RESB                |Reserve Byte       |
|                2 | RESW                |Reserve Word       |
|                4 | RESD                |Reserve Doubleword |
|                8 | RESQ                |Reserve Quadword   |


```arm
section .data
 i4 DD 42        ; entier sur 4 bytes
 section .text 
 ; ... 
 mov rax, i4    ; rax <-- _adresse_ (8 bytes) de i4   
 mov ebx, [i4]  ; ebx <-- _contenu_ de ce qui se trouve 
                ; à l'adresse i4 et s'étend sur 4 bytes (car ebx), soit 42  
 mov ecx, [rax] ; rax contient l'adresse de i4, donc  
                ; [rax] = [i4] et ici ecx <-- _contenu_ de ce qui se trouve   
                ; à l'adresse rax = i4 et s'étend sur 4 bytes (car ecx), soit 42
```
# laboratoire assemleur


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
****************************************
### Comparaison

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

Les labels sont des repère que le programmeur met dans le code afin de donner un nom à une ligne du programme.

### Saut inconditionnel

L’instruction jmp permet d’effectuer un saut vers un certain label. Mais n'effectuera pas les instructions se trouvant entre le jmp et ce label.

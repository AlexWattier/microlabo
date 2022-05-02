// 03_b_loc_var.c
//
// gcc -o 03_b_loc_var_c -std=c11 -Wall -pedantic-errors -g 03_b_loc_var.c
// kdbg 03_b_loc_var_c

int main()  // point d'entrée du programme
{

// ici il peut y avoir du code : i et j n'existent pas

    {   // début du bloc où vivent i et j
        long int i, j;
        // ici les contenus de i et j sont indéterminés
        i = 23;
        j = i;
    }   // fin du bloc où vivent i et j

// ici il peut y avoir du code : i et j n'existent plus

    return 0;       // équivalent à exit(0);
}   // fin de main()

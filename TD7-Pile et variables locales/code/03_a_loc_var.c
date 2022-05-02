// 03_a_loc_var.c
//
// gcc -o 03_a_loc_var_c -std=c11 -Wall -pedantic-errors -g 03_a_loc_var.c
// kdbg 03_a_loc_var_c

int main()  // point d'entrée du programme
{

// ici il peut y avoir du code : i et j n'existent pas

    {   // début du bloc où vivent i et j
        long int i = 4;
        long int j = -8;

        i = 23;
        i -= 4;
        ++j;
    }   // fin du bloc où vivent i et j

// ici il peut y avoir du code : i et j n'existent plus

    return 0;       // équivalent à exit(0);
}   // fin de main()

; use_open.asm
; Ouvir un fichier et y écrire un message
; si le fichier n'existe pas le créer
; si echec ouverture, afficher mesError à l'écran
global main

section .rodata
  myFile db `file1`0 ; ne pas oublier le 0
  message db "Bonjour groupe B142",10
  taille dq $-message
  mesError db "Echec ouverture du fichier",10
  taille2 dq $-mesError
  
section .bss
  fd resq 1

section .text
main:
   nop
open:
   mov rax, 2
   mov rdi, myFile
   mov rsi, 2q | 100q | 2000q
   syscall
   
   
   cmp rax, 0
   js echecOpen
; récupération du fd
   mov [fd], rax
   
write_fd:
   mov rax, 1
   mov rdi, [fd]
   mov rsi, message
   mov rdx, [taille]
   syscall
   jmp _end
   
echecOpen:
write1:
   mov rax, 1
   mov rdi, 1
   mov rsi, mesError
   mov rdx, [taille2]
   syscall
   
_end:
   mov rax, 60
   mov rdi, 0
   syscall   
   
  

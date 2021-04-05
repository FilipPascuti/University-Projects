bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0xFFFF 
    b dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Se da un cuvant A. Sa se obtina dublucuvantul B astfel:
        ;1 bitii 0-3 ai lui B sunt 0;
        ;2 bitii 4-7 ai lui B sunt bitii 8-11 ai lui A
        ;3 bitii 8-9 si 10-11 ai lui B sunt bitii 0-1 inversati ca valoare ai lui A (deci de 2 ori) ;
        ;4 bitii 12-15 ai lui B sunt biti de 1
        ;5 bitii 16-31 ai lui B sunt identici cu bitii 0-15 ai lui B.
        ;1
        mov ebx, 0
        ;2
        mov ax, [a]
        and ax, 0000111100000000b
        shr ax, 4
        or bx, ax
        ;3
        mov ax, [a]
        not ax
        and ax, 0000000000000011
        shl ax, 8
        or bx, ax 
        shl ax, 2
        or bx, ax
        ;4
        or bx, 1111000000000000
        ;5
        mov ax, bx
        shl ebx, 16
        mov bx, ax
        ;Final result
        mov [b], ebx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

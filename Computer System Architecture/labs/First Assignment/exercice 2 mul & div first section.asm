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
    a db 1 
    b db 1
    c db 4
    d dw 2
; our code starts here
segment code use32 class=code
    start:
        ; a,b,c - byte, d - word
        ;d*(d+2*a)/(b*c)
        mov al, [b]
        mul byte[c]
        ; ax := b * c
        mov bx, ax
        ; bx := ax = b * c
        mov al, 2
        mul byte[a]
        ; ax := al * 2 = a * 2
        add ax, [d]
        ; ax := 2 * a + d
        mul word[d]
        ; dx:ax := ax * d = (d + 2 * a) * d
        div bx
        ;ax quotient, dx remainder
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

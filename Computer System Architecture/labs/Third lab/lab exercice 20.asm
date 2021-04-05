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
    a dw 11111111b
    b dw 00000000b
    c dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Se dau cuvintele A si B. Se cere dublucuvantul C:
        ;1 bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A
        ;2 bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
        ;3 bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A
        ;4 bitii 16-31 ai lui C sunt 0
        ; 4
        mov ecx, 0
        ;1
        mov ax, [a]
        and ax, 0000000111111000b
        shr ax, 3 
        or cx, ax
        ;2
        mov bx, [b]
        and bx, 0000000000011100b
        shl bx, 4
        or cx, bx
        ;3
        mov ax, [a]
        and ax, 0001111111000000b
        shl ax, 3
        or cx, ax
        ;Final result:
        mov [c], ecx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

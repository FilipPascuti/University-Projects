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
    a dw 0
    b dw 0
    c dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Se dau cuvintele A si B. Se cere dublucuvantul C:
        ;1) bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
        ;2) bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
        ;3) bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A
        ;4) bitii 16-31 ai lui C coincid cu bitii lui B
        ;4)
        mov cx, [b]
        shl ecx, 16
        ;1)
        mov bx, [b]
        and bx, 0000000111100000b
        shr bx, 5
        or cx, bx
        ;2)
        mov ax, [a]
        and ax, 0000000000011111b
        shl ax, 4
        or cx, ax
        ;3)
        mov ax, [a]
        and ax, 0011111111000000b
        shl ax, 3
        or cx, ax
        ;Final result
        mov [c], ecx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

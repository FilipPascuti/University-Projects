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
    a dw "1234567812345678"
    lena equ ($-a)/2
    b1 times lena db 0
    b2 times lena db 0

; our code starts here
segment code use32 class=code
    start:
        ; Given an array A of words, build two arrays of bytes:  
        ; - array B1 contains as elements the higher part of the words from A
        ; - array B2 contains as elements the lower part of the words from A
        ; ...
        mov esi, a 
        mov edi, b1 
        mov ecx, lena 
        cld
        repeat:
            lodsw ; ax <- [esi], esi += 2
                    ; al stores the lower part of the word from [esi]
            stosb ; al -> [edi], edi += 2
            loop repeat
        mov esi, a 
        mov edi, b2 
        mov ecx, lena
        repeat1:
            lodsd ; ax <- [esi], esi += 2
            shr ax, 8 ; al stores the higher part of the word from [esi] => ah stores the higher part of the word from [esi]
            stosb ; al -> [edi], edi += 2
            loop repeat1 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
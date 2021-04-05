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
    s1 db 1, 3, -1, -8, 7
    len_s1 equ $-s1
    s2 db 9, 10, 11, -20, 3
    d times len_s1 db 0; define len_s1 bytes with the value 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel incat fiecare element din D sa reprezinte minumul dintre elementele de pe pozitiile corespunzatoare din S1 si S2.
        ; Exemplu:
        ; S1: 1, 3, 6, 2, 3, 7
        ; S2: 6, 3, 8, 1, 2, 5
        ; D: 1, 3, 6, 1, 2, 5
        mov esi, 0; index
        mov ecx, len_s1
        jecxz final
        do:
            mov al, [s1+esi]
            mov bl, [s2+esi]
            cmp al, bl
            jg copy_s2
            mov [d+esi], al; al <= bl
            jmp over
            copy_s2:
                mov [d+esi], bl; al > bl
            over:
                inc esi
            loop do
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

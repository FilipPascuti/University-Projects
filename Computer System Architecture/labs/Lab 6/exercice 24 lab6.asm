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
    s dd 01011010b, 1111b, 010b
    len equ ($ - s)/4
    d times len dd 0
    
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Being given a string of doublewords, build another string of doublewords which will include only the doublewords from the given string which have an even number of bits with the value 1.
        mov ecx, len
        jecxz final
        mov esi, s
        mov edi, d
        cld
        do:
            lodsd; eax <- [esi]
                 ; esi += 4
            mov edx, eax
            push ecx
            mov ecx, 32
            check_bits:
                shr edx, 1; the last bit that exited is stored into carry flag
                adc ebx, 0
                loop check_bits
            ; ebx no of bits that are 1
            test ebx, 1
            jnz over
            ;ebx even
            stosd
            over:
                pop ecx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

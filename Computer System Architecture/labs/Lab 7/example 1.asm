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
    a db "ana are mere"
    lena equ ($-a)
    vow db "aeiou"
    lenv equ ($-vow)
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, a
        mov edi, vow
        mov ecx, lena
        cld 
        jecxz final
        mov ebx, 0
        do_1:
            lodsb
            push ecx
            mov ecx, lenv
            do_2:
                scasb
                jne over_incr:
                inc ebx
                over_incr:
                    loop do_2
            pop ecx
            mov edi, vow
            loop do_1
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

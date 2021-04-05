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
    s dd 0xABACADAE, 1, 2, 3, 4
    len equ ($-s)/4
    d times len db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; A string of doublewords is given. Compute the string formed by the high bytes of the low words from the elements of the doubleword string and these bytes should be multiple of 10.
        ; Example:
        ; given the doublewords string:
        ; s DD 12345678h, 1A2B3C4Dh, FE98DC76h 
        ; obtain the string
        ; d DB 3Ch, DCh.
        mov esi, s
        mov edi, d
        mov ecx, len
        jecxz final
        cld
        do:
            lodsd ; eax <- [esi]
                  ; ah <- high byte of the low word
            mov dl, ah
            mov al, ah
            cbw
            mov dh, 10
            idiv dh; ah - remainder
            cmp ah, 0
            jne skip_elem
            mov al, dl
            stosb
            skip_elem:
                loop do
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
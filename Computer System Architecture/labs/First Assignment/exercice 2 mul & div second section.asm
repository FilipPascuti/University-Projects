bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b db 5
    c db 4
    d db 3
    f dw 3
    g dw 4
    h dw 2

; our code starts here
segment code use32 class=code
    start:
        ; a,b,c,d-byte, e,f,g,h-word
        ;h/a + (2 + b) + f/d – g/c
        mov ax, [h]
        div byte[a]
        mov bl, al
        
        mov dl, 2
        add dl, [b]
        
        add bl, dl
        
        mov ax, [f]
        div byte[d]
        
        add bl, al
        
        mov ax, [g]
        div byte[c]
        
        add bl, al
        
        mov al, bl
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

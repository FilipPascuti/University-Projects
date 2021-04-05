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
    s db '+', '4', '2', 'a', '@', '3', '$', '*'
    len equ $-s
    d times len db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele speciale (!@#$%^&*) din sirul S.
        ; Exemplu:
        ; S: '+', '4', '2', 'a', '@', '3', '$', '*'   
        ; D: '@','$','*'
        mov esi, s
        mov edi, d
        mov ecx, len
        cld
        mov al, 0
        jecxz final
        repeat:
            lodsb  
            cmp al, '@'
            je add_
            
            cmp al, '!'
            je add_
            
            cmp al, '#'
            je add_
            
            cmp al, '$'
            je add_
            
            cmp al, '%'
            je add_
            
            cmp al, '^'
            je add_
            
            cmp al, '&'
            je add_
            
            cmp al, '*'
            je add_
            
            jmp over
            add_:
                stosb
            over:
                loop repeat
        
        final:
            mov [d], edi
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
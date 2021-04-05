bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf                ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sign db 0
    format db "%s", 0
    format2 db "%d", 0
    numbers times 100 db 0
    result times 100 db 0
    x dw 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ... 
        
        ;scanf(format, a)
        push numbers 
        push format
        call [scanf]
        add esp, 4 * 2
        
        ;printf(format)
        ; push numbers
        ; push format
        ; call [printf]
        ; add esp, 4 * 2
        
        mov esi, numbers
        mov edi, result
        
        mov edx, 0
        mov ecx, 0
        mov ebx, 0
        
        repeat:
            lodsb; al := [esi]
            cmp al, 0
            je final
            
            cmp al, ','
            jne check_negative
            cmp byte[sign], 1
            je is_neg
            mov al, [x]
            stosb
            jmp not_neg
            
            is_neg:
            mov al, [x]
            neg al
            stosb
            
            not_neg:
            mov byte[sign], 0
            mov edx, 0
            mov ecx, 0
            mov ebx, 0
            mov word[x], 0
            
            check_negative:
                cmp al, '-'
                jne positive
                
                mov byte[sign], 1
                
                positive:
                    cmp al, '0'
                    jae check_if_digit
                    jmp repeat
                    check_if_digit:
                        cmp al, '9'
                        jbe is_digit
                        jmp repeat
                        is_digit:
                        sub al, 48
                        cmp byte[x], 0
                        je new_number
                        mov bl, al
                        mov al, [x]
                        mov byte[x], 10
                        mul byte[x]
                        add al, bl
                        mov word[x], ax
                        new_number:
                            mov byte[x], al
        final:
            
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

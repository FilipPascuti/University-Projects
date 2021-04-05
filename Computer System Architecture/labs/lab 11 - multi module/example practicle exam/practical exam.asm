bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf, fopen, fwrite  ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll      ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll    
import fwrite msvcrt.dll                        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    fd dd 0
    read_format db '%s', 0
    print_format db '%s', 0
    file_name db 0
    len equ $
    lenght dd 0
    acc_mode db 'w', 0
    the_word db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; read a file name from the keyboard then read words until $ is read
        ; write in the file only the words that have a an even number of words
        
        ;scanf(format, filename)
        push file_name
        push read_format
        call [scanf]
        add esp, 4 * 2
        
        mov eax, len
        sub eax, file_name
        
        
        ;printf(format, filename)
        push eax
        push print_format
        call [printf]
        add esp, 4 * 2
        
        
        ; fopen(file_name, acc_mode)
        ; push acc_mode
        ; push file_name
        ; call [fopen]
        ; add esp, 4 * 2
        
        ; mov [fd], eax
        ; cmp eax, 0
        ; je final
        
        ; do:
            ; ;scanf(format, word)
            ; push the_word
            ; push read_format
            ; call [scanf]
            ; add esp, 4 * 2
            ; mov dl, [the_word]
            
            
            ; cmp dl, '$'
            ; jne do
        
        ; ;printf(format, filename)
        ; push file_name
        ; push print_format
        ; call [printf]
        ; add esp, 4 * 2
        
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

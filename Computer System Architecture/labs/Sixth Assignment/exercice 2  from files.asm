bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll     ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "textfile.txt", 0
    acc_mode db "r", 0
    format db "%d", 0
    fd dd 0
    a db 0
    x dd 0
        
        
; our code starts here
segment code use32 class=code
    start:
        ; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de consoane si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.
        
        ;1. open the file
        ; fopen(file_name, acc_mode)
        push acc_mode
        push file_name
        call [fopen]
        add esp, 4 * 2
        mov [fd], eax
        cmp eax, 0
        je final
        mov edx, 0
        do:
            pusha
            ;fread(a, 1, a, fd)
            push dword[fd]
            push dword 1
            push dword 1
            push a
            call [fread]
            add esp, 4 * 4
            cmp eax, 0; check if we reached the end of the file
            mov [x], eax
            popa
            je after_read
            
            mov al, [a]
            
            cmp al, 'A'
            jl not_a_letter
            
            cmp al, 'z'
            jg not_a_letter
            
            cmp al, 'Z'
            jle is_upper_letter
            
            cmp al, 'a'
            jge is_lower_letter
            
            is_lower_letter:
                cmp al, 'a'
                je not_a_letter
                cmp al, 'e'
                je not_a_letter
                cmp al, 'i'
                je not_a_letter
                cmp al, 'o'
                je not_a_letter
                cmp al, 'u'
                je not_a_letter
                
                inc edx
                jmp not_a_letter
            
            is_upper_letter:
                cmp al, 'A'
                je not_a_letter
                cmp al, 'E'
                je not_a_letter
                cmp al, 'I'
                je not_a_letter
                cmp al, 'O'
                je not_a_letter
                cmp al, 'U'
                je not_a_letter
                
                inc edx
            
            not_a_letter:
                jmp do
        after_read:
            push edx
            push format
            call [printf]
            add esp, 4 * 2  
        
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

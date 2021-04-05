bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, printf, fread, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "jana.txt", 0
    acc_mode db "r", 0
    format db 10, 13, 0
    buf times 10 db 0
        db 0
    fd dd 0
    siz equ 10

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ;1. open the file
        ; fopen(file_name, acc_mode)
        push acc_mode
        push file_name
        call [fopen]
        add esp, 4 * 2
        mov [fd], eax
        cmp eax, 0
        je final
        do:
            ;fread(buf, 1, siz, fd)
            push dword[fd]
            push dword siz
            push dword 1
            push buf
            call [fread]
            add esp, 4 * 4
            cmp eax, 0; check if we reached the end of the file
            je after_read
            mov [buf + eax], byte 0
            
            ;printf(buf)
            push buf
            call [printf]
            add esp, 4
            
            push format
            call [printf]
            add esp, 4
            
            jmp do
        after_read:
            ;fclose(file_descriptor)
            push fd
            call [fclose]
            add esp, 4
            final:
                ; exit(0)
                push    dword 0      ; push the parameter for exit onto the stack
                call    [exit]       ; call exit to terminate the program

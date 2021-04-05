bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf       ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll          ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a times 100 dd 0
    len dd 0
    msg_len db "length= ", 0
    msg_elem db "element= ", 0
    format db "%d", 0
    print_format db "the sum of the elements is %d  ", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, a 
        ;printf(msg_len)
        push msg_len
        call [printf]
        add esp, 4
        ;scanf(format, len)
        push len
        push format
        call [scanf]
        add esp, 4 * 2
        mov ecx, [len]
        do:
            pusha
            ;printf(msg_elem)
            push msg_elem
            call [printf]
            add esp, 4
            ;scanf(format, esi)
            push esi
            push format 
            call [scanf]
            add esp, 4 * 2
            popa 
            add esi, 4
            loop do
        mov esi, a
        mov ecx, [len]
        mov edx, 0
        do2:
            lodsd
            add edx, eax
            loop do2
        pusha 
        ;printf(print_format, edx)
        push edx
        push print_format
        call [printf]
        popa 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

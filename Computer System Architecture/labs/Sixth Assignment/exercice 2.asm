bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf      ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll          ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dw 0
    result dd 0
    read_format db "%d", 0
    print_format db "result = %d", 0
    
; our code starts here
segment code use32 class=code
    start:
        ;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a/b. Catul impartirii se va salva in memorie in variabila ;"rezultat" (definita in segmentul de date). Valorile se considera cu semn.
        ;printf(format, a)
        push a
        push read_format
        call [scanf]
        add esp, 4 * 2
        push b
        push read_format
        call [scanf]
        add esp, 4 * 2
        
        mov eax, 0
        mov edx, 0
        
        mov ax, [a]
        mov dx, [a + 2]
        div word[b]
        mov [result], ax
        
        pusha
        push dword[result]
        push print_format
        call [printf]
        add esp, 4 * 2
        popa
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

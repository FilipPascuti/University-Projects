bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    read_format db "%d", 0
    lower_format db "a= %d < b= %d ", 0
    greater_format db "a= %d > b= %d ", 0
    equal_format db "a= %d = b= %d ", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; Sa se citeasca de la tastatura doua numere a si b (in baza 10) şi să se determine relaţia de ordine dintre ele (a < b, a = b sau a > b).    Afisati rezultatul în următorul format: "<a> < <b>, <a> = <b> sau <a> > <b>".
        
        ; scanf("%d", a)
        push a 
        push read_format
        call [scanf]
        add esp, 4 * 2
        
        ; scanf("%d", b)
        push b
        push read_format
        call [scanf]
        add esp, 4 * 2
        
        mov ebx, [b]
        mov eax, [a]
        cmp eax, ebx
        jge greater_or_equal
        ; printf(lower_format, a, b)
        pusha
        push dword[b]
        push dword[a]
        push lower_format
        call [printf]
        add esp, 4 * 3
        jmp final
        popa
        
        greater_or_equal:
            cmp eax, ebx
            je equal
            ; printf(greater_format, a, b)
            pusha
            push dword[b]
            push dword[a]
            push greater_format
            call [printf]
            add esp, 4 * 3
            jmp final
            popa
            
        equal:
            ; printf(equal_format, a, b)
            pusha
            push dword[b]
            push dword[a]
            push equal_format
            call [printf]
            add esp, 4 * 3
            popa
        
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 03010402h
    len equ $-a
    print_format db "a= %d", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax, 0
        mov edx, 0
        mov ebx, 0
        mov dx, 1
        repeat:
            cmp dx, 0
            je next_step
            mov esi, a
            mov dx, 0
            mov ecx, len - 1
            inner_loop:
                mov al, byte[esi]
                cmp al, byte[esi + 1]
                jae next
                mov bl, byte[esi + 1]
                mov byte[esi], bl
                mov byte[esi + 1], al
                mov dx, 1
                next:
                    inc esi
                    loop inner_loop
                    jmp repeat
        
        next_step:
            pusha
            push dword[a]
            push print_format
            call [printf]
            add esp, 4 * 2
            popa
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

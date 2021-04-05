bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword
    a db 1
    b dw 1
    c dd 4
    d dq 1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(c + b) - a - (d + d) a - byte, b - word, c - double word, d - qword
        mov eax, 0; eax = 0
        mov ebx, 0; ebx = 0
        mov ecx, 0; ecx = 0
        mov edx, 0; edx = 0
        mov ax, [b]; ax = b
        cwde; eax = b
        add eax, [c]; eax = c + b
        mov ebx, eax; ebx = eax = c + b
        mov al, [a]; al = a
        cbw; ax = a 
        cwde; eax = a
        sub ebx, eax; ebx = ebx - eax = (c + b) - a
        mov eax , ebx; eax = ebx = (c + b) - a
        cdq; edx:eax = (c + b) - a
        mov ebx, [d]; ebx = least segnificant part of d
        mov ecx, [d + 4]; ecx = most segnificant part of d
        add ebx, [d]; ebx = least segnificant part of d + d
        adc ecx, [d + 4]; ecx = least segnificant part of d + d
        sub eax, ebx; eax = least segnificant part of (c + b) - a - (d + d)
        sbb edx, ecx; edx = most segnificant part of (c + b) - a - (d + d)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

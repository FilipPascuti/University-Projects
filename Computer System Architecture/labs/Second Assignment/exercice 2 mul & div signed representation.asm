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
    ; a, b, c - byte
    ; d - doubleword
    ; e - qword
    a db 9
    b db 1
    c db 2
    d dd 1
    e dq 10
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;2 / (a + b * c - 9) + e - d
        ; a, b, c - byte
        ; d - doubleword
        ; e - qword
        mov eax, 0; eax = 0
        mov ebx, 0; ebx = 0
        mov ecx, 0; ecx = 0
        mov edx, 0; edx = 0
        mov al, [b]; al = b
        mul byte[c]; ax = al * c = b * c 
        mov bx, ax; bx = ax = b * c
        mov al, [a]; al = a
        cbw; ax = a 
        add ax, bx; ax = a + b * c
        sub ax, 9; ax = a + b * c - 9
        mov bx, ax; bx = ax = a + b * c - 9
        mov ax, 2
        mov dx, 0
        idiv bx; ax = 2 / (a + b * c - 9), dx = 2 % (a + b * c - 9)
        cwd; eax = ax = 2 / (a + b * c - 9)
        cdq; edx:eax = eax = 2 / (a + b * c - 9) 
        add eax, [e]; eax = the least segnificant part of 2 / (a + b * c - 9) + e
        adc edx, [e + 4]; edx = the most segnificant part of 2 / (a + b * c - 9) + e
        mov ebx, eax; ebx = eax = the least segnificant part of 2 / (a + b * c - 9) + e
        mov ecx, edx; ecx = edx = the most segnificant part of 2 / (a + b * c - 9) + e
        mov eax, [d]; eax = d
        cdq; edx:eax = eax = d
        sub ebx, eax; ebx = the least segnificant part of 2 / (a + b * c - 9) + e - d
        sbb ecx, edx; ecx = the most segnificant part of 2 / (a + b * c - 9) + e - d
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

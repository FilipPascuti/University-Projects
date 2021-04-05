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
    a DB -2
    b DB -3
    c DW  4
    e DD  0x123
    x DQ  0xABCD
    t dd 0

    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a+b*c+2/c)/(2+a)+e+x; a,b-byte; c-word; e-doubleword; x-qword
        mov al, [b]
        cbw; ax = b
        imul word[c]
        ;dx:ax = b * c
        mov [t], ax
        mov [t + 2], dx
        ;t = b * c
        mov ax, 2
        cwd; dx:ax = 2
        idiv word[c]; ax = 2 / c   dx = 2 % c
        cwde ; eax = 2 / c
        add eax, [t]
        mov ebx, eax ; ebx = b * c + 2 / c-word
        mov al, [a]
        cbw
        cwde ; eax = add
        add ebx, eax; a + b * c + 2 / c
        mov al, [a]
        add al, 2
        cbw
        cwde; eax = a + 2
        mov ecx, eax; ecx = a + 2
        mov eax, ebx
        cdq
        idiv ecx ; eax = (a + b * c + 2 / c) / (a + 2)
        add eax, [e]
        cdq
        add eax, [x]
        adc edx, [x + 4]; edx:eax = (a + b * c + 2 / c) / (2 + a) + e + x
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

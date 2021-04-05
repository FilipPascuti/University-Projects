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
    s dw 1432h, 8675h, 0ADBCh
    len equ ($ - s) / 2
    d times len dd 0
    a dd 0
    result times len dd 0
    print_format db "%d", 10, 13, 0
    
; our code starts here
segment code use32 class=code
    start:
        ; Se da un sir de cuvinte. Sa se obtina din acesta un sir de dublucuvinte, in care fiecare dublucuvant va contine nibble-urile despachetate pe octet 
        ;(fiecare cifra hexa va fi precedata de un 0), aranjate crescator in interiorul dublucuvantului.
        ;   Exemplu:
        ;   pentru sirul initial:
        ;   1432h, 8675h, 0ADBCh, ...
        ;   Se va obtine:
        ;   01020304h,  05060708h, 0A0B0C0Dh, ... 
        mov eax, 0
        mov esi, s
        mov edi, d    
        mov ecx, len
        cmp ecx, 0
        jne mai_departe
        jmp final
        mai_departe:
        cld 
        repeat1:
            lodsb; al:= 14
            mov bl, al
            
            shl al, 4
            shr al, 4
            stosb
            
            mov al, bl
            shr al, 4
            stosb
            
            lodsb; al:= 14
            mov bl, al
            
            shl al, 4
            shr al, 4
            stosb
            
            mov al, bl
            shr al, 4
            stosb
            loop repeat1
          
        mov esi, d
        mov edi, result 
        mov ecx, len
        repeat2:
            lodsd
            mov [a], eax
            push esi
            push ecx
            mov dx, 1
            repeat:
                cmp dx, 0
                je next_step
                mov dx, 0
                mov esi, a
                mov ecx, 3
                inner_loop:
                    mov al, byte[esi]
                    cmp al, byte[esi + 1]
                    jae next
                    mov dx, 1
                    mov bl, byte[esi + 1]
                    mov byte[esi], bl
                    mov byte[esi + 1], al
                    next:
                        inc esi
                        loop inner_loop
                        jmp repeat
            next_step:
                pop ecx
                pop esi
                mov eax, [a]
                stosd         
                loop repeat2
        mov esi, result
        mov ecx, len
        repeat3: 
            lodsd 
            ;printf(print_format, eax)
            pusha
            push eax
            push print_format
            call [printf]
            add esp, 4 * 2
            popa
            loop repeat3
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
        
        
        

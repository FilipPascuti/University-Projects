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
    source dw 1432h, 8675h, 0ADBCh
    len_s equ ($-source)/2
    destination times len_s dd 0
    result times len_s dd 0
    list_of_bytes db 0, 0, 0, 0 
    a db 10h
    ;x db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
            ; Se da un sir de cuvinte. Sa se obtina din acesta un sir de dublucuvinte, in care fiecare dublucuvant va contine nibble-urile despachetate pe octet (fiecare cifra hexa va fi precedata de un 0), aranjate crescator in interiorul dublucuvantului.
            ; Exemplu:
            ; pentru sirul initial:
            ; 1432h, 8675h, 0ADBCh, ...
            ; Se va obtine:
            ; 01020304h,  05060708h, 0A0B0C0Dh, ... 
            mov esi, source
            mov edi, destination
            mov ecx, len_s
            cld
            jecxz final
            mov edx, 0
            repeat:
                lodsw; ax:=[esi]
                divide:
                    div byte [a]
                    mov bl, ah
                    mov ah, 0
                    shl ebx, 8
                    cmp al, 0
                    jne divide
                mov eax, ebx
                stosd
                loop repeat
            mov ecx, len_s
            mov esi, edi
            mov edi, list_of_bytes
            repeat1:
                ; mov [list_of_bytes], byte[edi]
                ; inc edi
                
                ; mov [list_of_bytes + 1], byte[edi]
                ; inc edi
                
                ; mov [list_of_bytes + 2], byte[edi]
                ; inc edi
                
                ; mov [list_of_bytes + 3], byte[edi]
                ; inc edi
                stosb 
                lodsb
                
                stosb 
                lodsb
                
                stosb 
                lodsb
                
                stosb 
                lodsb
                
                push ecx
                push esi
                mov dx, 1
                repeat2:
                    cmp dx, 0
                    je nextstep
                    mov esi, list_of_bytes
                    mov dx, 0
                    mov ecx, 3
                    innerLoop:
                        mov al, byte[esi] 
                        cmp al, byte[esi+1]
                        jae next
                        mov bl, byte[esi + 1]
                        mov byte[esi], bl
                        mov byte[esi + 1], al
                        mov dx, 1
                        next:
                            inc esi
                            loop innerLoop
                            jmp repeat2
                nextstep:
                    mov al, byte[esi]
                    shl eax, 8
                    mov al, byte[esi + 1]
                    shl eax, 8
                    mov al, byte[esi + 2]
                    shl eax, 8
                    mov al, byte[esi + 3]
                    mov [edx + result], eax
                    add edx, 1
                    pop esi
                    pop ecx
                    loop repeat1
            final:
                ; exit(0)
                push    dword 0      ; push the parameter for exit onto the stack
                call    [exit]       ; call exit to terminate the program

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
              ; tell nasm that exit exists even if we won't be defining it
                            ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

global _char_into_int                          
                          
; our data is declared here (the variables needed by our program)
segment data public use32 class=data
    ; ...

; our code starts here
segment code public use32 class=code
    start:
        ; ...
        _char_into_int:
            push ebp
            mov ebp, esp	                 	
            mov eax, [ebp+8]
            sub eax, 48
            mov esp, ebp
            pop ebp
            ret
        
        
        ; exit(0)
        ; push    dword 0      ; push the parameter for exit onto the stack
        ; call    [exit]       ; call exit to terminate the program

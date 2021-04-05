bits 32
global start
extern exit, printf, scanf ; exit, printf and scanf are external functions
import exit msvcrt.dll
import printf msvcrt.dll ; tell the assembler that function printf is in msvcrt.dll
import scanf msvcrt.dll ;

segment data use32 class=data
    n dd 0
    message db "n=", 0 ; strings for C functions must end with ZERO (ASCIIZ strings)
    format db "%d", 0 ; strings for C functions must end with ZERO (ASCIIZ strings)
    new_format db "the value of n= %d"
segment code use32 class=code
 start:

    ; calling printf(message) => "n=" will be printed on the screen
    push dword message ; we store the offset of message (not its value) on the stack
    call [printf] ; call printf
    add esp, 4*1 ; free parameters from the stack; 4 = dword size in bytes
    ; 1 = number of parameters
    ; remember that the stack grows towards small addresses and the elements of the stack are dwords.
    ; that is, assuming the dword from the top of the stack is at address ADR, by pushing another dword
    ; on top of the stack, the new dword is on address ADR-4. ESP always points to the top of the stack.
    ; we clear/free 4 bytes from the top of the stack by “add ESP, 4”

    ; call scanf(format, n) => read a decimal number in variable n
    ; parameters are placed on the stack from right to left
    push dword n ; push the offset of n
    push dword format ; push the offset of format
    call [scanf] ;
    add esp, 4 * 2 ; free 2 dwords from the stack
    
    push dword n
    push dword new_format
    call [printf]
    add esp, 4 * 2
    ; call exit(0)
    push dword 0 ; punem pe stiva parametrul pentru exit
    call [exit] ; apelam exit pentru a incheia programul
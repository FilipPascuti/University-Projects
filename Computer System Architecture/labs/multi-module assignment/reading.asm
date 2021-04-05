%ifndef _READING_ASM_
%define _READING_ASM_

; read(n)
    read:
        push ebp 
        mov ebp, esp
        
        mov esi, [ebp + 8]
        mov edi, [ebp + 12]
        
        repeat:
            lodsb; al := [esi]
            cmp al, 0
            je final
            
            cmp al, ','
            jne check_negative
            cmp byte[sign], 1
            je is_neg
            mov bl, al
            mov al, [x]
            stosb
            mov al, bl
            jmp not_neg
            
            is_neg:
            mov bl, al
            mov al, [x]
            neg al
            stosb
            mov al, bl
            not_neg:
            mov byte[sign], 0
            mov edx, 0
            mov ecx, 0
            mov ebx, 0
            mov word[x], 0
            
            check_negative:
                cmp al, '-'
                jne positive
                
                mov byte[sign], 1
                
                positive:
                    cmp al, '0'
                    jae check_if_digit
                    jmp repeat
                    check_if_digit:
                        cmp al, '9'
                        jbe is_digit
                        jmp repeat
                        is_digit:
                        sub al, 48
                        cmp byte[x], 0
                        je new_number
                        mov bl, al
                        mov al, [x]
                        mov byte[x], 10
                        mul byte[x]
                        add al, bl
                        mov word[x], ax
                        new_number:
                            mov byte[x], al
        final:
        
        pop ebp
        ret 
%endif
.model small

.data

    string db "abcbab$"
    success db "It is a palindrome! $"
    failure db "It is not a palindrome! $"
    
.code

    main proc    
        
        mov ax, @data
        mov ds, ax
        
        mov bx, 0
        mov si, offset string   ;points to the starting of the string 
        
        iterate_string:
            mov dl, [si]
            cmp dl, '$'   ;checks if the character is a $
                je break      
            inc bx  ;counts the number of characters in the string
            inc si  ;pointer to the character of the string
            loop iterate_string              
        break:  
        
        mov ax, bx 
        mov cx, ax      
        mov di, offset string   ;setting starting pointer of string
        dec si                  ;si is the ending pointer right now                   
        
        check_palindrome:
            mov dx, [di]
            mov bx, [si]   
            cmp bl, dl
                jne output_false 
            inc di
            dec si
            loop check_palindrome
        
        if_done_iterating:
            jmp output_true
        
        output_false:
            mov ah, 09h
            mov dx, offset failure
            int 21h
            jmp end
        
        output_true:
            mov ah, 09h
            mov dx, offset success
            int 21h
            jmp end 
            
        end:
            mov ah, 4ch
            mov al, 00
            int 21h
        
    endp
    end main
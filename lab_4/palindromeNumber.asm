.model small

.data  
    number dw 12322
    success db "It is a palindrome! $"
    failure db "It is not a palindrome! $"
    
.code

    main proc    
        
        mov ax, @data
        mov ds, ax
        
        mov cx, 0
        mov ax, number
        reverse_number: ;reversed number is stored in cx
            cmp ax, 0
                je break
            mov bx, 10   
            xor dx, dx
            div bx 
            mov di, ax 
            mov si, dx
            mov ax, cx
            mul bx 
            add ax, si
            mov cx, ax
            mov ax, di   
            jmp reverse_number 
        break:
        mov ax, number
        
        cmp ax, cx
            je output_true
            jne output_false
        
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



.model small

.data  
    number dw 14
    success db "It is a prime number! $"
    failure db "It is not a prime number! $"
    
.code

    main proc    
        
        mov ax, @data
        mov ds, ax
        
        mov cx, 0    
        xor dx, dx
        mov ax, number
        mov bx, 2
        div bx
        mov cx, ax  ;cx has the value (number/2) 
        
        check_prime:  
            cmp cx, 1   ;break loop and output true if cx reached 1
                je output_true
            cmp cx, 0
                je output_true ;exceptional case when number is 0
            mov ax, number 
            xor dx, dx
            div cx  
            cmp dl, 0   ;check if number is divisible by cx
                je output_false ;output false if remainder is 0 
                                ;(ie., number is divisible by cx)                 
        loop check_prime
        
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



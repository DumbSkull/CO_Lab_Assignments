.model small

.data  
    plus db " + 4$"
    equals db " = $"
    question db "Enter the value of y: $"
    new_line db 10,13,"$"
    
.code

    main proc    
        
        mov ax, @data
        mov ds, ax 
        
        ;output question
        mov dx, offset question
        mov ah, 09h
        int 21h
        
        ;read input from user
        mov ah, 1
        int 21h
        
        ;do the arithmetic operations
        mov bl, al  
        mov cl, al
        add bl, 4
                 
        ;print new line         
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        ;print the value of x
        mov ah, 02h
        mov dl, bl
        int 21h   
        
        ;print the string " = "
        mov dx, offset equals
        mov ah, 09h
        int 21h 
        
        ;print the value of y        
        mov ah, 02h
        mov dl, cl
        int 21h
        
        ;print the string " + 4"
        mov dx, offset plus
        mov ah, 09h
        int 21h 
        
        
    endp
    end main



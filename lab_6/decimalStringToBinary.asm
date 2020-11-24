.model small

.data

    decimal_string db "61$"
    output_text db "The binary equivalent is: $"
    
.code

    main proc    
        
        mov ax, @data
        mov ds, ax
        
        mov bx, 0
        mov cx, 10
        mov di, 0   ;integral number is stored here
        mov si, offset decimal_string   ;points to the starting of the string 
        
        convert_string_to_int:  ;di register will have the integer value
            mov dx, 0
            mov dl, [si]  ;dl stores the value at address si
            cmp dl, '$'   ;checks if the character is a $
                je break1  ;breaks loop if $ is encountered
            mov bx, dx
            sub bx, 30h   ;converts the character to an integer  
            mov ax, di    ;ax stores the value of the integer value traversed so far
            mul cx        ;multiple ax with 10
            add ax, bx    ;add the current character (digit) to ax
            mov di, ax    ;store this result back to di (di stores 
                          ;integer number of characters traversed so far
            inc si        ;pointer to the character of the string
            jmp convert_string_to_int              
        break1:  
        
        mov si, 0   ;si will now store the number of binary digits 
        mov cx, di  ;cx initially stores the integer
        mov di, 1   ;10s multiple
        
        convert_decimal_to_binary:
            inc si  ;increment si by 1
            cmp cx, 1   ;check if cx == 0 
                je break2
            xor dx, dx  ;clear the remainder register
            mov ax, cx  ;move the value of cx to ax
            mov bx, 2
            div bx      ;divide ax by 2
            mov cx, ax
            push dx     ;push the remainder to stack
      
            ;multiplying di by 10
            mov ax, di  
            mov bx, 10
            mul bx
            mov di, ax
            jmp convert_decimal_to_binary  
            
        break2:
        push cx     ;push the first digit (1) to the top of the stack
        mov bl, 1 
        add bl, 30h ;add 30h or 48 to convert to ascii
        
        print_binary_digits_in_reverse:
            cmp si, 0   ;if si==0, then break
                je break3
            mov bx, 0
            pop bx  ;pop from the stack and store to bx
            add bx, 48  ;add 48 to convert to ASCII
            ;print the last digit: 
            mov ah, 02h     ;Interrup to print digit
            mov dl, bl
            int 21h
            dec si      ;decrement si
            jmp print_binary_digits_in_reverse  
        break3:
                  
        
    endp
    end main
.model small
.data
.code

 main proc
    
   mov cx, 9        ;no. of iterations
       
   sub cx, 2        ;subtracting 2 from the iteration because 
                    ;we're manually displaying the first 0, 1 
   ;display 0: 
   mov ah, 02h   
   mov dl, 48       ;display 0
   int 21h 
   mov ah, 02h   
   mov dl, 44       ;display comma ,  
   int 21h       
   ;display 1:
   mov ah, 02h  
   mov dl, 49       ;display 1
   int 21h
   mov ah, 02h   
   mov dl, 44       ;display comma ,  
   int 21h
                   
   xor ax, ax       ;clearing the values in ax reg
     
   mov si, 0        ;=t1
   mov bx, 1        ;=t2
     
   fibonacci_loop:
      mov dx, bx    ;temporarily store t2's value in dx reg.
      add bx, si    ;add t2+t1 and store in bx
      mov si, dx    ;put t2's value in si (which was initially t1)
      jmp print_bx  ;print value of bx reg
      end_of_fibonacci_loop:
      sub cx, 1
      cmp cx, 0 
      jne fibonacci_loop
      je end
   
   print_bx:
        xor dl, dl    ;clear dl reg  
        mov al, bl    ;store t3 (t2+t1) in al 
        mov bx, 10    ;store 10 in bx
        div bx        ;div ax by 10 (ax now stores the first digit)
        mov di, dx    ;store remainder of the above division in di (ie. 2nd digit)   
        mov bl, al    ;bl now stores the first digit
        ;mov ax, di
        ;mul bl
        ;mov bl, al
        print_first_digit:
                cmp bl, 0
                    je print_second_digit
                add bl, 30h   ;add 30h to represent the number in the ascii code
                mov ah, 02h   ;v
                mov dl, bl    ;display the sum t1+t2 (the sum is sotred in bx register)  
                int 21h       ;^
                sub bl, 30h
        print_second_digit:
                mov ax, bx    ;ax temporarily stores the first digit
                mov bx, di    ;bl now stores the second digit
                mov di, ax    ;di now stores the first digit
                add bl, 30h
                mov ah, 02h   ;v
                mov dl, bl    ;display the sum t1+t2 (the sum is stored in bx register)  
                int 21h       ;^
                sub bl, 30h 
        print_comma:
                mov ah, 02h   
                mov dl, 44    ;display comma ,  
                int 21h  
                
        mov ax,10
        mul di
        add ax, bx
        mov bx, ax
        jmp end_of_fibonacci_loop
   end:                   
    
 endp
 end main.  
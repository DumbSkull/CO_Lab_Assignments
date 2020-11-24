org 100h

; add your code here 
.data
initial_statement db "Enter the value of the highest integer: $"
final_statement db "The integers are: $"

n db ? 

print_string MACRO string
    lea dx, string         ; print output msg
    mov ah, 09h
    int 21h    
print_string ENDM

    
.code
MAIN PROC
    print_string initial_statement  ;input the string: "Enter the number of integers..."
    
    mov dl, 10
    mov bx, 0   ;bl (or bx) is gonna store the number of integers to display
    
    ;user input the number of integers to show:
    scan_input:     
        mov ah, 01h ;interrupt for user input
        int 21h
        
        cmp al, 13  ;check if user inputted ENTER
        je exit_input
        
        mov ah, 0
        sub al, 48  ;converting ascii to decimal
        
        mov cl, al  ;storing the inputted character in cl
        mov al, bl  ;storing the inputted characters (previously) in al
        
        mul dl  ;multiplying the numbers inputted so far by 10
        
        add al, cl  ;adding the current inputted character to the previously entered characters
        mov bl, al  ;moving the numbers inputted so far to bl
        
        jmp scan_input
        
    exit_input:
    
    ;print new line
    mov ah, 2
	mov dl, 10
	int 21h
    
    print_string final_statement    ;print "The integers are: "
    
    mov cx, bx  ;setting cx as the number of integers to show
    mov bx, 4   ;bx is initially 1 (it increments by 1 in each iteration)
       
    
    display_multiples:
        mov ax, bx  ;store current number in ax
        xor dx, dx
        mov di, 4   ;storing 4 as the value of di
        div di
        cmp dx, 0
            je display_integer
        xor dx, dx  ;clearing the dx register from any prev remainders    
        mov di, 7
        mov ax, bx
        div di
        cmp dx, 0
            je display_integer   
        jne end_of_display_integer
        display_integer:
            mov si, bx
            mov n, 0
            iterate_each_digit_from_last:
                inc n
                mov di, 10
                xor dx, dx
                mov ax, si
                div di
                mov si, ax
                push dx
                cmp si, 0
                    jne iterate_each_digit_from_last
            
            display_each_digit_from_stack:
                cmp n, 0
                    je before_end_of_display_integer
                pop si
                add si, 30h
                mov ah, 2
	            mov dx, si
	            int 21h
                
                dec n
                jmp display_each_digit_from_stack
        before_end_of_display_integer:        
            ;display comma:
            mov ah, 2
	        mov dl, 44
	        int 21h
        end_of_display_integer: 
                 
        ;compare and see if bx==cx. if equal, break; else go back to starting of loop     
        cmp bx, cx
        je exit_display_multiples
        inc bx
        jne display_multiples
        
    exit_display_multiples:
    
   
        
    
    ret
MAIN ENDP
    




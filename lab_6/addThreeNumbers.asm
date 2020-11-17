org 100h   

.model small 
       
.data   

msg2 db 13, 10, 'The sum is: $'   
num db 76, 112, 198     
                     
.code  

 start:  
    mov ax,@data     
    mov ds,ax        
    
    addition:               ; function to add numbers
        mov bx, 0            ; bx = 0 (it will store the sum)
        mov cx, 3            ; make counter = 3
        mov si, offset num   ; si holds the offset address
        loop_add: 
            mov ax, 0        ; ax = 0
            mov al, [si]     ; al = num[i]
            add bx, ax       ; add num to bx
            inc si          ; increment si
            loop loop_add   ; jump bck to start
            
        lea dx, msg2         ; print output msg
        mov ah, 09h
        int 21h
        
        mov ax, 0            ; ax=0
        mov ax, bx           ; ax = sum of numbers
        call print          ; print the sum
        ret 
  
 
PRINT PROC		        ; print function 
     
	mov cx, 0            ; initialize counter = 0
	mov dx, 0            ; dx = 0
	label1: 
		cmp ax, 0        ; if ax = 0
		je print1	    ; jump to print the number
		mov bx, 10		; bx =10 
		div bx			; ax= ax/bx= ax/10	  
		push dx			; push remainder(dx) onto stack 
		inc cx			; increment counter 
		xor dx, dx       ; set dx = 0
		jmp label1      ; jump to top
	
	print1:             ; print the number
		cmp cx, 0        ; if counter becomes 0
		je exit         ; return back from the print proc
		pop dx          ; pop dx
		add dx, 48       ; print the value
		mov ah, 02h 
		int 21h 
		dec cx          ; decrement counter
		jmp print1      ; jump to top
    exit: 
        ret
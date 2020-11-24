
org 100h
 
.data 
    initial_statement db "The array before sorting: $"
    final_statement db "The array after sorting is: $" 
    arr db 7, 6, 3, 1, 4    ;The array to be sorted
    arr_length EQU 5   ;The number of elements in the array
    p DB ?
    j DB ?
    i DB ?
    l DB 0 
    h DB 4
    
 
;macro to print a string    
PRINT MACRO string           
    mov dx, offset string   ;storing the offset of the string in dx
    mov ah, 09h ;interrup method to print a string
    int 21h ;INTERRUPT
PRINT ENDM
    
    
.code

    main PROC
        
        PRINT initial_statement ;printing the initial statement : "the array before sorting: "
        CALL PRINT_ARRAY ;printing the elements of the array (before sorting)
        CALL quickSort
        end_quicksort:  ;when the quicksort function has ended.
            ;print new line:
            mov ah, 2
	        mov dl, 10
	        int 21h
	        
            PRINT final_statement 
            CALL PRINT_ARRAY    ;print the final sorted array
            jmp end 
        RET
        
    main ENDP  
    
    ;PROCEDURE to print the array elements: 
    PRINT_ARRAY PROC
        xor cx, cx
        mov cl, arr_length
        print_loop:
           mov bl, arr_length  ;store the array length in bl
           sub bl, cl  ;subtract the counter pointer from the bx register (array_length - cx)
           mov ah, 02h ;the interrup method to print a digit
           mov dl, arr[bx]
           add dx, 30h ;adding 30h for the ASCII conversion
           int 21h ;INTERRUPT
           
           ;print comma:
           mov ah, 02h ;the interrup method to print a digit
           mov dl, 44 ;adding 30h for the ASCII conversion
           int 21h ;INTERRUPT                                           
        loop print_loop
        RET     
    PRINT_ARRAY ENDP
    
    
    ;quicksort algo:
    ;quickSort(arr[], low, high)
    ;{
    ;    if (low < high)
    ;    {
    ;        pivot = partition(arr, low, high);
    ;        quickSort(arr, low, pivot - 1); 
    ;        quickSort(arr, pivot + 1, high);
    ;    }
    ;}
    quickSort PROC
        mov al, l
        cmp al, h   ;if l=>h then end the function
            jge end_quicksort
            
        CALL partition ;changes p 
        
         
        
        mov al, l   ;pushing l to stack to retain l
        push ax
        mov al, h   ;pushing h to stack to retain h
        push ax
        mov al, p   ;pushing p to stack to retain p
        
        ;change high to pivot-1:
        mov al, p
        sub al, 1
        mov h, al
        
        CALL quickSort
        
        ;retain back l, h, and p:
        pop ax  ;retains p
        mov p, al
        pop ax  ;retains h
        mov h, al
        pop ax  ;retains l
        mov l, al
        
        ;change low to pivot+1
        add al, p
        add al, 1
        mov l, al
        
        CALL quickSort
        
       
        
    quickSort ENDP
    
    
    ;partition algo:
    ;partition (arr[], low, high)
    ;{
    ;    pivot = arr[high];  
    ;    i = (low - 1) // Index of smaller element
    ;    for (j = low; j <= high- 1; j++)
    ;    {
    ;        if (arr[j] < pivot)
    ;        {
    ;            i++;    // increment index of smaller element
    ;            swap arr[i] and arr[j]
    ;        }
    ;    }
    ;    swap arr[i + 1] and arr[high])
    ;    return (i + 1)
    ;}

    partition PROC
        xor bx, bx
        mov bl, h 
        mov dl, arr[bx]
        mov p, dl   ;p = arr[h]
        mov bl, l   
        mov i, bl   ;i = low
        sub i, 1    ;i = low-1
        mov j, bl   ;j = low
        for_loop:
            mov bl, h
            sub bl, 1   ;bl = hi-1
            cmp bl, j
                jl  end_for_loop
            xor bx, bx    
            mov bl, j
            mov dl, arr[bx]     ;dl=arr[j]    
            cmp dl, p
                jge if_false
            if_true:
                add i, 1    ;i++
                ;swap arr[i], arr[j]
                xor bx, bx
                mov bl, i   ;bl=i
                mov dl, arr[bx] ;dl = arr[bl] = arr[i]
                mov bl, j
                mov cl, arr[bx] ;cl = arr[j]
                mov bl, i
                mov arr[bx], cl  ;arr[i]=arr[j]
                mov bl, j
                mov arr[bx], dl ;arr[j]= PREVIOUS arr[i] 
            if_false:
            add j, 1    ;j++
            jmp for_loop    
        end_for_loop:
        ;swap arr[i+1], arr[h]
        xor bx, bx
        mov bl, i   ;bl=i  
        add bl, 1   ;bl=i+1
        mov dl, arr[bx] ;dl = arr[bl] = arr[i+1]
        mov bl, h
        mov cl, arr[bx] ;cl = arr[h]
        mov bl, i 
        add bl, 1
        mov arr[bx], cl  ;arr[i+1]=arr[h]
        mov bl, h
        mov arr[bx], dl ;arr[j]= PREVIOUS arr[i]
        ;change p=i+1
        xor bx, bx
        mov bl, i
        mov p, bl
        add p, 1
    ret    
    
    partition ENDP
    
    end:





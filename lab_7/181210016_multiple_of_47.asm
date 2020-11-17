.STACK 100H
.DATA
    A DW 4
    WSP DB ' ', '$'
    COUNT DW ?
    RES DB 10 DUP ('$')
.CODE

DISPLAY MACRO string
    MOV AH, 9
    LEA DX, string
    INT 21H
ENDM

Main PROC FAR
    ; load data
    MOV AX, @DATA     
    MOV DS, AX

    ; Call procedure
    CALL Fibbonacci

    ; exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP

Fibbonacci PROC

    MOV AX, 0               ; Clear A just in case
    CALL Inputval           ; Input Count           
    MOV COUNT, BX           ; Store count for reference

loop:
    MOV AX, A               ; Load current number to AX
    MOV BX, 4               ; Move 4 to BX
    DIV BL                  ; Divide by 4
    CMP AH, 0               ; Check if remainder 0
    JE decrement            ; If yes the number is a multiple of 4 print number
    MOV AX, A               ; else, load number again
    MOV BX, 7               ; Move 7 to BX
    DIV BL                  ; Divide by 7
    CMP AH, 0               ; Check if remainder 0
    JE decrement            ; If yes the number is a multiple of 7 print number
    JMP continue            ; otherwise, go to next number

decrement:                  ; Number is a multiple of 4 or 7
    MOV AX, A               ; load number for printing
    LEA SI, RES             ; Load string buffer
    CALL Hexconv            ; Convert number to ascii
    DISPLAY RES             ; Print number
    DISPLAY WSP             ; Print a white space
    DEC COUNT               ; We have printed one, decrement remaining count

continue:   
    INC A                   ; Increment by 1, check again.
    CMP COUNT, 0            ; Check if we need to print more
    JNE loop                ; Print more if necessary
    ret                     ; else exit

Fibbonacci ENDP

Inputval PROC
    MOV BX, 0               ; Clear BX for output
    MOV CX, 10              ; Move 10 to CX for multiplying digits
readnext:
    MOV AH, 1h              ; Set input mode
    INT 21h                 ; call system interrupt and req input
    CMP AL, 13              ; Check if input was enter
    JE exit                 ; If it was input is complete
    SUB AL, 30H             ; Convert ascii to number
    MOV AH, 0               ; clear high bit
    MOV DX, AX              ; Store input to dx temporarly
    MOV AX, BX              ; move exisitng value to ax
    MUL CL                  ; and multiply by 10 to move up a digit
    MOV BX, AX              ; Store old value back to bx
    ADD BX, DX              ; Add current digit to old value
    JMP readnext            ; read next digit
    
exit:
    ret                     ; exit
    
Inputval ENDP

Hexconv PROC
    MOV CX, 0               ; Set digit position counter
    MOV BX, 10              ; Load 10 to BX as base = 10

convert:
    MOV DX, 0               ; Clear remainder
    DIV BX                  ; Divide number by 10
    ADD DL, 30H             ; Convert remainder to ascii by adding 0x30
    PUSH DX                 ; push to stack
    INC CX                  ; increment digit counter
    CMP AX, 9               ; Compare remaining number to 9
    JG convert              ; If number is greater than 9 try for next digit

    ADD AL, 30H             ; Convert remaining number to ascii
    MOV [SI], AL            ; and add it to output string

format:
    POP AX                  ; Get next digit out of stack
    INC SI                  ; move to next digit pos    
    MOV [SI], AL            ; Add current digit to string
    LOOP format             ; loop until no digits remain
    INC SI                  ; Since we reuse RES for every digit,
    MOV [SI], '$'           ; Set null terminator at correct location
    ret
Hexconv ENDP
END MAIN
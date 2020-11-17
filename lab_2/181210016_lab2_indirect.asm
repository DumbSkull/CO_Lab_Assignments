ORG 100h

mov [8032h], 5
mov si, 8032h 
mov ax, 3
add ax, [si]
sub ax, [si]
mul [si]
div [si]


org 0x7c00
jmp _start

_start:
    xor ax,ax
    xor si, si
    xor cx, cx
    xor dx, dx
    
    call getinput
    call endl
    
    call solve
    
    ;xor cx, cx
    ;xor bx, bx
    ;mov bx, 1
    ;push bx
    ;push bx
    ;call fib
    
    call done
    
getinput:
    mov ah, 0x00 
    int 16h
    
    cmp al, 0x0d
    jmp .done
    
    inc cx
    
    sub ax, '0' 
    stosb
    add ax, '0'
    
    call putchar
    
    jmp getinput
    
    .done: 
        ret
        
putchar:
    mov ah, 0x0e
    int 10h
    ret

endl:
    mov ax, 0x0a
    call putchar
    mov ax, 0x0d
    call putchar
    ret
    
solve:
    xor si, si
    xor bx, bx
    
    lodsb
    mov bx, ax
    
    lodsb
    
    cmp cl, 2
    jne .not_dez
    
    cmp cl, 2
    je .dez

    .not_dez:
        xor ax, ax
        mov ax, bx
        ret

    .dez:
        imul bx, 10
        add ax, bx
        ret
         
fib:
    cmp cx, ax
    je .endfib
    
    inc cx
    
    pop dx
    
    pop bx
    
    add dx, bx
    
    push dx
    
    push bx
    
    jmp fib
    
    .endfib:
        xor ax, ax
        mov ax, bx
        jmp .mod11
    
    .mod11:
        cmp ax, 11
        jb .done
        
        sub ax, 11
        jmp .mod11
        
        .done:
            call putchar
            ret
    
done:
    jmp $
    
times 510 - ($ - $$) db 0
dw 0xaa55




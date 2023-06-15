org 0x7c00 ; todo codigo começa com isso
msg db "Como e facil trocar de cor"

start:
    xor ax, ax ; valor
    xor bx, bx ; cor
    xor cx, cx ; counter
    xor si, si ; vetor
    xor dx, dx
    call read
    call return
    xor si, si
    call adapt
    xor si, si
    mov si, msg
    call final
    call done

read:  ;ler a entrada
    call get_char
    cmp al, 0x0d    ; 0x0d é o final do enter (para identificar se foi pressionado o enter)
    je .exit
        inc cx
        sub ax, '0' ; tirando o valor da tabela ascii
        stosb       ; salvando o vetor
        add ax, '0'
        call put_char
        jmp read
    .exit:
        ret
    
    
return: ;função p ler o enter
    mov ah, 0x0a
    call put_char
    mov ah, 0x0d ; segunda parte do enter
    call put_char
    ret

get_char:
    mov ah, 0x00 
    int 16h        ; interrupção do teclado
    ret
    
put_char:
    mov ah, 0x0e  ; valor expecifico para printar
    int 10h       ; ^
    ret
    
adapt: ; adaptar o vetor para um numero normal
    lodsb 
    mov dx, ax
    cmp cx, 2
    je .dezena
        ret
    .dezena:
        xor ax, ax
        lodsb
        imul dx, 10
        add dx, ax ;com isso bx vira um numero de duas dezenas
        ret 

final:
    lodsb 
    cmp al, 0
    je .return
        mov ah, 0eh
        mov bh, 0
        mov bx, dx
        int 10h
        jmp final
        
    .return:
        ret
    
    
done:
    jmp $
    
times 510 - ($ - $$) db 0
dw 0xaa55
    
    

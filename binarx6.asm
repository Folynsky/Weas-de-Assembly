pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal de dos digitos$"
    binar db "El numero binario es:$"
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:pila
    push ds
    mov ax,0
    push ax

    mov ax,datos
    mov ds,ax

    ; código
    mov ah,09h
    lea dx, peticion
    int 21h

    mov ah, 01h
    int 21h
    sub al, 48
    mov bl, al  ; Guardar el primer dígito en bl

    mov ah, 01h
    int 21h
    sub al, 48
    mov bh, al  ; Guardar el segundo dígito en bh

    ; Combinar los dígitos para formar un número de dos dígitos
    mov ax, 0
    mov al, bl
    mov ah, 0
    mov cl, 10
    mul cl       ; ax = bl * 10
    add ax, bx   ; ax = bl * 10 + bh

    ; Convertir a binario
    mov cx, 16   ; Número máximo de bits para un número de dos dígitos
    mov bx, 1
    shl bx, cl   ; bx = 2^16
    mov cx, 16
    mov dx, 0

conv_binario:
    mov ax, 0
    div bx       ; dx = ax % 2, ax = ax / 2
    add dl, '0'
    push dx
    dec cx
    jnz conv_binario

    ; Imprimir el número binario
    mov ah, 09h
    lea dx, binar
    int 21h

mostrar:
    pop dx
    mov ah, 02h
    int 21h
    loop mostrar

    mov ah, 4ch
    int 21h 

compa endp
codigo ends
end compa

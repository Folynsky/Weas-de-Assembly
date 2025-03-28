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

    ; Convertir a binario
    mov ax, 0
    mov al, bl
    mov ah, 0
    shl ax, 1   ; Multiplicar por 2 (primer dígito * 2)
    add al, bh  ; Sumar el segundo dígito

    ; Guardar el número binario en la variable binar
    mov bl, 8   ; Inicializar el contador para los bits
    mov cx, 8   ; Número total de bits para un número de dos dígitos

conv_binario:
    mov dl, '0'
    test al, 10000000b  ; Verificar el bit más significativo
    jz cero
    mov dl, '1'

cero:
    mov bx, offset binar    ; Cargar la dirección base de la variable binar en bx
    add bx, bl              ; Sumar el valor de bl a la dirección base para obtener la dirección deseada
    mov [bx], dl            ; Guardar el bit en la posición correspondiente
    shl al, 1   ; Desplazar los bits a la izquierda
    dec bl
    loop conv_binario

    ; Imprimir el número binario
    mov ah, 09h
    lea dx, binar
    int 21h

    mov ah, 4ch
    int 21h 

compa endp
codigo ends
end compa

pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal de dos digitos$"
    binar db "El numero binario es: $"
    numero db ?
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:pila
    push ds
    mov ax, 0
    push ax

    mov ax, datos
    mov ds, ax

    ; Pide al usuario que ingrese un número decimal de dos dígitos
    mov ah, 09h
    lea dx, peticion
    int 21h

    ; Lee el primer dígito y lo convierte a número
    mov ah, 01h
    int 21h
    sub al, 48
    mov bl, al ; Guarda el primer dígito en bl

    ; Lee el segundo dígito y lo convierte a número
    mov ah, 01h
    int 21h
    sub al, 48
    mov bh, al ; Guarda el segundo dígito en bh

    ; Combina los dígitos para formar un número de dos dígitos
    mov ax, 0
    mov al, bl ; Coloca el primer dígito en la parte baja de ax
    mov ah, 0
    shl ax, 1  ; Multiplica por 2 (primer dígito * 2)
    add al, bh ; Suma el segundo dígito

    ; Convierte el número a binario
    mov cx, 8 ; Número de bits para un número de dos dígitos
    mov bx, 1 ; Inicializa el divisor a 1

    conv_binario:
        mov dx, 0
        div bx ; Divide ax por 2 (resto en dx, cociente en ax)
        or dl, '0' ; Convierte el resto a ASCII
        push dx ; Guarda el dígito binario en la pila
        loop conv_binario

    ; Imprime el número binario
    mov ah, 09h
    lea dx, binar
    int 21h

    mostrar:
        pop dx ; Recupera el dígito binario de la pila
        add dl, 48 ; Convierte el dígito a ASCII
        mov ah, 02h
        int 21h
        loop mostrar

    mov ah, 4ch
    int 21h

compa endp
codigo ends
end compa

pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal de dos digitos$"
    binar db "El numero binario es:$"
    numero db ?
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

;codigo
    mov ah,09h
    lea dx, peticion
    int 21h

    mov ah, 01h
    int 21h

;sabe
    sub al, 48
    mov bh, al ; Guarda el primer dígito en bh

    mov ah, 01h
    int 21h
    sub al, 48
    mov bl, al ; Guarda el segundo dígito en bl

    ; Combina los dígitos para formar un número de dos dígitos
    mov ax, 0
    mov al, bh ; Coloca el primer dígito en la parte baja de ax
    mov ah, 0
    shl ax, 1  ; Multiplica por 2 (primer dígito * 2)
    add al, bl ; Suma el segundo dígito

    ; Convierte el número a binario
    mov cx, 16 ; Número de bits para un número de dos dígitos
    mov bx, 1 ; Inicializa el divisor a 1

    mov dx, 0 ; Resto inicializado a 0

    conv_binario:
        shl dx, 1 ; Desplaza el resto a la izquierda
        mov ax, dx ; Carga el resto en ax
        div bx ; Divide ax por 2 (resto en dx, cociente en ax)
        mov dx, 0 ; Reinicia el resto a 0
        or dl, '0' ; Convierte el resto a ASCII
        mov [binar + cx - 1], dl ; Almacena el dígito binario en la posición correcta
        loop conv_binario

    ; Imprime el número binario
    mov ah, 09h
    lea dx, binar
    int 21h

    mostrar:
        mov dl, [binar + cx]
        mov ah, 02h
        int 21h
        dec cx
        jnz mostrar

    mov ah, 4ch
    int 21h

compa endp
    codigo ends
    end compa

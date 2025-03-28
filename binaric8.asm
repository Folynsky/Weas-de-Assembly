pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal entre 0 y 99$"
    binar db "El numero binario es:$"
    resultado db 9 dup (?) ; Almacenar el resultado binario como cadena
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

    ; Código
    mov ah, 09h
    lea dx, peticion
    int 21h

    mov ah, 01h
    int 21h

    ; Convertir los ASCII a valor decimal
    sub al, 30h   ; Convertir dígito de las unidades a valor decimal
    mov bl, al    ; Guardar dígito de las unidades

    mov ah, 01h
    int 21h

    sub al, 30h   ; Convertir dígito de las decenas a valor decimal
    mov cl, al    ; Guardar dígito de las decenas

    ; Combinar dígitos de las unidades y decenas
    mov al, cl    ; Colocar dígito de las decenas en AL
    mov ah, 0
    mov cx, 10    ; Multiplicar dígitos de las decenas por 10
    mul cx        ; AX = AX * 10
    add ax, bx    ; Sumar dígito de las unidades a AX

    ; Convertir número a binario
    mov bx, 2
    mov cx, 8    ; Tamaño de un byte en bits
    mov si, offset resultado + 7    ; Puntero al último dígito de la cadena resultado

    ; Almacenar los dígitos binarios en la cadena resultado en orden inverso
conversion_loop:
    mov dx, 0
    div bx      ; Dividir por 2
    add dl, '0' ; Convertir el residuo en carácter ASCII
    mov [si], dl ; Almacenar el resultado en la cadena
    dec si      ; Decrementar el índice
    dec cx      ; Decrementar el contador de bits restantes
    cmp cx, 0
    jnz conversion_loop

    ; Mostrar el resultado binario en orden correcto
    mov si, offset resultado
mostrar_loop:
    mov ah, 02h
    mov dl, [si] ; Tomar el siguiente dígito binario de la cadena
    int 21h
    inc si      ; Avanzar en la cadena
    cmp si, offset resultado + 8 ; Comprobar si se llegó al final de la cadena
    jne mostrar_loop

    mov ah, 4ch
    int 21h
compa endp

codigo ends
end compa

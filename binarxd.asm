pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal$"
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

    ;codigo
    mov ah,09h
    lea dx, peticion
    int 21h

    ; Captura el número de tres dígitos
    mov cx, 0  ; Inicializamos cx para que sirva de contador de dígitos
captura_digitos:
    mov ah, 01h
    int 21h
    cmp al, 13  ; Comparamos con Enter (13 en ASCII) para finalizar la captura
    je fin_captura
    sub al, '0'  ; Convertimos de ASCII a número
    mov bl, 10
    mul bl  ; Multiplicamos el número actual por 10 para "moverlo" una posición a la izquierda
    add cx, ax  ; Sumamos el número actual al total
    jmp captura_digitos

fin_captura:
    ; Convertir el número a binario
    mov si, offset binar + 15  ; Posición del último dígito binario
    mov bx, 2   ; Divisor para la conversión a binario
    mov ax, cx  ; Movemos el número capturado a ax para manipularlo

convertir_binario:
    xor ah, ah  ; Limpiar el registro ah para dividir correctamente
    div bx      ; Dividir ax por 2
    add ah, '0' ; Convertir el residuo a ASCII
    dec si      ; Mover al siguiente dígito binario
    mov [si], ah ; Almacenar el dígito binario en la cadena
    cmp ax, 0   ; ¿Se ha completado la conversión?
    jne convertir_binario

    ; Imprimir el resultado
    mov ah, 09h
    lea dx, binar
    int 21h

    mov ah, 4ch
    int 21h 

compa endp
codigo ends
end compa

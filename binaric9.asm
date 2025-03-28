pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero: $"
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
    ;IMPRIMIR CADENA
    lea dx, peticion
    mov ah, 09h
    int 21h
    ;FIN DE IMPRESION

    ;INICIA PRIMER DATO

    mov cx, 2
captura:
    mov ah, 07h
    int 21h
    cmp al, 30h
    jb captura
    cmp al, 39h
    ja captura
    mov ah, 02h
    mov dl, al
    int 21h
    mov dh, 0
    sub dl, 30h
    push dx
    mov ax, 30h
    loop captura

    ;CONVERTIR PRIMER NUMERO

    ;MULTIPLICAR
    mov bx, 1
    mov dx, 0
    mov suma, 0
    ;DEFINE CANTIDAD DE LOOPS	
    mov cx, 2
Convertir1:
    pop ax
    mul bx
    add suma, ax
    mov ax, bx
    mov bx, 10
    mul bx
    mov bx, ax
    mov dx, 0
    loop Convertir1
    mov ax, suma
    mov dato1, ax
    mov suma, 0

    ; Convertir número a binario
    mov bx, 2
    mov cx, 8    ; Tamaño de un byte en bits
    mov si, 0    ; Índice para iterar sobre el resultado binario

    ; Almacenar los dígitos binarios en una cadena
conversion_loop:
    mov dx, 0
    div bx      ; Dividir por 2
    add dl, '0' ; Convertir el residuo en carácter ASCII
    mov [resultado+si], dl ; Almacenar el resultado en la cadena
    inc si      ; Incrementar el índice
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

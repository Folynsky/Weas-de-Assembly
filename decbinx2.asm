pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
    num db ?
    resultado db ?
    binario db 8 DUP(?)
datos ends
codigo segment
    assume cs:codigo, ds:datos, ss:pila
    public compa

compa proc far
    push ds
    mov ax,0
    push ax

    mov ax,datos
    mov ds,ax

    ; Leer primer dígito
    mov ah, 01h ; función de entrada de un carácter desde el teclado
    int 21h     ; leer un carácter en AL
    sub al, 30h ; convertir de carácter a número
    mov bl, al  ; almacenar el primer dígito en bl

    ; Leer segundo dígito
    mov ah, 01h ; función de entrada de un carácter desde el teclado
    int 21h     ; leer un carácter en AL
    sub al, 30h ; convertir de carácter a número

    ; Combinar los dígitos
    mov ah, 0   ; limpiar ah
    mov al, bl  ; mover el primer dígito a al
    mov cl, 10  ; multiplicar por 10
    mul cl      ; al = al * 10
    add al, al  ; sumar el segundo dígito

    mov num, al ; almacenar el número en la variable num

    ; Realizar la comparación
    mov al, num     ; cargar el número en al
    mov bl, 00000001b ; cargar la primera cadena en bl
    and al, bl      ; realizar la comparación con la primera cadena

    ; Almacenar el resultado en la pila
    mov resultado, al ; almacenar el resultado en la variable resultado
    mov al, resultado ; mover el resultado a al

    ; Si el resultado es 0, almacenar un 0 en la pila; si no, almacenar un 1
    jz guardar_cero
    mov al, 1
    jmp guardar_valor

guardar_cero:
    mov al, 0

guardar_valor:
    push ax

    ; Desapilar los elementos de la pila y construir el número binario
    mov cx, 8 ; contador para el bucle (8 bits)
    mov si, OFFSET binario ; puntero al inicio del buffer binario

    bucle_desapilar:
        pop ax          ; desapilar un elemento de la pila
        add al, '0'     ; convertir el número a su representación ASCII
        mov [si], al    ; almacenar el número en el buffer binario
        inc si          ; mover el puntero al siguiente elemento del buffer
        loop bucle_desapilar ; repetir hasta que se hayan desapilado todos los elementos

    ; Imprimir el número binario resultante
    mov ah, 09h      ; función de salida de cadena
    lea dx, binario  ; cargar la dirección del buffer binario en dx
    int 21h          ; imprimir el número binario

    ; Aquí ya tendrías el número de dos dígitos almacenado, impreso en pantalla
    ; y también el resultado de la comparación almacenado en la pila

    mov ah, 4Ch      ; función de terminación del programa
    int 21h
compa endp

codigo ends
end compa

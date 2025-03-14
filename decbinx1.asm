pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
    num db ?
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

    ; Imprimir el número
    mov dl, num ; cargar el número en dl
    add dl, 30h ; convertir el número a su representación ASCII
    mov ah, 02h ; función de salida de carácter
    int 21h     ; imprimir el primer dígito

    mov dl, 0Dh ; imprimir una nueva línea
    mov ah, 02h ; función de salida de carácter
    int 21h     ; imprimir el retorno de carro

    mov dl, 0Ah ; imprimir una nueva línea
    mov ah, 02h ; función de salida de carácter
    int 21h     ; imprimir la nueva línea

    ; Aquí ya tendrías el número de dos dígitos almacenado y también impreso en pantalla

    mov ah, 4Ch ; función de terminación del programa
    int 21h
compa endp

codigo ends
end compa

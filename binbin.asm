pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    numero db ?
    binario db 9 DUP(?) ; Para almacenar el número binario de 8 bits
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

    ; Leer el número de dos dígitos
    mov ah, 01h
    int 21h
    sub al, '0' ; Convertir el dígito ASCII a valor numérico
    mov numero, al

    mov ah, 01h
    int 21h
    sub al, '0' ; Convertir el dígito ASCII a valor numérico
    mov bl, al

    ; Combinar los dos dígitos en un solo byte
    mov ah, 0
    mov al, numero
    shl ax, 4
    add al, bl

    ; Convertir el número a binario
    CALL CONVERTIR_BINARIO

    ; Imprimir el número binario
    CALL IMPRIMIR_BINARIO

    ; Interrupción para salir
    MOV AH, 4CH
    INT 21H

compa endp

CONVERTIR_BINARIO PROC
    ; Inicializar el contador a 8 (número de bits para un número de 8 bits)
    mov cx, 8

    ; Convertir el número a binario y almacenarlo en la cadena binaria
convertir_loop:
    ; Obtener el bit menos significativo
    test al, 1
    jz bit_cero
    mov byte ptr [binario + cx - 1], '1'
    jmp siguiente_bit
bit_cero:
    mov byte ptr [binario + cx - 1], '0'
siguiente_bit:
    ; Desplazar el número hacia la derecha para obtener el siguiente bit
    shr al, 1
    ; Decrementar el contador
    dec cx
    ; Comprobar si hemos procesado todos los bits
    cmp cx, 0
    jne convertir_loop

    ret
CONVERTIR_BINARIO ENDP

IMPRIMIR_BINARIO PROC
    ; Inicializar el contador a 8 (número de bits para un número de 8 bits)
    mov cx, 8

    ; Mostrar la cadena binaria bit a bit
    mostrar:
        mov dl, [binario + cx - 1]
        mov ah, 02h
        int 21h
        loop mostrar

    ret
IMPRIMIR_BINARIO ENDP

codigo ends
end compa

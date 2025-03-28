pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    d1 dw 16 ; Ejemplo: número decimal de 16 bits
    binario db 17 DUP(?) ; Para almacenar el número binario de hasta 16 bits
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

    ; Cargar el número decimal de 16 bits en AX
    mov ax, d1

    ; Convertir el número a binario
    CALL CONVERTIR_BINARIO

    ; Imprimir el número binario
    CALL IMPRIMIR_BINARIO

    ; Interrupción para salir
    MOV AH, 4CH
    INT 21H

compa endp

CONVERTIR_BINARIO PROC
    ; Inicializar el contador a 16 (número de bits para un número de 16 bits)
    mov cx, 16

    ; Inicializar el registro DX a 0
    xor dx, dx

CONV_LOOP:
    ; Desplazar el número hacia la izquierda (equivalente a multiplicar por 2)
    shl ax, 1

    ; Obtener el bit más significativo y guardarlo en DL
    adc dx, 0

    ; Convertir el bit a ASCII y almacenarlo en la cadena binaria
    add dl, '0'
    mov [binario + cx - 1], dl

    ; Decrementar el contador
    dec cx

    ; Comprobar si hemos procesado todos los bits
    cmp cx, 0
    jne CONV_LOOP

    ret
CONVERTIR_BINARIO ENDP

IMPRIMIR_BINARIO PROC
    ; Inicializar el contador a 16 (número de bits para un número de 16 bits)
    mov cx, 16

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

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

;codigo
    ; Leer el número de dos dígitos ingresado por el usuario
    MOV AH, 01h  ; Función de lectura de teclado
    INT 21h      ; Leer el primer dígito
    SUB AL, '0'  ; Convertir el ASCII a número
    MOV BL, AL   ; Guardar el primer dígito en BL

    MOV AH, 01h  ; Función de lectura de teclado
    INT 21h      ; Leer el segundo dígito
    SUB AL, '0'  ; Convertir el ASCII a número
    MOV BH, AL   ; Guardar el segundo dígito en BH

    ; Combinar los dos dígitos en un solo byte
    MOV AH, BL   ; Mover el primer dígito a la parte alta del byte
    MOV AL, BH   ; Combinar el segundo dígito en la parte baja del byte


    MOV CX, 8    ; Inicializar el contador a 8 bits

CONVERTIR:
    MOV DX, 0        ; Limpiar DX para la división
    MOV BL, 2
    DIV BL   ; Dividir AX por 2
    ADD DL, '0'      ; Convertir el resto a ASCII
    MOV [binario + CX - 1], DL ; Guardar el bit en la posición correspondiente de la cadena binaria
    DEC CX           ; Decrementar el contador
    CMP AX, 0        ; Comprobar si hemos terminado
    JNZ CONVERTIR    ; Si no es cero, repetir

    ; Imprimir el resultado binario
    MOV AH, 09h      ; Función de impresión de cadena
    LEA DX, binario  ; Cargar la dirección de la cadena binaria
    INT 21h

    MOV AH, 4CH      ; Salir del programa
    INT 21H

compa endp
    codigo ends
    end compa

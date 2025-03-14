pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero: $"
    dato1 db ?  ; Cambiado a db para que sea un byte
    cadenamenos db "-$"
    suma dw  ?
    Res db " El resultado final es: $"
    ban dw ?
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:pila
    PUSH ds
    MOV ax,0
    PUSH ax
    MOV ax,datos             
    MOV ds,ax

; Limpiar la pantalla
    MOV AH, 00h
    MOV AL, 03h  ; Modo de video (80x25)
    INT 10h

    ;INICIA ESTRUCTURA CODIGO
    inicio:
        ;IMPRIMIR CADENA
        lea DX,cadena
        MOV AH,09H
        INT 21H
        ;FIN DE IMPRESION

        ;INICIA PRIMER DATO

        MOV cx,2
    captura:
        MOV AH,01h    ; Leer un carácter
        INT 21h
        CMP AL, '0'
        JB captura
        CMP AL, '9'
        JA captura
        MOV AH,02h    ; Imprimir el carácter
        MOV DL,AL
        INT 21h
        MOV DH,0
        SUB DL,'0'    ; Convertir de ASCII a valor numérico
        MOV BL, DL    ; Guardar el dígito en BL
        MOV AH, 0     ; Limpiar AH
        MOV AL, dato1 ; Cargar dato1 en AL
        MOV DL, 0     ; Limpiar DL
        MOV CL, 10    ; Cargar 10 en CL
        MUL CL        ; Multiplicar AL por 10
        ADD AL, BL    ; Sumar el nuevo dígito
        MOV dato1, AL ; Guardar el resultado en dato1

        DEC CX        ; Decrementar contador
        JNZ captura   ; Volver a capturar si CX != 0

        ;salto de linea para el primer proporcionamiento del numero
        mov ah,02h
        mov bh,0
        mov dh,1
        mov dl,0
        int 10h

        ;IMPRIMIR CADENA
        lea DX,cadena
        MOV AH,09H
        INT 21H
        ;FIN DE IMPRESION

        jmp opcionAnd
    opcionAnd:
        ; Inicializar el resultado en 0
        MOV BL, 0

        ; Inicializar la máscara de bits en 1 (00000001)
        MOV AL, 1

        ; Realizar el loop 8 veces (de 0 a 7)
        MOV CX, 8

    bucleAnd:
         ; Realizar la operación AND entre dato1 y la máscara de bits actual
    MOV AH, 0   ; Limpiar AH
    MOV AL, dato1
    AND AL, 1   ; Máscara de bits actual

    ; Comparar el resultado con 0
    CMP AL, 0
    JNZ esUno   ; Si no es cero, salta a esUno

    ; Si es cero, el resultado es '0'
    mov al, '0'
    push ax
    jmp escribe

esUno:
    ; Si no es cero, el resultado es '1'
    mov al, '1'
    push ax
    jmp escribe

        ; Desplazar la máscara de bits a la izquierda para la próxima iteración
        SHL AL, 1

        ; Decrementar el contador
        DEC CX
        JNZ bucleAnd

        ; Imprimir salto de línea
        mov dl, 0dh
        mov ah, 02h
        int 21h
        mov dl, 0ah
        int 21h

escribe:
        ; Imprimir el resultado actual (0 o 1)
        mov ah, 02h
        int 21h

; Salir del programa
    mov ah, 4ch
    int 21h

    compa endp
    codigo ends
    end compa

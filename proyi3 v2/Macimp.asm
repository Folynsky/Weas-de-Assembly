imprimeC MACRO texto
    push ax
    push dx
    mov ah, 02h           ; Función de la BIOS para mover el cursor
    mov bh, 0             ; Número de página
    mov dh, [cursorY]     ; Fila
    mov dl, 0             ; Columna siempre al inicio de la línea
    int 10h               ; Llamada a la interrupción de la BIOS
    lea dx, OFFSET texto
    mov ah, 09h
    int 21h               ; Llamada a la interrupción de DOS para imprimir texto
    inc byte ptr [cursorY]  ; Incrementa la posición Y del cursor para la próxima línea
    pop dx
    pop ax
ENDM

; Macro para mostrar mensajes
MOSTRAR_MENSAJE MACRO msg
    MOV AH, 09H
    LEA DX, msg
    INT 21H
ENDM

; Macro para leer numero y meterlo a la pila
LEER_NUMERO MACRO
    CALL LeerNumero
    CMP AX, 0
    JL NumeroFueraDeRango
    CMP AX, 500
    JG NumeroFueraDeRango
    PUSH AX
ENDM

; Macro para posicionar el cursor
POSICIONAR_CURSOR MACRO fila, columna
    MOV AH, 02H
    MOV BH, 0
    MOV DH, fila
    MOV DL, columna
    INT 10H
ENDM

; Macro para limpiar la pantalla
LIMPIAR_PANTALLA MACRO
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 07H
    MOV CX, 0
    MOV DX, 184FH
    INT 10H
ENDM

; Macros adicionales
LEER_CADENA MACRO buffer, size
    mov dx, OFFSET buffer  ; Dirección del buffer para almacenar la entrada
    mov cx, size           ; Tamaño máximo del buffer
    mov ah, 0Ah            ; Función de DOS para leer cadena
    int 21h                ; Llama a la interrupción 21h
ENDM
codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:stack
    push ds
    mov ax, datos
    mov ds, ax

    ; Limpiar la pantalla
    mov ah, 06h  ; Función 06h del BIOS: desplazar ventana de la pantalla
    mov al, 0    ; Número de líneas a desplazar (0=limpiar toda la pantalla)
    mov bh, 07h  ; Atributo de los caracteres a escribir
    mov cx, 0    ; Posición de inicio (fila 0, columna 0)
    mov dh, 24   ; Última fila de la ventana (24 para pantalla de 25 líneas)
    mov dl, 79   ; Última columna de la ventana (79 para pantalla de 80 columnas)
    int 10h      ; Llamar a la interrupción del BIOS

    ; Imprimir mensaje de bienvenida
    mov ah, 09h
    lea dx, mensaje_bienvenida
    int 21h

    ; Leer nombre del usuario
    mov ah, 0Ah
    lea dx, nombre
    int 21h

    ; Imprimir mensaje con nombre del usuario
    lea dx, nombre + 2
    mov ah, 09h
    int 21h

    ; Mostrar menú de opciones
    lea dx, menu
    mov ah, 09h
    int 21h

    ; Leer opción seleccionada
    mov ah, 01h
    int 21h

    ; Realizar acciones según la opción seleccionada
    cmp al, '1'
    je calcular_raiz_cuadrada
    cmp al, '2'
    je calcular_multiplicacion_rusa
    cmp al, '3'
    je calcular_raiz_babilonica
    jmp salir

calcular_raiz_cuadrada:
    ; Aquí va el código para la raíz cuadrada no forma prehistórica
    jmp salir

calcular_multiplicacion_rusa:
    ; Aquí va el código para la multiplicación rusa
    jmp salir

calcular_raiz_babilonica:
    ; Aquí va el código para la raíz cuadrada con método babilónico
    jmp salir

salir:
    pop ds
    ret

mensaje_bienvenida db "Bienvenido usuario, por favor ingrese su nombre: $"
compa endp
codigo ends
end compa

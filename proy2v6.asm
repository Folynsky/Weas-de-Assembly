; Definición de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    nombre db 20 dup('$')    ; Variable para almacenar el nombre
    opcion db ?              ; Variable para almacenar la opción seleccionada
    num1 dw ?                ; Variable para el primer número
    num2 dw ?                ; Variable para el segundo número
    resultado dw ?           ; Variable para el resultado
    buffer db 100 dup(?)     ; Buffer para limpiar el buffer de entrada
    mensaje_mostrado db ?   ; Bandera para indicar si se mostró el mensaje de bienvenida

datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:stack
    push ds
    mov ax, datos
    mov ds, ax

    ; Inicializar la bandera de mensaje mostrado
    mov mensaje_mostrado, 0

menu:
    ; Mostrar el mensaje de bienvenida si no se ha mostrado antes
    cmp mensaje_mostrado, 0
    je mostrar_bienvenida

    ; Mostrar el menú
    mov ah, 09h
    lea dx, menu_texto
    int 21h

    ; Leer la opción seleccionada
    mov ah, 01h
    int 21h

    ; Almacenar la opción seleccionada
    mov opcion, al

    ; Limpiar el buffer de entrada
    mov ah, 0Ah
    lea dx, buffer
    int 21h

    ; Realizar acciones según la opción
    cmp al, '1'
    je calcular_raiz_cuadrada
    cmp al, '2'
    je calcular_multiplicacion_rusa
    cmp al, '3'
    je calcular_raiz_babilonica
    jmp menu

mostrar_bienvenida:
    ; Solicitar el nombre del usuario
    mov ah, 09h
    lea dx, mensaje_bienvenida
    int 21h

    ; Leer el nombre
    mov ah, 0Ah
    lea dx, nombre
    int 21h

    ; Imprimir mensaje con nombre del usuario
    lea dx, nombre + 2
    mov ah, 09h
    int 21h

    ; Marcar el mensaje como mostrado
    mov mensaje_mostrado, 1
    jmp menu

calcular_raiz_cuadrada:
    ; Solicitar un número
    mov ah, 01h
    int 21h
    sub al, '0'
    mov num1, ax

    ; Calcular la raíz cuadrada
    mov ax, num1
    imul ax
    mov resultado, ax
    jmp mostrar_resultado

calcular_multiplicacion_rusa:
    ; Solicitar dos números
    ; (Aquí debes implementar la lógica para la multiplicación rusa)
    ; ...

calcular_raiz_babilonica:
    ; Solicitar un número
    ; (Aquí debes implementar la lógica para la raíz babilónica)
    ; ...

mostrar_resultado:
    ; Mostrar el resultado
    ; (Aquí debes implementar la lógica para mostrar el resultado)
    ; ...

    ; Salir del programa
    mov ah, 4Ch
    int 21h

mensaje_bienvenida db "Bienvenido usuario, por favor ingrese su nombre: $"
menu_texto db 13, 10, "Seleccione una opción:", 13, 10
           db "1. Raíz cuadrada no forma prehistórica", 13, 10
           db "2. Multiplicación rusa", 13, 10
           db "3. Raíz cuadrada con método babilónico", 13, 10
           db "Opción: $"
compa endp
codigo ends
end compa

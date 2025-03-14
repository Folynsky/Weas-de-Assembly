; Definición de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    nombre db 20, ?, 20 dup('$')  ; Variable para almacenar el nombre ingresado
    menu db "Hola %s, elige una opción:", 13, 10
         db "1.- Raíz cuadrada no forma prehistórica", 13, 10
         db "2.- Multiplicación rusa", 13, 10
         db "3.- Raíz cuadrada con método babilónico", 13, 10
         db "Opción: $"
         db 20 dup('$')
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:stack
    push ds
    mov ax, datos
    mov ds, ax

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

; Definición de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    msg db 'La raiz cuadrada es: $'
datos ends

codigo segment para public 'code'
    public compa
compa proc near
    assume cs:codigo, ds:datos
    mov ax, datos
    mov ds, ax

mov ax, 70      ; Número para encontrar la raíz cuadrada
    mov cx, ax      ; Movemos el número a CX

    ; Inicializamos el valor inicial de la raíz cuadrada en 1
    mov bx, 1
    mov dx, 0

lup:
    mov ax, cx          ; Cargamos el número en AX
    mov dx, 0           ; Limpiamos DX
    div bx              ; Dividimos CX por el valor de la raíz cuadrada actual en BX
    add ax, bx          ; Sumamos el cociente y el divisor
    shr ax, 1           ; Dividimos el resultado por 2
    mov dx, bx          ; Movemos la raíz cuadrada anterior a DX
    mov bx, ax          ; Actualizamos el valor de la raíz cuadrada en BX

    ; Comprobamos si hemos encontrado la raíz cuadrada
    cmp bx, dx
    jnz lup

        ; Mostrar mensaje
        mov ah, 09h         ; Función para mostrar una cadena
        lea dx, msg         ; Dirección de la cadena a mostrar
        int 21h             ; Llamada a la interrupción del BIOS

        ; Mostrar la raíz cuadrada
        mov ax, bx          ; Movemos el resultado a AX para imprimirlo
        add ax, '0'         ; Convertimos el valor a su representación ASCII
        mov dl, al          ; Cargamos el resultado en DL para imprimirlo
        mov ah, 02h         ; Función para mostrar un carácter
        int 21h             ; Llamada a la interrupción del BIOS

        ; Salir del programa
        mov ah, 4Ch         ; Función para salir del programa
        int 21h             ; Llamada a la interrupción del BIOS  	

compa endp
codigo ends
end compa



pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	num dw ?
	res db 16 dup (0)
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

 ; Limpiar la pantalla
    mov ah, 06h   ; Función de servicio para scroll de ventana
    mov al, 0     ; Número de líneas a desplazar
    mov bh, 07h   ; Atributo de fondo y primer plano (color negro)
    mov ch, 0     ; Línea de inicio de desplazamiento
    mov cl, 0     ; Columna de inicio de desplazamiento
    mov dh, 24    ; Línea final de desplazamiento (24 para una pantalla de 25 líneas)
    mov dl, 79    ; Columna final de desplazamiento (79 para una pantalla de 80 columnas)
    int 10h       ; Llamar a la función de servicio de video BIOS

    ; Captura el número de tres dígitos
    mov num, 0    ; Inicializar num a 0
    mov ah, 01h
    int 21h
    sub al, 30h   ; Convertir de ASCII a número decimal
    mov bl, 100   ; Multiplicador para el primer dígito
    mul bl
    add num, ax   ; Sumar al primer dígito
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, 10    ; Multiplicador para el segundo dígito
    mul bl
    add num, ax   ; Sumar al segundo dígito
    mov ah, 01h
    int 21h
    sub al, 30h
    add num, al   ; Sumar el tercer dígito

    ; Convertir el número a binario
    mov cx, 16    ; Número de bits en un word
    mov si, offset res + 15  ; Último byte de res
convert_loop:
    mov ax, num   ; Copiar el número a ax para las divisiones
    mov dx, 0     ; Limpiar dx para la división
    mov bx, 2     ; Dividir por 2 para convertir a binario
    div bx        ; Divide el número por 2
    add dl, '0'   ; Convertir el residuo a ASCII
    mov [si], dl  ; Almacena el residuo en la cadena
    dec si        ; Mover al siguiente byte
    dec cx        ; Decrementar el contador de bits
    cmp cx, 0
    jne convert_loop

    ; Imprimir el resultado
    mov ah, 09h
    lea dx, res
    int 21h

    ; Salir del programa
    mov ah, 4Ch
    int 21h

compa endp
	codigo ends
	end compa

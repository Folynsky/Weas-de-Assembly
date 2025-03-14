pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	num db ?
	res db 9 dup (0)
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
mov ah, 01h
int 21h
sub al, 30h   ; Convertir de ASCII a número decimal
mov num, al

mov ah, 01h
int 21h
sub al, 30h
mov ah, 0
mov bl, 10
mul bl
add num, al

mov ah, 01h
int 21h
sub al, 30h
mov ah, 0
mov bl, 100
mul bl
add num, al

; Convertir el número a binario
mov al, num
mov bl, 2   ; Dividir por 2 para convertir a binario
mov bh, 0
mov cx, 8   ; Número de bits en un byte

lea si, res

convert_loop:
    mov dl, 0
    div bl    ; Divide el número por 2
    add dl, '0'
    mov [si], dl  ; Almacena el residuo en la cadena
    inc si
loop convert_loop

mov byte ptr [si], '$'  ; Terminador de cadena

; Limpiar la pantalla nuevamente
mov ah, 06h   ; Función de servicio para scroll de ventana
mov al, 0     ; Número de líneas a desplazar
mov bh, 07h   ; Atributo de fondo y primer plano (color negro)
mov ch, 0     ; Línea de inicio de desplazamiento
mov cl, 0     ; Columna de inicio de desplazamiento
mov dh, 24    ; Línea final de desplazamiento (24 para una pantalla de 25 líneas)
mov dl, 79    ; Columna final de desplazamiento (79 para una pantalla de 80 columnas)
int 10h       ; Llamar a la función de servicio de video BIOS

; Imprimir el resultado
mov ah, 09h
lea dx, res
int 21h

mov ah, 4Ch
int 21h

compa endp
	codigo ends
	end compa

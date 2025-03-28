pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
    ; Definimos la cadena binaria a comparar con el número decimal
    binario DB 00000001b, 00000010b, 00000100b, 00001000b, 00010000b, 00100000b, 01000000b, 10000000b
    ; Definimos el número decimal a convertir
    datoA DB 11
    ; Definimos un buffer para almacenar el resultado binario
    resultado DB 8 DUP(0)
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

    ; Inicializamos el índice del bucle y el puntero a la cadena binaria
    MOV CX, 0
    LEA SI, binario

convertir_loop:
    ; Realizamos la operación AND entre el número decimal y el bit actual de la cadena binaria
    MOV DL, [SI + CX]
    AND DL, datoA

    ; Almacenamos el resultado en la pila
    MOV [resultado + CX], DL

    ; Incrementamos el índice del bucle y comprobamos si hemos terminado de convertir los 8 bits
    INC CX
    CMP CX, 8
    JNE convertir_loop

    ; Mostramos el resultado binario
    MOV AH, 2 ; Función para imprimir un carácter
    MOV DX, OFFSET resultado
    MOV CX, 8
print_loop:
    MOV DL, [DX]
    ADD DL, '0' ; Convertimos el bit a su representación ASCII
    INT 21H      ; Imprimimos el bit
    INC DX       ; Nos movemos al siguiente bit en el resultado
    LOOP print_loop

    MOV AH, 4CH ; Salimos del programa
    INT 21H


compa endp
	codigo ends
	end compa

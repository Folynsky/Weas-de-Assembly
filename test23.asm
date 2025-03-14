codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:pila
    PUSH ds
    MOV ax, datos             
    MOV ds, ax

    ; Limpiar la pantalla
    MOV AH, 00h
    MOV AL, 03h  ; Modo de video (80x25)
    INT 10h

    ;IMPRIMIR CADENA
	lea DX,cadena
	MOV AH,09H
	INT 21H

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
	PUSH dx
	MOV AX,10
	loop captura

;CONVERTIR PRIMER NUMERO A BINARIO Y MOSTRARLO

lea DX, Res  ; Imprimir mensaje "El resultado final es: "
MOV AH, 09h
INT 21h

lea SI, Res
mov cx, 8  ; Iterar 8 veces (8 bits)
mov ah, 0  ; Limpiar AH

convertirBinario:
    shl byte ptr [dato1], 1  ; Desplazar el bit a la izquierda
    rcl byte ptr [dato1], 1  ; Rotar el carry al bit menos significativo
    jnc esCero  ; Si el carry es 0, el bit es 0
    mov dl, '1'  ; Si el carry es 1, el bit es 1
    jmp imprimirChar

esCero:
    mov dl, '0'  ; Si el carry es 0, el bit es 0

imprimirChar:
    mov ah, 02h  ; Función de impresión
    int 21h  ; Imprimir el carácter

    dec cx  ; Decrementar el contador
    jnz convertirBinario  ; Si no se han impreso los 8 bits, continuar

; Imprimir salto de línea
mov dl, 0dh
mov ah, 02h
int 21h
mov dl, 0ah
int 21h

; Salir del programa
mov ah, 4ch
int 21h

compa endp
codigo ends
end compa

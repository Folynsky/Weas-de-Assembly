pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero: $"
    dato1 dw ?  ; Cambiado a db para que sea un byte
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
	MOV AH,07h
	INT 21h
	CMP AL,30h
	JB captura
	CMP AL,39h
	JA captura
	MOV AH,02h
	MOV DL,AL
	INT 21h
	MOV DH,0
	SUB DL,30h
	PUSH dx
	MOV AX,30h
	loop captura

;CONVERTIR PRIMER NUMERO

;MULTIPLICAR
	MOV BX,1
	MOV DX,0
	MOV suma,0
;DEFINE CANTIDAD DE LOOPS	
	MOV CX,2
Convertir1:
	POP AX
	MUL BX
	ADD suma,AX	
	MOV AX,BX
	MOV BX,10
	MOV DX,0
	MUL BX
	MOV BX,AX
	MOV DX,0
	LOOP Convertir1
	MOV AX, suma
	MOV dato1,AX
	MOV suma,0
	
;salto de linea para el primer proporcionamiento del numero
	mov ah,02h
	mov bh,0
	mov dh,1
	mov dl,0
	int 10h

        ;salto de linea para el primer proporcionamiento del numero
        mov ah,02h
        mov bh,0
        mov dh,1
        mov dl,0
        int 10h

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
    MOV AX, dato1
    AND AX, 1   ; Máscara de bits actual

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
imprimirBinario:
    ; Mover el resultado a un registro de 16 bits
    mov dx, 0
    mov dl, ah
    mov ah, 0
    mov al, 8  ; Contador para 8 bits

imprimirBit:
    ; Desplazar el resultado a la izquierda
    shl dx, 1

    ; Verificar el bit más significativo
    test ax, 8000h
    jz bitCero  ; Si el bit es 0, saltar a bitCero

    ; Si el bit es 1, imprimir '1'
    mov dl, '1'
    jmp imprimirChar

bitCero:
    ; Si el bit es 0, imprimir '0'
    mov dl, '0'

imprimirChar:
    ; Imprimir el carácter
    mov ah, 02h
    int 21h

    ; Desplazar el siguiente bit a la derecha
    shl ax, 1

    ; Decrementar el contador
    dec al
    jnz imprimirBit  ; Si no se han impreso los 8 bits, continuar

    ; Imprimir salto de línea
    mov dl, 0dh
    mov ah, 02h
    int 21h
    mov dl, 0ah
    int 21h

    ret

; Salir del programa
    mov ah, 4ch
    int 21h

    compa endp
    codigo ends
    end compa

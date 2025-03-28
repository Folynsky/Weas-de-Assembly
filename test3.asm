pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db " Proporciona un numero: $"
dato1 db ?  ; Cambiado a db para que sea un byte
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
    jmp limpiarpantalla
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
    MOV dato1,AL  ; Solo necesitas el byte menos significativo de AX
    MOV suma,0
    
    ;salto de linea para el primer proporcionamiento del numero
    mov ah,02h
    mov bh,0
    mov dh,1
    mov dl,0
    int 10h

    ;IMPRIMIR CADENA
    lea DX,cadena
    MOV AH,09H
    INT 21H
    ;FIN DE IMPRESION

    imprime:
    ;IMPRIMIR EL RESULTADO
    ;Imprime cadena
    lea DX,Res
    MOV AH,09H
    INT 21H
    ;Termina cadena
    cmp ban,1
    jb sigue
    ;Imprimir signo de menos
    mov dl,45
    mov ah,02h
    int 21h
    sigue:
    ;Inicia metodo de impresion
    ;Aqui es para dividir
    mov ax,CX
    mov dx,0
    mov bx,10 ;datos para dividir entre 10
    mov cx,5
    dividir:
    div bx
    add dx,30h
    push dx
    mov dx,0
    loop dividir
    ;imprimir caracteres
    mov cx,5
    imprimir:
    pop dx
    mov ah,02h
    int 21h
    loop imprimir
    ;Fin impresion de caracteres
    limpiarpantalla:
    mov ah,00h
    int 16h
    mov ah,0fh
    int 10h
    mov ah,0h
    int 10h
    jmp inicio

opcionAnd:
    ; Inicializar el resultado en 0
    MOV BL, 0

    ; Inicializar la máscara de bits en 1 (00000001)
    MOV AL, 1

bucleAnd:
    ; Realizar la operación AND entre dato1 y la máscara de bits actual
    MOV AH, 0   ; Limpiar AH
    MOV CL, 7   ; Contador para recorrer los bits de dato1
    MOV DL, ' ' ; Espacio para separar los resultados en la impresión
    int 21h     ; Imprimir el espacio

compararBit:
    ; Mover el bit de la máscara de bits al bit menos significativo
    SHR AL, 1

    ; Si el bit actual de la máscara es 1, hacer la comparación con el bit correspondiente de dato1
    JNC bitEsCero

    ; Si el bit es 0, imprimir '0'
    mov dl, '0'
    jmp escribe

bitEsCero:
    ; Comparar el bit actual de dato1 con 0
    MOV AH, 0
    MOV AL, dato1
    AND AL, 1

    ; Si el resultado es 0, almacenar un '0' en la pila
    JNZ bitEsUno
    mov dl, '0'
    jmp escribe

bitEsUno:
    ; Si el resultado es 1, almacenar un '1' en la pila
    mov dl, '1'

escribe:
    ; Imprimir el resultado actual (0 o 1)
    mov ah, 02h
    int 21h

    ; Decrementar el contador de bits de dato1
    DEC CL
    JNZ compararBit

    ; Terminar el programa
    RET


compa endp
	codigo ends
	end compa

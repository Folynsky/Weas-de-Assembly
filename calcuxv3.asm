pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db " Proporciona un numero: $"
dato1 dw ?
dato2 dw ?
cadenamenos db "-$"
suma dw  ?
Opcion db " Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "0. SUMA",13,10
db "1. RESTA",13,10
db "2. MULTIPLICACION",13,10
db "3. DIVISION",13,10
db "4. INCREMENTO UNITARIO",13,10
db "5. DECREMENTO UNITARIO",13,10
db "6. CORRIMIENTO A LA DERECHA",13,10
db "7. CORRIMIENTO A LA IZQUIERDA",13,10
db "8. CORRIMIENTO A LA DERECHA CIRCULAR",13,10
db "9. CORRIMIENTO A LA IZQUIERDA CIRCULAR",13,10
db "A. SALIR",13,10,"$"
Res db " El resultado final es: $"
Res2 db "El resultado negativo es: $"
ban dw ?
divisiondesborde db "pendejo no se usa 0$"
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
	MOV dato1,AX
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

;INICIA SEGUNDO DATO

	MOV cx,2
captura2:
	MOV AH,07h
	INT 21h
	CMP AL,30h
	JB captura2
	CMP AL,39h
	JA captura2
	MOV AH,02h
	MOV DL,AL
	INT 21h
	MOV DH,0
	SUB DL,30h
	PUSH dx
	MOV AX,30h
	loop captura2

;CONVERTIR SEGUNDO NUMERO

;MULTIPLICAR
	MOV BX,1
	MOV DX,0
	MOV suma,0
;DEFINE CANTIDAD DE LOOPS	
	MOV CX,2
Convertir2:
	POP AX
	MUL BX
	ADD suma,AX	
	MOV AX,BX
	MOV BX,10
	MOV DX,0
	MUL BX
	MOV BX,AX
	MOV DX,0
	LOOP Convertir2
	MOV AX, suma
	MOV dato2,AX
	MOV suma,0
	
;salto de linea para el menu de opciones de la calculadora
	mov ah,02h
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h

	LEA DX, Opcion
	MOV AH, 09H
	INT 21H
Menu:
	mov ah,07h
	int 21h
	cmp al, '0'
	JB Menu
	cmp al, 'A'
	JA Menu
	Mov ah,02h
	mov dl, al
	int 21h
	cmp al, '0'
        JE suma1
	cmp al, '1'
        JE resta
	cmp al, '2'
        JE multiplicar
	cmp al, '3'
        JE divi
	cmp al, '4'
        JE incremento
	cmp al, '5'
        JE decremento
	cmp al, '6'
        JE corder
	cmp al, '7'
        JE corizq
	cmp al, '8'
        JE cordercir
	cmp al, '9'
        JE corizcirc
	cmp al,'A'
        JE salir
	loop Menu

;SUMA DE LOS DOS NUMEROS
suma1:
	MOV CX,dato1
	ADD CX,dato2
	jmp imprime
resta:
	MOV CX,dato1
	cmp cx,dato2
	jb restainversa
	sub CX,dato2
	jmp imprime
restainversa:
	mov cx,dato2
	sub cx,dato1
	mov ban,1
	jmp imprime

multiplicar:
	MOV DX, 0
	MOV AX, dato1
	MOV BX, dato2
	MUL BX
	MOV CX,AX
	jmp imprime 
divi:
	cmp dato2,0
	je divisiondes
	MOV DX, 0
	MOV AX, dato1
	MOV BX, dato2
	DIV BX
	MOV CX, AX
	jmp imprime
divisiondes:
	lea dx,divisiondesborde
	mov ah,09h
	int 21h
	jmp limpiarpantalla
salir:
	jmp termina

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

;Aqui inician las opciones de incrementos, decrementos y corrimientos

; Incremento Unitario
incremento:
    inc dato1
    call imprimirNumero   ; Llama a la función para imprimir dato1

    inc dato2
    call imprimirNumero   ; Llama a la función para imprimir dato2
    jmp limpiarpantalla

decremento:
    dec dato1
    call imprimirNumero   ; Llama a la función para imprimir dato1
    dec dato2
    call imprimirNumero   ; Llama a la función para imprimir dato2
    jmp limpiarpantalla

corder:
    shr dato1, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1
    jmp limpiarpantalla

corizq:
    shl dato1, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1

    shl dato2, 1
    call imprimirNumero   ; Llama a la función para imprimir dato2
    jmp limpiarpantalla

cordercir:
    ror dato1, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1

    ror dato2, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1
    jmp limpiarpantalla

corizcirc:
    rol dato1, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1

    rol dato2, 1
    call imprimirNumero   ; Llama a la función para imprimir dato1
    jmp limpiarpantalla

imprimirNumero proc near
    push ax
    push dx
    mov cx, 10
    div cx              ; Divide AX (el número) por 10 para obtener el dígito menos significativo en DL
    add dl, '0'         ; Convertir el dígito en un carácter ASCII
    cmp ah, 0           ; Si queda un cociente en AH, hay más dígitos por imprimir
    jz imprimir
    mov ah, 0           ; Limpiar AH para la próxima división
    call imprimirNumero ; Llamada recursiva para imprimir el siguiente dígito
imprimir:
    mov dl, al          ; Imprimir el último dígito restante en AL
    add dl, '0'         ; Convertir el dígito en un carácter ASCII
    mov ah, 02h
    int 21h
    pop dx
    pop ax
    ret
imprimirNumero endp

termina:
	ret
compa endp
	codigo ends
	end compa

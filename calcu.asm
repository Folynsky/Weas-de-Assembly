pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db " Proporciona un numero: $"
dato1 dw ?
dato2 dw ?
suma dw  ?
Opcion db " Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "1. SUMA",13,10
db "2. RESTA",13,10
db "3. MULTIPLICACION",13,10
db "4. DIVISION",13,10
db "5. SALIR",13,10,"$"
Res db " El resultado final es: $"
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

;INICIA ESTRUCTURA CODIGO

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


	LEA DX, Opcion
	MOV AH, 09H
	INT 21H
Menu:
	mov ah,07h
	int 21h
	cmp al,31h
	JB Menu
	cmp al,35h
	JA Menu
	Mov ah,02h
	mov dl, al
	int 21h
	cmp al, 31h
        JE suma1
	cmp al, 32h
        JE resta
	cmp al, 33h
        JE multiplicar
	cmp al, 34h
        JE divi
	cmp al,35h
        JE salir
	loop Menu

;SUMA DE LOS DOS NUMEROS
suma1:
	MOV CX,dato1
	ADD CX,dato2
	jmp imprime
resta:
	MOV CX,dato1
	sub CX,dato2
	jmp imprime
multiplicar:
	MOV DX, 0
	MOV AX, dato1
	MOV BX, dato2
	MUL BX
	MOV CX,AX
	jmp imprime 
divi:
	MOV DX, 0
	MOV AX, dato1
	MOV BX, dato2
	DIV BX
	MOV CX, AX
	jmp imprime
salir:
	jmp termina

imprime:
;IMPRIMIR EL RESULTADO
;Imprime cadena
    lea DX,Res
    MOV AH,09H
    INT 21H
;Termina cadena
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

termina:
	ret
compa endp
	codigo ends
	end compa

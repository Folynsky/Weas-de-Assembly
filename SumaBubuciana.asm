pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db " Proporcione un numero $"
Res db " El resultado es: $"
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
;Mostrar cadena
	LEA DX, cadena
	MOV AH,09H
	INT 21H
;recibir primer caracter
	MOV AH,01H
	INT 21H
;Respaldar
	MOV BH, AL
;recibir segundo caracter
	MOV AH, 01H
	INT 21H
;Respaldar
	MOV BL, AL
;Restar 30H a ambos digitos
	SUB BX,3030H
;Limpiar AX
	MOV AX,0
;Mover a AL el registro de BH
        MOV AL,BH
;Mover a CL un 10 que es el numero multiplicativo
	MOV CL,10
;Multiplcar decimas
	MUL CL
;Agregar unidades
	ADD AL,BL
;Guardar registro en CH
	MOV CH,AL
;Termina el dato 1

;Mostrar cadena
	LEA DX, cadena
	MOV AH,09H
	INT 21H
;recibir primer caracter
	MOV AH,01H
	INT 21H
;Respaldar
	MOV BH, AL
;recibir segundo caracter
	MOV AH, 01H
	INT 21H
;Respaldar
	MOV BL, AL
;Restar 30 a ambos digitos
	SUB BX,3030H
;Limpiar AX
	MOV AX,0
	
;Mover a AL el registro de BH
        MOV AL,BH
;Mover a CL un 10 que es el numero multiplicativo
	MOV CL,10
;Multiplcar decimas
	MUL CL
;Agregar unidades
	ADD AL,BL
;Termina el dato 2

;Sumar ambos numeros en CH
	ADD AL,CH

;Limpiar registros de AH para multiplicar
	MOV AH,0
;Asignar en BL nuestro numero 10 que sera el divisor
	MOV BL,10
;Dividir lo que se encuentra en AL
	DIV BL

;Agregar 0 a ambos registros de AX
	ADD AX,3030H

;Mover registros de AX a CX para evitar problemas con la cadena
	MOV CX,AX

;Imprimir cadena
	LEA DX, Res
	MOV AH, 09H
	INT 21H

;Imprimir caracter uno en pantalla
	MOV DL,CL
	MOV AH,02H
        INT 21H

;Imprimir caracter dos en pantalla
	MOV DL,CH
	MOV AH,02H
	INT 21H


	ret

compa endp
	codigo ends
	end compa

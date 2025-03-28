pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends
	
datos segment para public 'data'
	cadena db "Proporcione un numero$"
	;Mostrar cadena
	LEA DX, cadena
	MOV AH,09H
	INT 21H
	;recibir segundo caracter
	MOV AH,01H
	INT 21H
	;restar 30 al primer numero
	SUB AL,30H
	;mover de posicion el primer numero, para dejar libre AL
	MOV BL,AL
	;mostrar cadena
	LEA DX, cadena
	MOV AH,09H
	INT 21H
	;recibir segundo caracter
	MOV AH,01H
	INT 21H
	;restar 30 al segundo numero
	SUB AL,30H
	;sumar ambos numeros, en su respectivos registros
	ADD AL,BL
	;sumar 30 para que el numero este correcto en hexadecimal
	ADD AL,30H
	;mover el registro a DL para imprimir en pantalla.
	MOV DL,AL
	MOV AH,02H
	INT 21H
	ret

compa endp
	codigo ends
	end compa
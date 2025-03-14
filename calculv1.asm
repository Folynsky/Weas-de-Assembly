pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db " Proporcione un numero de dos digitos $"
Res db " El resultado es: $"
Dato1 dw ?
Dato2 dw ?
;Menu db 
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

;Registro de dato Dato1
;recibir primer caracter
Entrada1:
	MOV AH,01H
	INT 21H
;Validacion
	CMP AL,30H
	JB Entrada1
	CMP AL,39H
	JA Entrada1
;Si el caracter es valido se muestra en pantalla
	MOV AH,09H
	MOV DL,AL
	INT 21H

        MOV DH,0
        PUSH DX        
;Respaldar
	MOV BH, AL

;recibir segundo caracter
Entrada2:
	MOV AH, 01H
	INT 21H
;Validacion
	CMP AL,30H
	JB Entrada2
	CMP AL,39H
	JA Entrada2
;Si el caracter es valido se muestra en pantalla
	MOV AH,09H
	MOV DL,AL
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
;Guardar registro en Dato1
        MOV Dato1,Ax
;Termina el dato 1

;Registro de dato2
;Mostrar cadena
	LEA DX, cadena
	MOV AH,09H
	INT 21H

Entrada3:
;Recibe primer caracter
	MOV AH,01H
	INT 21H
;Validacion
	CMP AL,30H
	JB Entrada3
	CMP AL,39H
	JA Entrada3
;Si el caracter es valido se muestra en pantalla
	MOV AH,09H
	MOV DL,AL
;Respaldar
	MOV BH, AL

Entrada4:
;Recibe segundo caracter
	MOV AH,01H
	INT 21H
;Validacion
	CMP AL,30H
	JB Entrada4
	CMP AL,39H
	JA Entrada4
;Si el caracter es valido se muestra en pantalla
	MOV AH,09H
	MOV DL,AL
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
;Agregar unidades en Dato2
        MOV Dato2,Ax
;Termina el dato 2

Menu:

Suma:

Resta:

Multi:

Divi:

Imprimir:

Salit:

	ret

compa endp
	codigo ends
	end compa
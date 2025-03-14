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
;Mover a CL un 10000 que es el numero multiplicativo
    MOV CX, 10000
;Multiplcar decenas de miles
    MUL CX
;Mover a CH el resultado de la multiplicacion
    MOV CH, AH
    MOV AH, 0
;Limpiar AX
    XOR AX, AX

;Mover a AL el registro de BL
    MOV AL,BL
;Mover a CX un 1000 que es el numero multiplicativo
    MOV CX, 1000
;Multiplcar miles
    MUL CX
;Agregar al resultado
    ADD AH, CH
;Mover a CH el resultado de la multiplicacion
    MOV CH, AH
    MOV AH, 0
;Limpiar AX
    XOR AX, AX

;Mover a AL el registro de BH
    MOV AL,BH
;Mover a CX un 100 que es el numero multiplicativo
    MOV CX, 100
;Multiplcar centenas
    MUL CX
;Agregar al resultado
    ADD AH, CH
;Mover a CH el resultado de la multiplicacion
    MOV CH, AH
    MOV AH, 0
;Limpiar AX
    XOR AX, AX

;Mover a AL el registro de BL
    MOV AL,BL
;Mover a CX un 10 que es el numero multiplicativo
    MOV CX, 10
;Multiplcar decenas
    MUL CX
;Agregar al resultado
    ADD AH, CH
;Mover a CH el resultado de la multiplicacion
    MOV CH, AH
    MOV AH, 0
;Limpiar AX
    XOR AX, AX

;Mover a AL el registro de BL
    MOV AL,BL
;Agregar unidades
    ADD AH, AL

;Agregar 0 a ambos registros de AX
    ADD AX,3030H

;Mover registros de AX a CX para evitar problemas con la cadena
    MOV CX,AX

;Imprimir cadena
    LEA DX, Res
    MOV AH, 09H
    INT 21H

;Imprimir caracteres en pantalla
    MOV DL,CL
    MOV AH,02H
    INT 21H

    MOV DL,CH
    MOV AH,02H
    INT 21H

    ret

compa endp
    codigo ends
    end compa

; Definición de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    cadena db " Proporciona un numero de 5 digitos: $"
    dato1 dw ?
    suma dw  ?
    msg db 'La raiz cuadrada es: $'
datos ends

pila segment stack
    db 1024 dup(?) ; Define el espacio de la pila
pila ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:pila
    PUSH ds
    MOV ax,0
    PUSH ax

    MOV ax,datos
    MOV ds,ax

;;INICIA ESTRUCTURA CODIGO

;IMPRIMIR CADENA
    lea DX,cadena
    MOV AH,09H
    INT 21H
;FIN DE IMPRESION

;INICIA PRIMER DATO

    MOV cx,5  ; Cambiar a 5 para capturar 5 dígitos
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

    ; Validar que cada dígito cumpla con los requisitos
    CMP cx, 5   ; Si es el primer dígito
    JE validar_primer_digito
    CMP cx, 4   ; Si es el segundo dígito
    JE validar_segundo_digito
    CMP cx, 3   ; Si es el tercer dígito
    JE validar_tercer_digito
    CMP cx, 2   ; Si es el cuarto dígito
    JE validar_cuarto_digito
    CMP cx, 1   ; Si es el quinto dígito
    JE validar_quinto_digito
    JMP continuar

validar_primer_digito:
    CMP DL, 6   ; El primer dígito no debe ser mayor a 6
    JG captura
    JMP continuar

validar_segundo_digito:
    CMP DL, 5   ; El segundo dígito no debe ser mayor a 5
    JG captura
    JMP continuar

validar_tercer_digito:
    CMP DL, 5   ; El tercer dígito no debe ser mayor a 5
    JG captura
    JMP continuar

validar_cuarto_digito:
    CMP DL, 3   ; El cuarto dígito no debe ser mayor a 3
    JG captura
    JMP continuar

validar_quinto_digito:
    CMP DL, 4   ; El quinto dígito no debe ser mayor a 5
    JG captura

continuar:
    PUSH dx
    MOV AX,10h  ; Multiplicar por 10 en lugar de 30
    loop captura

;CONVERTIR PRIMER NUMERO

;MULTIPLICAR
    MOV BX,1
    MOV DX,0
    MOV suma,0
;DEFINE CANTIDAD DE LOOPS    
    MOV CX,5  ; Cambiar a 5 para convertir 5 dígitos
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

    ; Calcular raíz cuadrada prehistórica
    mov cx, ax      ; Movemos el número a CX

    ; Inicializamos el valor inicial de la raíz cuadrada en 1
    mov bx, 1
    mov dx, 0

lup:
    mov ax, cx          ; Cargamos el número en AX
    mov dx, 0           ; Limpiamos DX
    div bx              ; Dividimos CX por el valor de la raíz cuadrada actual en BX
    add ax, bx          ; Sumamos el cociente y el divisor
    shr ax, 1           ; Dividimos el resultado por 2
    mov dx, bx          ; Movemos la raíz cuadrada anterior a DX
    mov bx, ax          ; Actualizamos el valor de la raíz cuadrada en BX

    ; Comprobamos si hemos encontrado la raíz cuadrada
    cmp bx, dx
    jnz lup

    ; Mostrar mensaje
    mov ah, 09h         ; Función para mostrar una cadena
    lea dx, msg         ; Dirección de la cadena a mostrar
    int 21h             ; Llamada a la interrupción del BIOS

    ;IMPRIMIR EL RESULTADO

;Termina cadena
;Inicia metodo de impresion
;Aqui es para dividir
	mov ax,BX
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
    RET
compa endp
    codigo ends
    end compa

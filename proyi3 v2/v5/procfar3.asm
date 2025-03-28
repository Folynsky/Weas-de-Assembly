
datos segment para public 'data'
	;suma dw ?
datos ends

codigo segment para public 'code'
	public compa
compa2 proc far
	assume cs:codigo, ds:datos
	push ds
	mov ax,0
	push ax

	mov ax,datos
	mov ds,ax

;codigo
	mov ah,7
	int 21h
	ret	
compa2 endp

public limpiaP
	limpiaP proc far
	;resguardar
		push ax
		push bx
		push cx
		push dx

		mov ah,00h
		int 16h
		mov ah,0fh
		int 10h
		mov ah,0h
		int 10h

		;restaurar
		pop dx
		pop cx
		pop bx
		pop ax
		
		;jmp inicio

		ret
	limpiaP endp

public captura
captura proc far
    push ax
    push bx
    push cx
    push dx
    push bp

    MOV cx,5  ; Capturar 5 dígitos
    MOV bx, 0 ; Inicializar contador de dígitos

capturan:
    MOV AH,07h
    INT 21h
    CMP AL,30h
    JB capturan
    CMP AL,39h
    JA capturan
    MOV AH,02h
    MOV DL,AL
    INT 21h
    MOV DH,0
    SUB DL,30h  ; Convertir ASCII a número

    ; Incrementar contador de dígitos
    inc bx
    cmp bx, 1
    je check_primero
    cmp bx, 2
    je check_segundo
    cmp bx, 3
    je check_tercero
    cmp bx, 4
    je check_cuarto
    cmp bx, 5
    je check_quinto

continuar:
    PUSH dx
    CMP bx, 5
    JAE conversion ; Si ya hemos capturado 5 dígitos, saltar a la conversión
    MOV AX,10h     ; Multiplicar por 10
    loop capturan

; Validaciones para cada dígito
check_primero:
    CMP DL, 6
    mov val1, DL
    JA error    ; Si el primer dígito es mayor a 6, error
    JMP continuar

check_segundo:
    CMP val1, 6
    JNE continuar
    CMP DL, 5
    mov val2, DL
    JA error    ; Si el primer dígito es 6 y el segundo mayor a 5, error
    JMP continuar

check_tercero:
    CMP val1, 6
    JNE continuar
    CMP val2, 5
    JNE continuar
    CMP DL, 5
    mov val3, DL
    JA error    ; Si los primeros dos dígitos son 65 y el tercero mayor a 5, error
    JMP continuar

check_cuarto:
    CMP val1, 6
    JNE continuar
    CMP val2, 5
    JNE continuar
    CMP val3, 5
    JNE continuar
    CMP DL, 3
    mov val4, DL
    JA error    ; Si los primeros tres dígitos son 655 y el cuarto mayor a 3, error
    JMP continuar

check_quinto:
    CMP val1, 6
    JNE continuar
    CMP val2, 5
    JNE continuar
    CMP val3, 5
    JNE continuar
    CMP val4, 3
    JNE continuar
    CMP DL, 4
    JA error     ; Si los primeros cuatro dígitos son 6553 y el quinto mayor a 5, error

    ; Capturamos el quinto dígito correctamente, salimos del bucle
    JMP conversion

; Multiplicar y convertir a número
conversion:
    MOV BX,1
    MOV DX,0
    MOV suma,0
    MOV CX,5  ; Convertir 5 dígitos
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
	cmp suma, 00000
	je escero
MOV bp,sp
MOV AX, suma
MOV [BP+14],AX

; Restaurar registros
pop bp
pop dx
pop cx
pop bx
pop ax

ret

; Manejar el error
error:
    posicion 9,1
    imprimeC adver
    JMP xd ; Reiniciar captura en caso de error
escero:
	posicion 9,1
	imprimeC ceros
	jmp xd
mensaje_error db 'Error: El numero supera 65535.$'
digitos db 5 dup(0) ; Espacio para almacenar 5 dígitos

captura endp


;captura para multiplicacion rusa
public capturarus
capturarus proc far
	push ax
	push bx
	push cx
	push dx
	push bp
	;INICIA PRIMER DATO
;otra:
    MOV cx,3  ; Cambiar a 3 para capturar 3 dígitos
capturanrus:
    MOV AH,07h
    INT 21h
    CMP AL,30h
    JB capturanrus 
    CMP AL,39h
    JA capturanrus
    MOV AH,02h
    MOV DL,AL
    INT 21h
    MOV DH,0
    SUB DL,30h

continuarrus:
    PUSH dx
    MOV AX,10h  ; Multiplicar por 10 en lugar de 30
    loop capturanrus

;CONVERTIR PRIMER NUMERO

;MULTIPLICAR
    MOV BX,1
    MOV DX,0
    MOV suma,0
;DEFINE CANTIDAD DE LOOPS    
    MOV CX,3  ; Cambiar a 3 para convertir 3 dígitos
Convertirrus:
    POP AX
    MUL BX
    ADD suma,AX    
    MOV AX,BX
    MOV BX,10
    MOV DX,0
    MUL BX
    MOV BX,AX
    MOV DX,0
    LOOP Convertirrus
    MOV bp,sp
    MOV AX, suma
    MOV [BP+14],AX



    ;cmp ax, 65535
    ;ja otra
    MOV suma,0

	;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax
		
		;jmp inicio

		ret


	capturarus endp


public calcprehis
		calcprehis proc far

	push ax
	push bx
	push cx
	push dx
	push bp

posicion 8,0	
	imprimePasos paso0
   ; Calcular raíz cuadrada prehistórica
mov bp,sp
mov cx,[bp+14]
    mov cx, dato1      ; Movemos el número a CX

    ; Inicializamos el valor inicial de la raíz cuadrada en 1
    mov bx, 1
    mov dx, 0

lup:
    mov ax, cx          ; Cargamos el número en AX
    mov dx, 0           ; Limpiamos DX
	posicion 10,0
	imprimePasos paso2
        mov dato1, bx
    call imprimeres
    div bx              ; Dividimos CX por el valor de la raíz cuadrada actual en BX
	posicion 11,0
	imprimePasos paso3
	mov dato1, cx
	call imprimeres
	imprimeC divisim
	mov dato1, bx
	call imprimeres
    add ax, bx          ; Sumamos el cociente y el divisor
	posicion 12,0
	imprimePasos paso4
	mov dato1, ax
	call imprimeres
	imprimeC sumsim
	mov dato1, bx
	call imprimeres
    shr ax, 1           ; Dividimos el resultado por 2
	posicion 13,0
	imprimePasos paso5
	mov dato1, ax
	call imprimeres
	imprimeC divisim
	mov dato1, 2
	call imprimeres
    mov dx, bx          ; Movemos la raíz cuadrada anterior a DX
	posicion 14,0
	imprimePasos paso6
    mov bx, ax          ; Actualizamos el valor de la raíz cuadrada en BX
	posicion 15,0
	imprimePasos paso7
    ; Comprobamos si hemos encontrado la raíz cuadrada
	posicion 16,0
	imprimePasos paso8
	mov dato1, bx
	call imprimeres
	imprimeC igusim
	mov dato1, dx
	call imprimeres
	imprimeC quest
    cmp bx, dx
    mov [BP+14],ax
    jnz lup	
		;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	calcprehis endp	

public calcbabilonica
	calcbabilonica proc far
	push ax
	push bx
	push cx
	push dx
	push bp
mov bp,sp
mov ax,[bp+14]

	
        mov ax, dato1
        mov x, ax

    babiloni:
	posicion 9,1
	imprimePasos pasorb1

        mov ax, x
	mov aux, ax
	call imprimeresaux
	imprimeC sumsim
	mov bx,y
	mov aux, bx
	call imprimeresaux
		
	mov ax, x
        add ax, y ; ax = x + y
        mov dx, 0 ; vacía dx ya que realizaré una operación entre registro y memoria
        div d ; ax se convierte en (x + y) / 2

	
	imprimeC divisim
	mov aux, 2
	call imprimeresaux	

        mov x, ax ; el nuevo x

	posicion 10,1
	imprimePasos pasorb2
	mov aux, ax
	call imprimeresaux	

        mov ax, dato1 ; toma el valor del número inicial
	posicion 11,1
	imprimePasos pasorb3
	mov aux, ax
	call imprimeresaux


	posicion 12,1
	imprimePasos pasorb4
        mov dx, 0 ; vacía dx para dividir
	call imprimeresaux
	imprimeC divisim
        div x
	mov bx, x
	mov aux, bx
	call imprimeresaux
        mov y, ax ; el nuevo y
	imprimeC igusim
	mov aux, ax
	call imprimeresaux
        mov ax, x


	posicion 13,1
	imprimePasos pasorb5
	mov aux, ax
	call imprimeresaux
	imprimeC menosim
	mov bx, y
	mov aux, bx
	call imprimeresaux
        sub ax, y ; hace x - y para verificar la condición
        cmp ax, 0
        jle terminab
        jmp babiloni


    terminab:
        mov ax, x

	mov bx, ax

	;mov bp,sp
    	mov [BP+14],ax

		;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	calcbabilonica endp

public imprimeres
		imprimeres proc far
	push ax
	push bx
	push cx
	push dx
	;push bp

	mov ax,dato1
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
	
;restaurar
		;pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	imprimeres endp

public capturaNombre
capturaNombre proc far
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, offset nom  ; Puntero al inicio de la variable nom

captura_caracter:
    mov ah, 01h         ; Función 01h del DOS para leer un carácter desde teclado
    int 21h             ; Llamamos a la interrupción del DOS para leer el carácter

    ; Comprobar si se ingresó un número (0-9)
    cmp al, '0'
    jge es_numero       ; Si al >= '0', puede ser un número
    jmp no_es_numero

es_numero:
    cmp al, '9'
    jle captura_caracter ; Si al <= '9', es un número, volver a capturar

no_es_numero:
    cmp al, 0Dh         ; Comprobar si se presionó Enter (código ASCII 0Dh)
    je verificar_cadena_vacia ; Si se presionó Enter, verificar si la cadena está vacía

    mov [si], al        ; Almacenar el carácter en la posición actual de la cadena
    inc si              ; Avanzar al siguiente byte de la cadena
    jmp captura_caracter ; Volver a capturar otro carácter

verificar_cadena_vacia:
    cmp si, offset nom   ; Comprobar si no se ha ingresado ningún carácter
    je mensaje_cadena_vacia  ; Si la cadena está vacía, mostrar un mensaje y volver a capturar un carácter

    ; Si la cadena no está vacía, continuar con el proceso de captura
    jmp continu

mensaje_cadena_vacia:
    ; Mostrar un mensaje indicando que se debe ingresar al menos un carácter válido
    ; ...
    ;imprimeC "Esta mal $"

    ; Volver a capturar un carácter
    jmp captura_caracter

continu:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
capturaNombre endp



	public capturaMenu
capturaMenu proc far

push ax
push bx

Menu:
    mov ah, 07h
    int 21h
    mov bl, al  ; guardar el valor original de AL en BL

    cmp bl, '1'
    JB Menu
    cmp bl, '4'
    JA Menu
    mov ah, 02h
    mov dl, bl
    int 21h
    cmp bl, '1'
    JE raizprehis

    cmp bl, '2'
    JE mulrusa

    cmp bl, '3'
    JE raizbabi

    cmp bl, '4'
    JE salir
    loop Menu

pop bx
pop ax
ret
capturaMenu endp

	public imprimePortada
imprimePortada proc far

imprimeC portada

ret
imprimePortada endp

public mulrus
mulrus proc far
    push ax
    push bx
    push cx
    push dx
    push bp

    mov ax, dato1        ; Carga el multiplicando en AX
    mov bx, dato2        ; Carga el multiplicador en BX
    xor cx, cx           ; Inicializa el acumulador para el resultado

multiplica:
    posicion 11,0
    imprimePasos pasomr0
    test bx, 1           ; Verificar si el multiplicador es impar
    jz siguiente

    posicion 12,0
    imprimePasos pasomrx
    mov dato1, cx
    call imprimeres
    mov dato1, ax
    call imprimeres

    ; Sumar el multiplicando al acumulador CX
    add cx, ax           ; Sumar AX al acumulador CX
    jc overflow          ; Verificar desbordamiento después de la suma

siguiente:
    posicion 13,0
    imprimeC pasomr1
    mov dato1, ax
    call imprimeres

    shl ax, 1            ; Duplicar el multiplicando
    jc overflow          ; Verificar desbordamiento después de duplicar

    posicion 14,0
    imprimePasos pasomr2
    mov dato1, bx
    call imprimeres
    imprimeC divisim
    mov dato1, 1
    call imprimeres
    shr bx, 1            ; Dividir el multiplicador por 2

    posicion 15,0
    imprimePasos pasomr3
    mov dato1, bx
    call imprimeres
    imprimeC igusim
    mov dato1, 0
    call imprimeres
    imprimeC quest
    cmp bx, 0
    jnz multiplica       ; Repetir el proceso hasta que el multiplicador sea cero

    ; No es necesario verificar si el resultado en CX excede 65534 porque ya lo hicimos durante las sumas

    mov dato1, cx        ; Guardar el resultado en la variable suma

    ; Restaurar los registros
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret

overflow:
    ; Manejar el desbordamiento
    ; Mostrar un mensaje de error
    posicion 10,1
    imprimeC rangomul
    jmp xd

    ; Restaurar los registros
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret

mulrus endp


public imprimeresaux
		imprimeresaux proc far
	push ax
	push bx
	push cx
	push dx
	;push bp

	mov ax,aux
	mov dx,0
	mov bx,10 ;datos para dividir entre 10
	mov cx,5
dividiraux:
	div bx
	add dx,30h
	push dx
	mov dx,0
	loop dividiraux
;imprimir caracteres
	mov cx,5
imprimiraux:
	pop dx
	mov ah,02h
	int 21h
	loop imprimiraux
	
;restaurar
		;pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	imprimeresaux endp








codigo ends
;	end compa


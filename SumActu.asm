pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
mensaje db "Proporcione un numero de tres digitos$"
resultado db "El resultado es:$"
Opcion db " Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "0. SUMA",13,10
db "1. RESTA",13,10,"$"
cadenamenos db "-$"
Res db " El resultado final es: $"
Res2 db "El resultado negativo es: $"
ban dw ?
divisiondesborde db "pendejo no se usa 0$"
suma dw ?
datoA dw ?
datoB dw ?

datos ends
codigo segment para public 'code'
	public compa
imprimeC macro texto
	push ax
	push dx
	lea dx,texto
	mov ah,09h
	int 21h
	pop dx
	pop ax
endm
posicion macro renglon,columna
	push ax
	push bx
	push dx
	mov ah,02h
	mov bh,0h
	mov dh,renglon
	mov dl,columna
	int 10h
	pop dx
	pop bx
	pop ax
endm
compa proc far
	assume cs:codigo, ds:datos, ss:pila
	push ds
	mov ax,0
	push ax

	mov ax,datos
	mov ds,ax

	call limpiaP
inicio:
	

	;lea dx, mensaje
	;mov ah, 09h
	;int 21h
	posicion 2,1
	imprimeC mensaje	
	posicion 3,1
	push ax
	call captura
	pop ax

	;mov ax,200
	;push ax
	;call imprimeN
	;pop ax

	mov datoA, ax
	posicion 4,1
	imprimeC mensaje ;para imprimir un mensaje con una macro	

	posicion 5,1
	push ax
	call captura
	pop ax
	
	posicion 6,1
	imprimeC resultado
	posicion 7,1
	mov datoB, ax
	posicion 8,1
	imprimeC Opcion
Menu:
	mov ah,07h
	int 21h
	cmp al, '1'
	JB Menu
	cmp al, '3'
	JA Menu
	Mov ah,02h
	mov dl, al
	int 21h
	cmp al, '1'
        JE suma1
	cmp al, '2'
        JE resta
	cmp al, '3'
		JE salir
	loop Menu
	;Realizar la suma de los dos numeros e imprimirlos
	
	suma1:
	MOV CX,datoA
	ADD CX,datoB
	jmp imprime
resta:
	MOV CX,datoA
	cmp cx,datoB
	jb restainversa
	sub CX,datoB
	jmp imprime
restainversa:
	mov cx,datoB
	sub cx,datoA
	mov ban,1
	jmp imprime
salir:
	jmp termina

	imprime:
;IMPRIMIR EL RESULTADO
;Imprime cadena
    imprimeC Res
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
	termina:
	ret

compa endp
	limpiaP proc near
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

		ret
	limpiaP endp

	captura proc near
		;resguardar
		push ax
		push bx
		push cx
		push dx
		push bp
		mov cx, 3
		
		;captura sin eco
	captura2:	
		mov ah, 01h
		int 21h
		mov ah, 0
		sub al, 30h
		push ax
	loop captura2
		mov suma, 0
		mov bx, 1
		;mov dx 0
		mov cx, 3
	convertir:
		pop ax
		mul bx
		add suma, ax
		mov ax, 10
		mul bx
		mov bx, ax

	loop convertir
		mov bp,sp
		mov ax, suma
		mov [BP+12],ax
		;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	captura endp

	imprimeN proc near
	push ax
	push bx
	push cx
	push dx
	push bp
	mov bp,sp	

	mov bl,10
	mov cx,4
	mov dx,0
	mov ax,[bp+12]
    division:
	div bl
	mov dl,ah
	add dl,30h
	push dx
	mov ah,0
    loop division
	mov cx,4
    impresion:
	pop dx
	mov ah,02h
	int 21h
    loop impresion
	pop bp
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	imprimeN endp
	codigo ends
	end compa

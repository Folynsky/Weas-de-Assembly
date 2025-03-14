
datos segment para public 'data'
	suma dw ?
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

		ret
	limpiaP endp

	public captura
	captura proc far
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
		mov [BP+7],ax
		;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	captura endp

	public capturaindi
	capturaindi proc far
		;resguardar
		push ax
		push bx
		push cx
		push dx
		push bp
		mov cx, 1
		
		;captura sin eco
	captura3:	
		mov ah, 01h
		int 21h
		mov ah, 0
		sub al, 30h
		push ax
	loop captura3
		mov suma, 0
		mov bx, 1
		;mov dx 0
		mov cx, 1
	convertir3:
		pop ax
		mul bx
		add suma, ax
		mov ax, 10
		mul bx
		mov bx, ax

	loop convertir3
		mov bp,sp
		mov ax, suma
		mov [BP+7],ax
		;restaurar
		pop bp
		pop dx
		pop cx
		pop bx
		pop ax

		ret
	capturaindi endp


	public imprimeN
	imprimeN proc far
	push ax
	push bx
	push cx
	push dx
	push bp
	mov bp,sp	

	mov bl,10
	mov cx,4
	mov dx,0
	mov ax,[bp+7]
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
;	end compa


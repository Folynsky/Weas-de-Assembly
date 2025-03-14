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
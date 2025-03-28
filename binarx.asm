pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	cadena db "El diablo$"
	peticion db "Ingrese un numero en decimal$"
	binar db "El numero binario es:$"
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
	mov ah,09h
	lea dx, peticion
	int 21h

	mov ah, 01h
	int 21h

;sabe
	sub al, 48
	mov ah, 0	
	mov bx, 2
	mov dx, 0
        mov cx, 0
repite:
	div bx
	push dx
	mov ah,0
	inc cx
	cmp ax, 0
	jne repite
	
	mov ah, 09h
	lea dx, binar
	int 21h
mostrar:
	pop dx
	add dx, 48
	mov ah, 02h
	int 21h
	loop mostrar

	mov ah, 4ch
        int 21h 

compa endp
	codigo ends
	end compa

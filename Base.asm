pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	cadena db "El diablo$"
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
	Mov ah,01H
	int 21h
;Impresion de cadena
	lea dx,cadena
	mov ah,09h
	int 21h
;Impresion de un caracter, signo de mas
	mov dl,2bh
	mov ah,2h
	int 21h
	mov ah,7h
	int 21h
	ret

compa endp
	codigo ends
	end compa 
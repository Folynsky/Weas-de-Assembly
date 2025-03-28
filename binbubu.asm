pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	num db ?
	res db 9 dup (0)
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

;captura de numero

	mov ah, 01h
	int 21h
	sub al, 30h
	mov num, al

	mov ah, 01h
	int 21h
	sub al,30h
	mov ah, 0
	mov bl 10
	mul bl
	add num, al
	
	mov ah, 01h
	int 21h
	sub al,30h
	mov ah, 0
	mov bl 100
	mul bl
	add num, al

;Convertir a binario

	mov al, num
	mov bl, 2
	mov bh, 0
	mov cx, 8
	
	lea si, res

convert_loop:
	mob dl, 0
	div bl
	add dl, '0'
	mov [si], dl
	inc si
loop convert_loop

mov byte ptr [si], '$'

;impresion

	mov ah, 09h
	lea dx, res
	int 21h

	mov ah, 4ch
	int 21h		

compa endp
	codigo ends
	end compa

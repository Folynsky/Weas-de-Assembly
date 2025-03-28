pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
	cadena db 4 dup(?) ; 3 caracteres + null terminator
	numero db ?
binario db 9 dup(?) ; 8 bits + null terminator
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

	; Captura de la cadena
	mov ah, 0ah
	lea dx, cadena
	int 21h
	
	; Convertir a número
	mov ah, 0
	mov al, cadena[1]
	sub al, '0'
	mov bl, 10
	mul bl
	mov bh, 0
	add ax, cadena[2]
	sub ax, '0'
	mov numero, al

	; Convertir a binario
	mov bl, 8
	mov si, 0
convertir:
	mov al, numero
	shl al, 1
	jnc no_carry
	inc al
no_carry:
	add al, '0'
	mov binario[si], al
	shl numero, 1
	inc si
	loop convertir
	mov binario[si], '$' ; Null terminator

	; Impresión de binario
	lea dx, binario
	mov ah, 09h
	int 21h

	ret
compa endp
codigo ends
end compa

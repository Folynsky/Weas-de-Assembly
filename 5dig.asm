pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
cadena db "Proporciona un numero: $"
suma dw ?
dato1 dw ?
dato2 dw ?
Res db "El resultado final es: $"
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
;Imprimir cadena
	lea DX,cadena
	mov ah,09H
	int 21H
;Fin de impresion
;Primer digito No. 1
	mov cx,5
captura:
	mov ah,01h
	int 21h
	mov ah,0
	sub al,30h
	push ax
	loop captura




	mov bx,1
	mov dx,0
	mov suma,0
	mov cx,5
convertir:
	pop ax
	mul bx
	add suma,ax
	mov ax,bx
	mov bx,10
	mov dx,0
	mul bx
	mov bx,ax
	mov dx,0
	loop convertir
	mov ax,suma
	mov dato1,ax
	mov suma,0
	


;segundo dato
;Imprimir cadena
	lea DX,cadena
	mov ah,09H
	int 21H
;Fin de impresion
;Primer digito No. 2
	mov cx,5
captura2:
	mov ah,01h
	int 21h
	mov ah,0
	sub al,30h
	push ax
	loop captura2




	mov bx,1
	mov dx,0
	mov suma,0
	mov cx,5
convertir2:
	pop ax
	mul bx
	add suma,ax
	mov ax,bx
	mov bx,10
	mov dx,0
	mul bx
	mov bx,ax
	mov dx,0
	loop convertir2
	mov ax,suma
	mov dato2,ax
	mov suma,0
	mov ax,dato1
	add ax,dato2
;Aqui es para dividir
;	mov ax,dato1
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

	ret
compa endp
	codigo ends
	end compa

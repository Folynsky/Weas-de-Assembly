include FAR.asm 
pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends


datos segment para public 'data'
mensaje db "Proporcione un numero de tres digitos$"
resultado db "El resultado es:$"
;suma dw ?
datoA dw ?
datoB dw ?
Opcion db " Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "0. SUMA",13,10
db "1. RESTA",13,10,"$"

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
;	org 100h

	mov ax,datos
	mov ds,ax

	

	call limpiaP

	posicion 2,1
	imprimeC mensaje	
	posicion 3,1
	push ax
	call captura
	pop ax

        mov datoA, ax

        posicion 4,1
	imprimeC mensaje ;para imprimir un mensaje con una macro	

	posicion 5,1
	push ax
	call captura
	pop ax
        mov datoB, ax
	
	posicion 6,1
	imprimeC Opcion
        posicion 10,1
	call capturaindi
	cmp al, '0'
        JE suma1
	cmp al, '1'
        JE resta1

suma1: 
        mov ax, datoA
        add ax, datoB
        jmp imprime

resta1: 
        mov ax ,datoA
        sub ax, datoB
        jmp imprime


imprime:
        posicion 10,1
        imprimeC resultado
        posicion 11,1
        push ax
        call imprimeN
        pop ax
        ret
	;imprimeC resultado
	;posicion 7,1
	;add ax, datoA
	;push ax
	;call imprimeN
	;pop ax
	;Realizar la suma de los dos numeros e imprimirlos
        

compa endp
	
	codigo ends
	end compa

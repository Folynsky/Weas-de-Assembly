include macfari3.ASM
include procfar3.ASM
pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'

Opcion db " Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "1. Raiz Prehistorica",13,10
db "2. Multiplicacion Rusa",13,10
db "3. Raiz Babilonica",13,10
db "4. SALIR",13,10,"$"
Res db " El resultado final es: $"
nom db 20 dup(?)
saludo db "Bienvenido al programa, $"

;cadenas prehis
    cadena db " Proporciona un numero de 5 digitos: $"
    dato1 dw ?
    suma dw  ?
    msg db 'La raiz cuadrada es: $'
soli db "Bienvenido, por favor ingrese su nombre para continuar"

;cadenas rusa


;cadenas babilo

    nr dw 0 ; inicializa la variable nr con 0
    cifra dw 0
    y dw 1
    x dw 0
    d dw 2

datos ends
codigo segment para public 'code'
	public compa
compa proc far
	assume cs:codigo, ds:datos, ss:pila
	PUSH ds
	MOV ax,0
	PUSH ax

	MOV ax,datos
	MOV ds,ax
	;jmp limpiarpantalla
	call limpiaP
;INICIA ESTRUCTURA CODIGO


inicio:

	imprimeC SALUDO


    ; mostrar el menú después de recibir el nombre del usuario

	imprimeC Opcion

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

raizprehis:
    ; Aquí va el código para la opción '1'

	;IMPRIMIR CADENA
	imprimeC cadena
	;FIN DE IMPRESION

;INICIA PRIMER DATO

push ax
call captura
pop ax
mov dato1, ax
	;calcular raiz prehistorica
	push bx
	call calcprehis
	pop bx

    ; Mostrar mensaje
	imprimeC msg

    ;IMPRIMIR EL RESULTADO

	call imprimeres

	call limpiaP
	jmp inicio
mulrusa:
    ; Aquí va el código para la opción '2'
    jmp Menu

raizbabi:
    ; Aquí va el código para la opción '3'

    mov dx, offset cadena ; offset es como & en C++
    mov ah, 09h
    int 21h

    mov dl, 13 ; nueva línea
    mov ah, 02h 
    int 21h

    mov dl, 10 ; retorno de carro
    mov ah, 02h
    int 21h

	push ax
	call captura
	pop ax
	mov dato1, ax

	push bx
	call calcbabilonica
	pop bx

	call imprimeres

	call limpiaP
	jmp inicio
	
salir:
    jmp termina


termina:
    ret
compa endp
codigo ends
end compa

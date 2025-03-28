include macfari3.ASM
include procfar3.ASM
pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'

portada db "Escuela: ITSJ",13,10
    db "Unidad Academica: La Huerta",13,10
    db "Docente: Agustin Medina Bautista",13,10
    db "Alumnos: Kevin Foly Avalos y Jaime Canedo",13,10
    db "NC: 210110433",13,10
    db "Aula: A11 Grupo:6to",13,10
    db "Fecha de Entrega: 13 de Mayo del 2024",13,10,"$"

peticion db "Porfavor, ingrese su nombre para continua $"

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
warning db "Por el momento esta opcion no se encuentra disponible, por favor contacte al desarrollador y solicite informacion de la siguiente actualizacion $"

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


;inicio:
	imprimeC portada
	call limpiaP

	imprimeC peticion

	call capturaNombre

	call limpiaP
conti:

	imprimeC SALUDO
	imprimeC nom

inicio:
	

;mostrar el menú después de recibir el nombre del usuario
	posicion 1,1
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
	;llamadaPrehis

    ; Mostrar mensaje
	imprimeC msg

    ;IMPRIMIR EL RESULTADO

	call imprimeres

	call limpiaP
	jmp inicio
mulrusa:
    ; Aquí va el código para la opción '2'
    imprimeC warning
    call limpiaP
    jmp inicio

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

	imprimeC msg

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

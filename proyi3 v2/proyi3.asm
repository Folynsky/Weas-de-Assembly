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
    noes db "ta mal $"
;pasos raiz prehisotica

paso0 db "Inicia el procedimiento $"
paso1 db "Se carga numero en ax $"
paso2 db "Se limpia dx $"
paso3 db "Se divide cx por el valor de la raiz cuadrada actual$"
paso4 db "Se suma el cociente al divisor $"
paso5 db "El resultado se divide entre dos $"
paso6 db "Se mueve la raiz cuadrada anterior a dx $"
paso7 db "Se actualiza el valor de la raiz cuadrada en bx $"
paso8 db "Se comprueba si se encontro la raiz cuadrada $"
paso9 db "Se realiza el numero necesario de iteraciones para despues imrpimir el resultado $"

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
	;imprimeC portada
	;imprimeC 'Hola $'
	call imprimePortada
	call limpiaP

	imprimeC peticion
	posicion 1,1
	call capturaNombre

	call limpiaP
conti:

	imprimeC SALUDO
	imprimeC nom

inicio:
	

;mostrar el menú después de recibir el nombre del usuario
	posicion 1,1
	imprimeC Opcion
	
	call capturaMenu

raizprehis:
    ; Aquí va el código para la opción '1'

	;IMPRIMIR CADENA
	imprimeC cadena
	;FIN DE IMPRESION

;INICIA PRIMER DATO
	posicion 7,0
	push ax
	call captura
	pop ax
	mov dato1, ax
	mov ax, 0

	;calcular raiz prehistorica
	
	push bx
	call calcprehis
	pop bx
	mov dato1, bx
	mov bx,0
	;llamadaPrehis

    ; Mostrar mensaje
	posicion 18,0
	imprimeC msg

    ;IMPRIMIR EL RESULTADO
	posicion 19,0
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

    ;mov dx, offset cadena ; offset es como & en C++
    ;mov ah, 09h
    ;int 21h

    imprimeC cadena

    posicion 7,0
;    mov dl, 13 ; nueva línea
;    mov ah, 02h 
;    int 21h

   ; mov dl, 10 ; retorno de carro
   ; mov ah, 02h
   ; int 21h
	
	;imprimeC cadena
	
	push ax
	call captura
	pop ax
	mov dato1, ax

        posicion 8,0
	push bx
	call calcbabilonica
	pop bx
	mov dato1, bx

	posicion 9,0
	imprimeC msg
	posicion 10,0
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

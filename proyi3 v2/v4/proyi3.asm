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

peticion db "Porfavor, ingrese su nombre para continuar $"

Opcion db "Seleccione una opcion a realizar con los siguientes numeros: ",13,10
db "1. Raiz Prehistorica",13,10
db "2. Multiplicacion Rusa",13,10
db "3. Raiz Babilonica",13,10
db "4. SALIR",13,10,"$"
Res db " El resultado final es: $"
nom db 60 dup(?)
saludo db "Bienvenido al programa, $"

;valores auxiliares
val1 db 0
val2 db 0
val3 db 0
val4 db 0
auxili dw ?
;cadenas prehis
    cadena db " Proporciona un numero de 5 digitos: $"
    dato1 dw ?
    dato2 dw ?
    suma dw  ?
    aux dw ?
    msg db 'La raiz cuadrada es: $'
	    

    noes db "El resultado de la multiplicacion excede los limites del sistema $"
    rangomul db "El resultado de la multiplicacion excede los limites del sistema $"
    adver db "Solo se admiten numeros que esten dentro del rango de los 16 bits $"
    ceros db "No es posible calcular la raiz de cero $"

;simbolos
divisim db "/$"
sumsim db "+$"
igusim db "=$"
quest db "?$"
mayorsim db ">$"
menosim db "-$"
;pasos raiz prehistorica

paso0 db "Inicia el procedimiento $"
;paso1 db "Se carga numero en ax $"
paso2 db "Raiz cuadrada actual $"
paso3 db "Se divide cx por el valor de la raiz cuadrada actual: $"
paso4 db "Se suma el cociente al divisor $"
paso5 db "El resultado se divide entre dos $"
paso6 db "Se mueve la raiz cuadrada anterior a dx $"
paso7 db "Se actualiza el valor de la raiz cuadrada en bx $"
paso8 db "Se comprueba si se encontro la raiz cuadrada $"


;pasos mul rusa
pasomr0 db "Se verifica si el multiplicador es impar$"
pasomrx db "El resultado genera desbordamiento?$"
pasomr1 db "Se duplica el multiplicando: $"
pasomr2 db "El multiplicador se divide entre dos $"
pasomr3 db "El proceso se repite hasta que el multiplicador sea cero $"
pasomr4 db "El resultado excede el rango de 16 bits? $"

soli db "Bienvenido, por favor ingrese su nombre para continuar $"

;cadenas rusa
warning db "Por el momento esta opcion no se encuentra disponible, por favor contacte al desarrollador y solicite informacion de la siguiente actualizacion $"
msg2 db 'El resultado de la multiplicacion es: $'
cadenamr db "Ingrese un numero de 3 digitos $"
;cadenas babilo

    nr dw 0 ; inicializa la variable nr con 0
    cifra dw 0
    y dw 1
    x dw 0
    d dw 2

;pasorb0 db "Se realiza la suma x + y: $"
pasorb1 db "Se realiza la operacion (x + y / 2)$"
pasorb2 db "Nuevo valor de x: $"
pasorb3 db "Se toma el valor del numero inicial: $"
pasorb4 db "Se divide ax para obtener el nuevo valor de y: $"
pasorb5 db "Se verifica si la operacion x - y = 0: $"
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

	call imprimePortada
	call limpiaP

	imprimeC peticion
	posicion 1,1
	call capturaNombre
xd:
aqui:
	call limpiaP
conti:

	imprimeC SALUDO
	imprimeC nom

inicio:
	

;mostrar el menú después de recibir el nombre del usuario
	posicion 1,1
	imprimeC Opcion
	mov ax,0
	mov bx,0
	call capturaMenu

raizprehis:
    ; Aquí va el código para la opción '1'

	;IMPRIMIR CADENA

	imprimeC cadena
	;FIN DE IMPRESION

;INICIA PRIMER DATO
	posicion 7,0
	;fueraRango:
	push ax
	call captura
	pop ax
	
	mov dato1, ax
	
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
    ;imprimeC warning

	imprimeC cadenamr
	posicion 7,0

	push ax
	call capturarus
	pop ax

	
	;mov ax, dato1	
	cmp ax, 0
	jb aqui
	cmp ax, 500
	ja aqui	
	
	mov dato1, ax
	
	posicion 8,0
	imprimeC cadenamr
	posicion 9,0

	push ax
	call capturarus
	pop ax

	cmp ax, 0
	jb aqui
	cmp ax, 500
	ja aqui
	mov dato2, ax

	posicion 10,0
    	call mulrus
	
	posicion 17,0
	imprimeC msg2
	posicion 18,0
    	call imprimeres
    	call limpiaP

	;IMPRIMIR CADENA
	imprimeC cadena
	;FIN DE IMPRESION


    jmp inicio

raizbabi:
    ; Aquí va el código para la opción '3'

    ;mov dx, offset cadena ; offset es como & en C++
    ;mov ah, 09h
    ;int 21h

    imprimeC cadena

    posicion 7,0
	
	push ax
	call captura
	pop ax
	mov dato1, ax

        posicion 8,0
	push bx
	call calcbabilonica
	pop bx
	mov dato1, bx

	posicion 15,0
	imprimeC msg
	posicion 16,0
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

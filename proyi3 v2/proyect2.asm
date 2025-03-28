include Macimp.asm
include rusaPrueba.asm
;include Macros.asm
;include IOProcedures.asm

.model small
.stack 100h

.data
    
    prompt1 DB 'Ingrese el primer numero del 0 al 500: $'
    prompt2 DB 'Ingrese el segundo numero del 0 al 500: $'
    error_msg DB 'Numero fuera de rango, intente nuevamente.$'
    invalid_input_msg DB 'Entrada invalida, solo se permiten numeros. $'
    output DB 'El resultado es: $'
    newline DB 0Dh, 0Ah, '$'

    nombre db 21 ; 1 byte para tamaño máximo, 20 bytes para caracteres, 1 para CR
    maxTamano db 20 ; Tamaño máximo del nombre
    bytesLeidos db ?
    msgBienvenida db 'Bienvenido ', 0
    msgSolicitud db 'Introduce tu nombre: $'
    msgOperacion db ' -seleccione la operación a realizar: $'

    error_message db "Opcion no valida$", 13, 10
    rusa_message db "Has seleccionado Multiplicacion Rusa$", 13, 10
    babilonica_message db "Has seleccionado Raiz Babilonica$", 13, 10

    menuu db "1. Raiz Prehistorica", 13, 10
    db "2. Multiplicacion Rusa", 13, 10
    db "3. Raiz Babilonica", 13, 10
    db "4. SALIR", 13, 10, "$"

    portada db "INSTITUTO TECNOLOGICO SUPERIOR DE JALISCO", 13, 10
    db "CLAVE DE CARRERA: ISC-2010-224", 13, 10
    db "LENGUAJES DE INTERFAZ", 13, 10
    db "DOCENTE: AGUSTIN MEDINA BAUTISTA", 13, 10
    db "ALUMNO: JUAN CARLOS ACOSTA GUZMAN", 13, 10
    db "ALUMNA: VALERIA MONZERRAT PRECIADO GOMEZ", 13, 10
    db "NC:200112254", 13, 10
    db "AULA: A11 GRUPO:6TO", 13, 10
    db "FECHA DE ENTREGA: 31/05/2024", 13, 10, "$"

    prompt1 DB 'Ingrese el primer numero del 0 al 500: $'
    prompt2 DB 'Ingrese el segundo numero del 0 al 500: $'
    error_msg DB 'Numero fuera de rango, intente nuevamente.$'
    invalid_input_msg DB 'Entrada invalida, solo se permiten numeros. $'
    output DB 'El resultado es: $'
    newline DB 0Dh, 0Ah, '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    LIMPIAR_PANTALLA
    POSICIONAR_CURSOR 0,0
    MOSTRAR_MENSAJE portada

    POSICIONAR_CURSOR 10,0
    MOSTRAR_MENSAJE msgSolicitud

    ; Leer el nombre del usuario
    lea dx, nombre
    mov ah, 0Ah
    int 21h

    POSICIONAR_CURSOR 12,0
    MOSTRAR_MENSAJE msgBienvenida

    ; Mostrar el nombre del usuario
    lea si, [nombre+2] ; Salta los dos primeros bytes de control
    call MostrarString

    POSICIONAR_CURSOR 12,32
    MOSTRAR_MENSAJE msgOperacion

    POSICIONAR_CURSOR 14,0
    MOSTRAR_MENSAJE menuu

menu:

    ; Esperar a que el usuario elija una opción
    mov ah, 07h
    int 21h
    mov bl, al

    cmp bl, '1'
    JB menu ;el menu seguira mostrandose hasta que la opcion se valida
    cml bl, '4'
    JA menu
    mov ah, 02h
    mov dl, bl
    int 21h

    cmp al, '1'
    je raiz_prehistorica
    cmp al, '2'
    je multiplicacion_rusa
    cmp al, '3'
    je raiz_babilonica
    cmp al, '4'
    je salir
    loop menu
    ; Mostrar mensaje de error si la opción es inválida
    POSICIONAR_CURSOR 16,0
    MOSTRAR_MENSAJE error_message
    jmp fin_programa

;//////////////////////////////////////////////////////////////////

multiplicacion_rusa:
	
    POSICIONAR_CURSOR 16,0
    MOV DX, OFFSET rusa_message 
  
    jmp fin_programa
;/////////////////////////////////////////////////////////////////

raiz_babilonica:
    POSICIONAR_CURSOR 16,0
    MOSTRAR_MENSAJE babilonica_message
    jmp fin_programa

raiz_prehistorica:
    ; Aquí va el código para la Raíz Prehistórica
    jmp fin_programa

salir:
    jmp fin_programa

fin_programa:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

main endp

; Procedimiento para mostrar un string terminado en '$'
MostrarString proc
    mov ah, 09h
    repetir:
        lodsb ; Cargar el siguiente byte del nombre en AL
        cmp al, '$' ; Comprobamos si el caracter es '$'
        je fin
        int 21h ; Imprimir el caracter
        jmp repetir
    fin:
    ret
MostrarString endp

end main

pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal$"
    binar db "El numero binario es:$"
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
    mov ah,09h
    lea dx, peticion
    int 21h

    ; Captura el número de tres dígitos
    mov ah, 01h
    int 21h
    sub al, 48   ; Convertir de ASCII a número decimal

    ; Convertir el número a binario
    mov ah, 0
    mov cx, 8   ; Número de bits en un byte
    lea si, binar + 21  ; Dirección del último dígito binario

    convert_loop:
        mov dl, 0
        mov bl, 2   ; Dividir por 2 para convertir a binario
        div bl    ; Divide el número por 2
        add dl, '0'  ; Convertir el residuo a ASCII
        dec si  ; Mover al siguiente dígito
        mov [si], dl  ; Almacena el residuo en la cadena
        loop convert_loop

    ; Imprimir el resultado
    mov ah, 09h
    lea dx, binar
    int 21h

    mov ah, 4ch
    int 21h 

compa endp
codigo ends
end compa

pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db "El diablo$"
    peticion db "Ingrese un numero en decimal$"
    binar db "El numero binario es: 00000000$"
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
    mov cl, al   ; Guardar el número en cl para usarlo en la conversión a binario

    ; Convertir el número a binario
    mov si, offset binar + 16  ; Posición del último dígito binario
    mov bx, 2   ; Divisor para la conversión a binario

convert_loop:
    xor ah, ah  ; Limpiar el registro ah para dividir correctamente
    div bx      ; Dividir cl por 2
    add ah, '0' ; Convertir el residuo a ASCII
    dec si      ; Mover al siguiente dígito binario
    mov [si], ah ; Almacenar el dígito binario en la cadena
    cmp cl, 0   ; ¿Se ha completado la conversión?
    jne convert_loop

    ; Imprimir el resultado
    mov ah, 09h
    lea dx, binar
    int 21h

    mov ah, 4ch
    int 21h 

compa endp
codigo ends
end compa

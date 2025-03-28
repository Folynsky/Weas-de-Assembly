pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero de 3 digitos: $"
    numero db 3 dup(?)
    binario db 24 dup(?) ; 8 bits por dígito + null terminator
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

    ; Imprimir mensaje para ingresar el numero
    lea dx, cadena
    mov ah, 09h
    int 21h

    ; Capturar el numero de 3 digitos
    mov ah, 01h ; Leer un caracter
    int 21h     ; AL <- caracter ingresado
    sub al, 30h ; Convertir de ASCII a valor numerico
    mov bl, al  ; BL <- primer digito
    mov ah, 01h ; Leer un caracter
    int 21h     ; AL <- caracter ingresado
    sub al, 30h ; Convertir de ASCII a valor numerico
    mov cl, al  ; CL <- segundo digito
    mov ah, 01h ; Leer un caracter
    int 21h     ; AL <- caracter ingresado
    sub al, 30h ; Convertir de ASCII a valor numerico
    mov dl, al  ; DL <- tercer digito

    ; Convertir a binario
    mov al, bl
    call binario
    mov ah, 02h ; Imprimir caracter
    int 21h
    mov al, cl
    call binario
    mov ah, 02h ; Imprimir caracter
    int 21h
    mov al, dl
    call binario
    mov ah, 02h ; Imprimir caracter
    int 21h

    mov ah, 4ch
    int 21h

binario proc
    mov cx, 8
    mov bx, 0000_0001b
ciclo:
    test al, 1000_0000b
    jz cero
    mov ah, 02h ; Imprimir 1
    mov dl, '1'
    int 21h
    jmp siguiente
cero:
    mov ah, 02h ; Imprimir 0
    mov dl, '0'
    int 21h
siguiente:
    shl al, 1
    loop ciclo
    ret
binario endp

    RET
compa endp
codigo ends
end compa

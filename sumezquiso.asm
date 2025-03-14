pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporcione un numero $"
    Res db " El resultado es: $"
    num1 db 6 dup(?)  ; Primer número de hasta 5 dígitos y un terminador nulo
    num2 db 6 dup(?)  ; Segundo número de hasta 5 dígitos y un terminador nulo
    resultado db 7 dup(?) ; Resultado de la suma de hasta 6 dígitos y un terminador nulo
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

    ; Mostrar mensaje de solicitud del primer número
    LEA DX, cadena
    MOV AH,09H
    INT 21H

    ; Leer el primer número
    LEA DX, num1
    MOV AH,0AH
    INT 21H

    ; Mostrar mensaje de solicitud del segundo número
    LEA DX, cadena
    MOV AH,09H
    INT 21H

    ; Leer el segundo número
    LEA DX, num2
    MOV AH,0AH
    INT 21H

    ; Convertir las cadenas a números enteros
    mov si, offset num1 + 1
    call ascii_to_int
    mov bx, ax ; bx = primer número

    mov si, offset num2 + 1
    call ascii_to_int
    add bx, ax ; bx = suma de los dos números

    ; Convertir el resultado de vuelta a una cadena
    mov ax, bx
    call int_to_ascii

    ; Mostrar el resultado
    LEA DX, Res
    MOV AH, 09H
    INT 21H

    LEA DX, resultado + 1
    MOV AH, 09H
    INT 21H

    ret

ascii_to_int proc
    xor ax, ax
convert_loop:
    mov bl, byte ptr [si]
    cmp bl, 0
    je convert_done
    sub bl, '0'
    shl ax, 1
    shl ax, 1
    add ax, bx
    inc si
    jmp convert_loop
convert_done:
    ret
ascii_to_int endp

int_to_ascii proc
    mov cx, 4 ; Iterar sobre los 5 dígitos
    mov si, 0
convert_loop:
    mov dx, 0
    div ten
    add dl, '0'
    mov [resultado + cx], dl
    dec cx
    cmp ax, 0
    jne convert_loop
    mov byte ptr [resultado + cx], '0'
    ret
ten equ 10
int_to_ascii endp

codigo ends
end compa

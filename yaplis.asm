pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporcione un numero de 5 digitos $"
    Res db " El resultado es: $"
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
;Mostrar cadena
    LEA DX, cadena
    MOV AH,09H
    INT 21H

    ; Leer el primer número
    mov ah, 0Ah
    mov dx, num1
    int 21h

    ; Leer el segundo número
    mov ah, 0Ah
    mov dx, num2
    int 21h

    ; Convertir los números a enteros y sumarlos
    xor ax, ax
    mov si, offset num1 + 1
    call ascii_to_int
    mov bx, ax ; bx = primer número

    xor ax, ax
    mov si, offset num2 + 1
    call ascii_to_int
    add bx, ax ; bx = suma de los dos números

    ; Convertir la suma de vuelta a ASCII
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
convert_loop1:
    mov bl, byte ptr [si]
    cmp bl, 0
    je convert_done1
    sub bl, '0'
    shl ax, 1
    shl ax, 1
    add ax, bx
    inc si
    jmp convert_loop1
convert_done1:
    ret
ascii_to_int endp

int_to_ascii proc
    mov cx, 4 ; Iterar sobre los 5 dígitos
    mov si, 0
convert_loop2:
    mov dx, 0
    div ten
    add dl, '0'
    mov [resultado + cx], dl
    dec cx
    cmp ax, 0
    jne convert_loop2
    mov byte ptr [resultado + cx], '0'
    ret
ten equ 10
int_to_ascii endp

codigo ends
;end compa

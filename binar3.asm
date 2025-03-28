pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero: $"
    dato db ?
    binario db 9 dup(?) ; 8 bits + null terminator
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

    ; Imprimir mensaje
    lea DX,cadena
    MOV AH,09H
    INT 21H

    ; Capturar número
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV dato, AL

    ; Convertir a binario
    MOV CX, 8 ; 8 bits en un número de 3 dígitos
    MOV SI, 0
convertir:
    MOV AL, dato
    SHL AL, 1
    JC set_bit
clear_bit:
    MOV binario[SI], '0'
    JMP next_bit
set_bit:
    MOV binario[SI], '1'
next_bit:
    INC SI
    DEC CX
    JNZ convertir
    MOV binario[8], '$' ; Null terminator

    ; Imprimir binario
    lea DX,binario
    MOV AH,09H
    INT 21H

    RET
compa endp
codigo ends
end compa

pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena db " Proporciona un numero: $"
    dato dw ?
    binario db 17 dup(?) ; 16 bits + null terminator
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
    MOV AX, dato
    MOV CX, 16 ; 16 bits en un número de 3 dígitos
convertir:
    SHR AX, 1
    JNC no_carry
    MOV binario[CX], '1'
    JMP siguiente
no_carry:
    MOV binario[CX], '0'
siguiente:
    DEC CX
    CMP CX, 0
    JNZ convertir
    MOV binario[17], '$' ; Null terminator

    ; Imprimir binario
    lea DX,binario
    MOV AH,09H
    INT 21H

    RET
compa endp
codigo ends
end compa


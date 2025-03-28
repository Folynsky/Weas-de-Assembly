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

    ; Imprimir mensaje
    lea DX,cadena
    MOV AH,09H
    INT 21H

    ; Capturar número de 3 dígitos
    MOV CX, 3 ; 3 dígitos
    LEA DI, numero
captura_digitos:
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV [DI], AL
    INC DI
    LOOP captura_digitos

    ; Convertir a binario
    MOV SI, 0
    MOV CX, 24 ; 8 bits por dígito
    LEA DI, binario
convertir_a_binario:
    MOV AL, [numero+SI]
    MOV AH, 0
    MOV CL, 8
convertir_digito_a_binario:
    SHL AL, 1
    JC set_bit
    MOV [DI], '0'
    JMP next_bit
set_bit:
    MOV [DI], '1'
next_bit:
    INC DI
    DEC CL
    JNZ convertir_digito_a_binario
    ADD SI, 1
    LOOP convertir_a_binario
    MOV [DI], '$' ; Null terminator

    ; Imprimir binario
    lea DX,binario
    MOV AH,09H
    INT 21H

    RET
compa endp
codigo ends
end compa

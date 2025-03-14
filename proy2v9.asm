stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    palabra db 20, ?, 20 dup('$')  ; Variable para almacenar la palabra ingresada
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:stack
    push ds
    mov ax, datos
    mov ds, ax

    ; Imprimir mensaje de solicitud
    mov ah, 09h
    lea dx, mensaje_solicitud
    int 21h

    ; Leer la palabra ingresada
    mov ah, 0Ah
    lea dx, palabra
    int 21h

    ; Imprimir la palabra almacenada
    lea dx, palabra + 2
    mov ah, 09h
    int 21h

    ; Salir del programa
    mov ah, 4Ch
    int 21h

mensaje_solicitud db "Ingrese una palabra y presione Enter: $"
compa endp
codigo ends
end compa

; Definición de segmentos
include macfar.ASM
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends
datos segment para public 'data'
    saludo db "Hola Mundo$"
	
datos ends

codigo segment para public 'code'
    public compa
compa proc far
    assume cs:codigo, ds:datos, ss:stack
    push ds
    mov ax, 0
    push ax

    mov ax, datos
    mov ds, ax

     ; Llamar al macro para imprimir un número
    imprime_num 65  ; Imprimir el carácter 'A'

	imprimeC saludo

    ; Finalizar programa
    mov ah, 4Ch     ; Función DOS para terminar el programa
    int 21h         ; Llamar a la interrupción de DOS
compa endp
codigo ends
end compa

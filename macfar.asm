imprime_num macro num
    mov ah, 02h  ; Función DOS para imprimir un carácter
    mov dl, num  ; Cargar el número a imprimir en dl
    int 21h      ; Llamar a la interrupción de DOS para imprimir el carácter
endm

imprimeC macro texto
	push ax
	push dx
	lea dx,texto
	mov ah,09h
	int 21h
	pop dx
	pop ax
endm
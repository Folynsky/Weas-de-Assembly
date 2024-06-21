; Definici�n de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    numero  dw 25       ; N�mero entero cuya ra�z cuadrada queremos calcular
    raiz    dw 0         ; Variable para almacenar la ra�z cuadrada
    error   dd 0.001     ; Valor de error para detener la iteraci�n
    maximo  dw 65535     ; Valor m�ximo permitido para el n�mero
datos ends

codigo segment para public 'code'
    public compa
compa proc near
    assume cs:codigo, ds:datos
    mov ax, datos
    mov ds, ax

    	mov  ax, numero   ; Cargamos el n�mero en ax
    	mov  bx, maximo   ; Cargamos el valor m�ximo en bx
    	cmp  ax, bx          ; Comparamos el n�mero con el valor m�ximo
    	jg   fin             ; Si el n�mero es mayor que el m�ximo, terminamos

	mov  ax, numero    ; Cargamos nuevamente el n�mero en ax
    	shr  ax, 1           ; Dividimos el n�mero entre 2 para obtener una estimaci�n inicial
    	mov  raiz, ax      ; Almacenamos la estimaci�n inicial en raiz

iteracion:
    	mov  ax, numero    ; Cargamos el n�mero en ax
    	xor  dx, dx          ; Limpiamos dx para la divisi�n
    	mov  bx, raiz     ; Cargamos la raiz actual en bx
    	div  bx              ; Dividimos el n�mero entre la raiz actual
    	add  ax, bx          ; Sumamos la raiz actual al resultado
    	shr  ax, 1           ; Dividimos el resultado entre 2
    	mov  raiz, ax      ; Almacenamos la nueva estimaci�n en raiz

fin:
    ; Imprimimos el resultado
    mov  ax, raiz      ; Movemos la raiz calculada a ax
    call imprimir_raiz ; Llamamos a la funci�n de impresi�n
    jmp  finalizar     ; Saltamos al finalizar

imprimir_raiz:
    push ax            ; Guardamos el valor de raiz en la pila
    mov  ah, 2         ; Funci�n de DOS para imprimir un car�cter
    add  al, '0'       ; Convertimos el n�mero en un car�cter ASCII
    int  21h           ; Llamada a la interrupci�n de DOS
    pop  ax            ; Restauramos el valor de raiz
    ret                ; Retornamos

finalizar:
    ;pop  ds            ; Restauramos el segmento de datos
    ret

compa endp
codigo ends
end compa


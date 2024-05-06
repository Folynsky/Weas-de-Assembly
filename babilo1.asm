; Definición de segmentos
stack segment para stack 'stack'
    db 1024 dup('stack')
stack ends

datos segment para public 'data'
    numero  dw 25       ; Número entero cuya raíz cuadrada queremos calcular
    raiz    dw 0         ; Variable para almacenar la raíz cuadrada
    error   dd 0.001     ; Valor de error para detener la iteración
    maximo  dw 65535     ; Valor máximo permitido para el número
datos ends

codigo segment para public 'code'
    public compa
compa proc near
    assume cs:codigo, ds:datos
    mov ax, datos
    mov ds, ax

    	mov  ax, numero   ; Cargamos el número en ax
    	mov  bx, maximo   ; Cargamos el valor máximo en bx
    	cmp  ax, bx          ; Comparamos el número con el valor máximo
    	jg   fin             ; Si el número es mayor que el máximo, terminamos

	mov  ax, numero    ; Cargamos nuevamente el número en ax
    	shr  ax, 1           ; Dividimos el número entre 2 para obtener una estimación inicial
    	mov  raiz, ax      ; Almacenamos la estimación inicial en raiz

iteracion:
    	mov  ax, numero    ; Cargamos el número en ax
    	xor  dx, dx          ; Limpiamos dx para la división
    	mov  bx, raiz     ; Cargamos la raiz actual en bx
    	div  bx              ; Dividimos el número entre la raiz actual
    	add  ax, bx          ; Sumamos la raiz actual al resultado
    	shr  ax, 1           ; Dividimos el resultado entre 2
    	mov  raiz, ax      ; Almacenamos la nueva estimación en raiz

fin:
    ; Imprimimos el resultado
    mov  ax, raiz      ; Movemos la raiz calculada a ax
    call imprimir_raiz ; Llamamos a la función de impresión
    jmp  finalizar     ; Saltamos al finalizar

imprimir_raiz:
    push ax            ; Guardamos el valor de raiz en la pila
    mov  ah, 2         ; Función de DOS para imprimir un carácter
    add  al, '0'       ; Convertimos el número en un carácter ASCII
    int  21h           ; Llamada a la interrupción de DOS
    pop  ax            ; Restauramos el valor de raiz
    ret                ; Retornamos

finalizar:
    ;pop  ds            ; Restauramos el segmento de datos
    ret

compa endp
codigo ends
end compa


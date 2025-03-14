pila segment para stack 'stack'
    db 1024 dup('stack')
pila ends

datos segment para public 'data'
    cadena1 db "Escuela: ITSJ$"
    cadena2 db "Unidad Academica: La Huerta$"
    cadena3 db "Docente: Agustin Medina Bautista$"
    cadena4 db "Alumno: Kevin Foly Avalos$"
    cadena5 db "NC: 210110433$"
    cadena6 db "Aula: A11 Grupo:6to$"
    cadena7 db "Fecha de Entrega: 14 de Febrero del 2024$"
    tecla db ?
    SP1 db "         _          __________                              _, $"
    SP2 db "     _.-(_)._     .'          '.      .--''--.          _.-{__}-._ $"
    SP3 db "   .'________'.   | .--------. |    .'        '.      .:-'`____`'-:. $"
    SP4 db "  [____________] /` |________| `\  /   .'``'.   \    /_.-'`_  _`'-._\ $"
    SP5 db "  /  / .\/. \  \|  / / .\/. \ \  ||  .'/.\/.\'.  |  /`   / .\/. \   `\ $"
    SP6 db "  |  \__/\__/  |\_/  \__/\__/  \_/|  : |_/\_| ;  |  |    \__/\__/    | $"
    SP7 db "  \            /  \            /   \ '.\    /.' / .-\                /-. $"
    SP8 db "  /'._  --  _.'\  /'._  --  _.'\   /'. `'--'` .'\/   '._-.__--__.-_.'   \\ $"
    SP9 db " /_   `""""`   _\/_   `""""`   _\ /_  `-./\.-'  _\'.    `""""""""`    .'`\ $"
    SP10 db"(__/    '|    \ _)_|           |_)_/            \__)|        '       |   | $"
    SP11 db " |_____'|_____|   \__________/   |              |;`_________'________`;-' $"
    SP12 db "  '----------'    '----------'   '--------------'`--------------------`$"
    SP13 db "    S T A N          K Y L E        K E N N Y         C A R T M A N$"


BE1 db "                 _____                    $"   
BE2 db "              ,-'     '-.                 $"   
BE3 db "             / o       o \                $"   
BE4 db "            /   \     /   \               $"    
BE5 db "           /     )-'-(     \              $"   
BE6 db "          /     ( 6 6 )     \             $"    
BE7 db "         /       \ ' /       \            $"   
BE8 db "        /         )=(         \           $"   
BE9 db "       /   o   .--'-'--.   o   \          $"   
BE10 db "     /    I  /  -   -  \  I    \         $"    
BE11 db " .--(    (_}y/\       /\y{_)    )--.     $"   
BE12 db "(    '.___l\/__\_____/__\/l___,'    )    $"   
BE13 db " \                                 /     $"   
BE14 db "  '-._      o O o O o O o      _,-'      $"   
BE15 db "      `--Y--.___________.--Y--'          $"   
BE16 db "         |==.___________.==|             $"   
BE17 db "         `==.___________.=='             $"   
    
datos ends

codigo segment para public 'code'
    public compa

compa proc far
    assume cs:codigo, ds:datos, ss:pila
    push ds
    mov ax, 0
    push ax

    mov ax, datos
    mov ds, ax

    ; Código para borrar pantalla
    mov ah, 0fh
    int 10h
    mov ah, 0h
    int 10h

    ; Posicionamiento del cursor para cadena1
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 10
    int 10h
    ; Impresion de cadena1
    lea dx, cadena1
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena2
    mov ah, 02h
    mov bh, 0
    mov dh, 2
    mov dl, 10
    int 10h
    ; Impresion de cadena2
    lea dx, cadena2
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena3
    mov ah, 02h
    mov bh, 0
    mov dh, 3
    mov dl, 10
    int 10h
    ; Impresion de cadena3
    lea dx, cadena3
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena4
    mov ah, 02h
    mov bh, 0
    mov dh, 4
    mov dl, 10
    int 10h
    ; Impresion de cadena4
    lea dx, cadena4
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena5
    mov ah, 02h
    mov bh, 0
    mov dh, 5
    mov dl, 10
    int 10h
    ; Impresion de cadena5
    lea dx, cadena5
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena6
    mov ah, 02h
    mov bh, 0
    mov dh, 6
    mov dl, 10
    int 10h
    ; Impresion de cadena6
    lea dx, cadena6
    mov ah, 09h
    int 21h
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para cadena7
    mov ah, 02h
    mov bh, 0
    mov dh, 7
    mov dl, 10
    int 10h
    ; Impresion de cadena7
    lea dx, cadena7
    mov ah, 09h
    int 21h    
    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h

    ; Posicionamiento de cursor para dibujo SP1
    mov ah, 02h
    mov bh, 0
    mov dh, 8
    mov dl, 1
    int 10h
    ; Impresion de SP1
    lea dx, SP1
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP2
    mov ah, 02h
    mov bh, 0
    mov dh, 9
    mov dl, 1
    int 10h
    ; Impresion de SP2
    lea dx, SP2
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP3
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 1
    int 10h
    ; Impresion de SP3
    lea dx, SP3
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP4
    mov ah, 02h
    mov bh, 0
    mov dh, 11
    mov dl, 1
    int 10h
    ; Impresion de SP4
    lea dx, SP4
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP5
    mov ah, 02h
    mov bh, 0
    mov dh, 12
    mov dl, 1
    int 10h
    ; Impresion de SP5
    lea dx, SP5
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP6
    mov ah, 02h
    mov bh, 0
    mov dh, 13
    mov dl, 1
    int 10h
    ; Impresion de SP6
    lea dx, SP6
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP7
    mov ah, 02h
    mov bh, 0
    mov dh, 14
    mov dl, 1
    int 10h
    ; Impresion de SP7
    lea dx, SP7
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP8
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 1
    int 10h
    ; Impresion de SP8
    lea dx, SP8
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP9
    mov ah, 02h
    mov bh, 0
    mov dh, 16
    mov dl, 1
    int 10h
    ; Impresion de SP9
    lea dx, SP9
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP10
    mov ah, 02h
    mov bh, 0
    mov dh, 17
    mov dl, 1
    int 10h
    ; Impresion de SP10
    lea dx, SP10
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP11
    mov ah, 02h
    mov bh, 0
    mov dh, 18
    mov dl, 1
    int 10h
    ; Impresion de SP11
    lea dx, SP11
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP12
    mov ah, 02h
    mov bh, 0
    mov dh, 19
    mov dl, 1
    int 10h
    ; Impresion de SP12
    lea dx, SP12
    mov ah, 09h
    int 21h    

; Posicionamiento de cursor para dibujo SP13
    mov ah, 02h
    mov bh, 0
    mov dh, 20
    mov dl, 1
    int 10h
    ; Impresion de SP13
    lea dx, SP13
    mov ah, 09h
    int 21h

    ; Esperar a que se presione una tecla sin eco
    mov ah, 00h
    int 16h
    ; Código para borrar pantalla
    mov ah, 0fh
    int 10h
    mov ah, 0h
    int 10h

;Impresion Bob Esponja
; Posicionamiento de cursor para dibujo BE1
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 1
    int 10h
    ; Impresion de BE1
    lea dx, BE1
    mov ah, 09h
    int 21h    
; Posicionamiento de cursor para dibujo BE2
    mov ah, 02h
    mov bh, 0
    mov dh, 2
    mov dl, 1
    int 10h
    ; Impresion de BE2
    lea dx, BE2
    mov ah, 09h
    int 21h    
    
; Posicionamiento de cursor para dibujo BE3
    mov ah, 02h
    mov bh, 0
    mov dh, 3
    mov dl, 1
    int 10h
    ; Impresion de BE3
    lea dx, BE3
    mov ah, 09h
    int 21h 
; Posicionamiento de cursor para dibujo BE4
    mov ah, 02h
    mov bh, 0
    mov dh, 4
    mov dl, 1
    int 10h
    ; Impresion de BE4
    lea dx, BE4
    mov ah, 09h
    int 21h 
; Posicionamiento de cursor para dibujo BE5
    mov ah, 02h
    mov bh, 0
    mov dh, 5
    mov dl, 1
    int 10h
    ; Impresion de BE5
    lea dx, BE5
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE6
    mov ah, 02h
    mov bh, 0
    mov dh, 6
    mov dl, 1
    int 10h
    ; Impresion de BE6
    lea dx, BE6
    mov ah, 09h
    int 21h 

; Posicionamiento de cursor para dibujo BE7
    mov ah, 02h
    mov bh, 0
    mov dh, 7
    mov dl, 1
    int 10h
    ; Impresion de BE7
    lea dx, BE7
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE8
    mov ah, 02h
    mov bh, 0
    mov dh, 8
    mov dl, 1
    int 10h
    ; Impresion de BE8
    lea dx, BE8
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE9
    mov ah, 02h
    mov bh, 0
    mov dh, 9
    mov dl, 1
    int 10h
    ; Impresion de BE9
    lea dx, BE9
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE10
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 1
    int 10h
    ; Impresion de BE10
    lea dx, BE10
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE11
    mov ah, 02h
    mov bh, 0
    mov dh, 11
    mov dl, 1
    int 10h
    ; Impresion de BE11
    lea dx, BE11
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE12
    mov ah, 02h
    mov bh, 0
    mov dh, 12
    mov dl, 1
    int 10h
    ; Impresion de BE12
    lea dx, BE12
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE13
    mov ah, 02h
    mov bh, 0
    mov dh, 13
    mov dl, 1
    int 10h
    ; Impresion de BE13
    lea dx, BE13
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE14
    mov ah, 02h
    mov bh, 0
    mov dh, 14
    mov dl, 1
    int 10h
    ; Impresion de BE14
    lea dx, BE14
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE15
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 1
    int 10h
    ; Impresion de BE15
    lea dx, BE15
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE16
    mov ah, 02h
    mov bh, 0
    mov dh, 16
    mov dl, 1
    int 10h
    ; Impresion de BE16
    lea dx, BE16
    mov ah, 09h
    int 21h

; Posicionamiento de cursor para dibujo BE17
    mov ah, 02h
    mov bh, 0
    mov dh, 17
    mov dl, 1
    int 10h
    ; Impresion de BE17
    lea dx, BE17
    mov ah, 09h
    int 21h


 
    ret   ; Solo un ret al final del procedimiento
compa endp

codigo ends

end compa

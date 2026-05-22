; ============================================================
; Autor: Edson Joel Carrera Avila
; conversion.asm
; ============================================================

.586                      
.model flat, stdcall      

; ============================================================
; SECCIÓN DE DATOS (.data)
; ============================================================
.data
    cad BYTE "Hola Mundo", 0

; ============================================================
; SECCIÓN DE CÓDIGO (.code)
; ============================================================
.code

; --- Declaramos la función externa de la API de Windows ---
EXTERN ExitProcess@4 : PROC

; --- Inicio del programa ---
main PROC
    mov esi, offset cad         ; ESI apunta al inicio de la cadena en memoria

; --- Comparación de caracteres ---
comparar_caracter:
    mov al, [esi]               ; AL = carácter actual de la cadena
    cmp al, 0                   ; El fin de la cadena "Hola Mundo" esta dado por un 0
    je  fin                     ; Si AL == 0 se salta al cierre del programa

    ; FILTRO: En la tabla ASCII, las minúsculas van del 97 ('a') al 122 ('z').
    ; Si el carácter está fuera de ese rango, lo saltamos sin tocar.
    cmp al, 'a'                 ; ¿AL es menor que 'a' (97 en ASCII)?
    jb  siguiente               ; Si es menor entonces no es minúscula, saltar sin convertir
    cmp al, 'z'                 ; ¿AL es mayor que 'z' (122 en ASCII)?
    ja  siguiente               ; Si es mayor entonces no es minúscula, saltar sin convertir

    ; CONVERSIÓN: Restar 32 al código ASCII de la minúscula nos da la mayúscula.
    sub al, 32                  ; Convertimos: restamos 32 al valor ASCII
    mov [esi], al               ; Guardamos la mayúscula de vuelta en la misma posición de memoria

; --- Avance del puntero ---
siguiente:
    inc esi                     ; Avanzamos al siguiente carácter de la cadena
    jmp comparar_caracter       ; Volvemos al inicio del ciclo

; --- Fin del programa ---
fin:
    push 0               
    call ExitProcess@4

main ENDP                
END main                 
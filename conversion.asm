; ============================================================
; Autor: Edson Joel Carrera Avila
; conversion.asm
; ============================================================

.586                        ; Usamos instrucciones del procesador 586 (Pentium)
.model flat, stdcall        ; Modelo de memoria plana; stdcall es la convención de llamadas de Windows

; ============================================================
; SECCIÓN DE DATOS (.data)
; ============================================================
.data
    ; Declaramos una cadena de texto
    cad BYTE "Hola Mundo", 0

; ============================================================
; SECCIÓN DE CÓDIGO (.code)
; ============================================================
.code

EXTERN ExitProcess@4 : PROC

; --- Inicio del programa ---
main PROC

    mov esi, offset cad         ; ESI apunta al inicio de la cadena en memoria

; ============================================================
; CICLO PRINCIPAL: recorre la cadena carácter por carácter.
; ============================================================
comparar_caracter:

    mov al, [esi]               ; AL = carácter actual de la cadena
    cmp al, 0                   ; El fin de la cadena "Hola Mundo" esta dado por un 0
    je  finalizar               ; Si AL == 0 se salta al cierre del programa

    ; ----------------------------------------------------------
    ; FILTRO: En la tabla ASCII, las minúsculas van del 97 ('a') al 122 ('z').
    ; Si el carácter está fuera de ese rango, lo saltamos sin tocar.
    ; ----------------------------------------------------------
    cmp al, 'a'                 ; ¿AL es menor que 'a' (97 en ASCII)?
    jb  siguiente               ; Si es menor entonces no es minúscula, saltar sin convertir

    cmp al, 'z'                 ; ¿AL es mayor que 'z' (122 en ASCII)?
    ja  siguiente               ; Si es mayor entonces no es minúscula, saltar sin convertir

    ; ----------------------------------------------------------
    ; CONVERSIÓN: Restar 32 al código ASCII de la minúscula nos da la mayúscula.
    ; ----------------------------------------------------------
    sub al, 32                  ; Convertimos: restamos 32 al valor ASCII
    mov [esi], al               ; Guardamos la mayúscula de vuelta en la misma posición de memoria

; ----------------------------------------------------------
; AVANCE DEL PUNTERO
; ----------------------------------------------------------
siguiente:
    inc esi                     ; Avanzamos al siguiente carácter de la cadena
    jmp comparar_caracter       ; Volvemos al inicio del ciclo

; ============================================================
; FIN DEL PROGRAMA
; ============================================================
finalizar:
    push 0                      ; Argumento: código de salida 0 (sin errores)
    call ExitProcess@4          ; Llamamos a Windows para cerrar el proceso limpiamente

main ENDP                       ; Marca el fin del procedimiento "main"
END main                        ; Le dice al ensamblador que "main" es el punto de entrada

.586
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.data
    cad BYTE "Hola Mundo", 0  ; Usamos el 0 al final como marcador de fin

.code
main PROC
    mov esi, offset cad      ; ESI apunta al inicio de nuestra cadena en memoria

comparar_caracter:
    mov al, [esi]            ; Movemos el contenido de la memoria a AL
    cmp al, 0                ; ¿Llegamos al final de la cadena (el cero)?
    je finalizar             ; Si es igual a cero, saltamos al final

    ; --- Lógica de filtrado ---
    cmp al, 'a'              ; ¿Es menor que 'a'?
    jb siguiente             ; Si es menor, no es minúscula, saltamos
    cmp al, 'z'              ; ¿Es mayor que 'z'?
    ja siguiente             ; Si es mayor, no es minúscula, saltamos

    ; --- Conversión Directa ---
    sub al, 32               ; Restamos 32 para subir a Mayúsculas (A-Z)
    mov [esi], al            ; Guardamos el resultado de vuelta en la memoria

siguiente:
    inc esi                  ; Incrementamos el puntero (apuntar al siguiente byte)
    jmp comparar_caracter    ; Repetimos el ciclo de forma manual

finalizar:
    invoke ExitProcess, 0    ; Cerramos el programa limpiamente
main ENDP
END main

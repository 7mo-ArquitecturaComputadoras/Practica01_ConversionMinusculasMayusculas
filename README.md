# Práctica 01 — Conversión de Minúsculas a Mayúsculas en Ensamblador x86

## Descripción

Programa en ensamblador x86 que recorre una cadena de texto almacenada en memoria y convierte cada letra **minúscula** a su equivalente en **mayúscula**, operando directamente sobre los valores ASCII de los caracteres.

La conversión se basa en la propiedad de la tabla ASCII:

```
Si 'a' (97) <= carácter <= 'z' (122):
    carácter -= 32    →  resultado en rango 'A' (65) – 'Z' (90)
Si carácter fuera de ese rango:
    no se modifica   →  dígitos, espacios y mayúsculas se conservan
```

---

## Estructura del Proyecto

```
Practica01_ConversionMayusculas/
└── conversion.asm    # Programa principal: recorre la cadena y aplica la conversión
```

---

## Interfaz y Convención de Llamada

El programa es autocontenido: declara la cadena en la sección `.data` y la procesa directamente en `main`. No requiere interfaz con C++.

| Elemento   | Descripción                                      |
|------------|--------------------------------------------------|
| `cad`      | Cadena terminada en `0` declarada en `.data`     |
| `ESI`      | Registro puntero que recorre la cadena           |
| `AL`       | Registro de 8 bits que contiene el carácter actual |

La directiva `.model flat, stdcall` indica modelo de memoria plana con la convención de llamadas estándar de Windows. Al finalizar, se invoca `ExitProcess@4` para cerrar el proceso limpiamente.

---

## Funcionamiento del Algoritmo

El programa implementa un ciclo de lectura-modificación-escritura sobre la cadena. En cada iteración se evalúa si el carácter cae en el rango ASCII de las minúsculas; de ser así, se le resta 32 y se escribe de vuelta en la misma posición de memoria.

### Flujo de ejecución

```
Inicio
 └─ ESI = dirección de cad

comparar_caracter:
 ├─ AL = [ESI]
 ├─ AL == 0 ? → finalizar
 ├─ AL < 'a' ? → siguiente   (no es minúscula)
 ├─ AL > 'z' ? → siguiente   (no es minúscula)
 └─ AL -= 32  → [ESI] = AL   (conversión a mayúscula)

siguiente:
 └─ ESI++  →  volver a comparar_caracter

finalizar:
 └─ ExitProcess(0)
```

### Ejemplo con la cadena `"Hola Mundo"`

| Carácter | ASCII | ¿Minúscula? | Resultado | ASCII |
|----------|-------|-------------|-----------|-------|
| `H`      |  72   | No          | `H`       |  72   |
| `o`      | 111   | Sí          | `O`       |  79   |
| `l`      | 108   | Sí          | `L`       |  76   |
| `a`      |  97   | Sí          | `A`       |  65   |
| ` `      |  32   | No          | ` `       |  32   |
| `M`      |  77   | No          | `M`       |  77   |
| `u`      | 117   | Sí          | `U`       |  85   |
| `n`      | 110   | Sí          | `N`       |  78   |
| `d`      | 100   | Sí          | `D`       |  68   |
| `o`      | 111   | Sí          | `O`       |  79   |

Resultado final en memoria: `"HOLA MUNDO"`

---

## Instrucciones x86 Utilizadas

| Instrucción | Operación |
|-------------|-----------|
| `MOV`       | Copia un valor entre registro y memoria |
| `CMP`       | Compara dos valores restando sin guardar resultado |
| `JE`        | Salta si el resultado de `CMP` fue igual (Zero Flag = 1) |
| `JB`        | Salta si el operando es menor (sin signo) |
| `JA`        | Salta si el operando es mayor (sin signo) |
| `SUB`       | Resta el operando fuente del destino |
| `INC`       | Incrementa el operando en 1 |
| `JMP`       | Salto incondicional |
| `PUSH`      | Empuja un valor a la pila |
| `CALL`      | Llama a un procedimiento |

---

## Ejemplo de Ejecución

```
Cadena original  : Hola Mundo
Cadena convertida: HOLA MUNDO
```

---

## Requisitos

- **Ensamblador:** MASM (Microsoft Macro Assembler), incluido en Visual Studio
- **Arquitectura:** x86 (32 bits), modo protegido plano (`flat`)
- **Sistema operativo:** Windows (uso de `ExitProcess` de la WinAPI)
- **Convención de llamadas:** `stdcall`

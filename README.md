# Práctica 01 — Conversión de Minúsculas a Mayúsculas en Ensamblador x86

Programa en ensamblador x86 (MASM) que recorre una cadena de texto almacenada en memoria y convierte cada letra **minúscula** a **mayúscula** operando directamente sobre los valores ASCII, sin llamadas a librerías de C/C++.

> **Autor:** Edson Joel Carrera Avila

---

## ¿Qué hace?

Aprovecha que en la tabla ASCII las minúsculas (`'a'..'z'` = 97..122) y las mayúsculas (`'A'..'Z'` = 65..90) están separadas exactamente por 32 posiciones:

```
si  'a' ≤ carácter ≤ 'z'   →  carácter -= 32   (se convierte a mayúscula)
caso contrario             →  no se modifica   (dígitos, espacios y mayúsculas se conservan)
```

Ejemplo: `"Hola Mundo"` → `"HOLA MUNDO"`.

---

## Estructura del repositorio

```
Practica01_ConversionMinusculasMayusculas/
├── documentacion/
│   ├── main.tex                                          # Reporte técnico (LaTeX, TeX Live / MiKTeX)
│   ├── Practica01_ConversionMinusculasMayusculas.pdf     # Reporte compilado
│   ├── diagramas/                                        # Capturas e imágenes del reporte
│   │   ├── memoria_01.png
│   │   └── memoria_02.png
│   └── manual_instalacion.md                             # Guía paso a paso para otros desarrolladores
│
├── proyecto/
│   ├── src/
│   │   └── conversion.asm                                # Código fuente principal (MASM x86)
│   ├── tests/                                            # Reservado para pruebas futuras
│   ├── Practica01_ConversionMinusculasMayusculas.slnx    # Solución de Visual Studio
│   └── Practica01_ConversionMinusculasMayusculas.vcxproj # Proyecto MSBuild + MASM
│
├── .gitignore                                            # Archivos y carpetas ignorados por Git
└── README.md                                             # Este archivo
```

> **Nota sobre el modelo de referencia:** el proyecto sigue el esquema general `documentacion / proyecto / .gitignore / README.md`. La sección `bases_de_datos/` del modelo no aplica aquí porque el programa no persiste información: opera enteramente sobre una cadena declarada en `.data`.

---

## Cómo ejecutarlo (resumen)

1. Instala **Visual Studio** con la carga de trabajo *Desktop development with C++* (incluye MASM).
2. Abre `proyecto/Practica01_ConversionMinusculasMayusculas.slnx`.
3. Selecciona la configuración **Debug | Win32**.
4. Compila con `Ctrl + Shift + B` y ejecuta con `F5`.
5. Para ver el resultado, coloca un *breakpoint* en la etiqueta `fin:` e inspecciona la cadena `cad` en la ventana de memoria.

Pasos detallados, requisitos y resolución de problemas en [`documentacion/manual_instalacion.md`](documentacion/manual_instalacion.md).

---

## Algoritmo

```
inicio
 └─ ESI = dirección de cad

comparar_caracter:
 ├─ AL = [ESI]
 ├─ AL == 0  ? → fin
 ├─ AL < 'a' ? → siguiente
 ├─ AL > 'z' ? → siguiente
 └─ AL -= 32  → [ESI] = AL

siguiente:
 └─ ESI++  →  comparar_caracter

fin:
 └─ ExitProcess(0)
```

### Trazado con `"Hola Mundo"`

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

Resultado final en memoria: `"HOLA MUNDO"`.

---

## Instrucciones x86 utilizadas

| Instrucción | Operación                                                 |
|-------------|-----------------------------------------------------------|
| `MOV`       | Copia un valor entre registro y memoria                   |
| `CMP`       | Compara dos valores (resta sin guardar el resultado)      |
| `JE`        | Salta si el resultado de `CMP` fue igual (`ZF = 1`)       |
| `JB`        | Salta si el operando es menor (sin signo)                 |
| `JA`        | Salta si el operando es mayor (sin signo)                 |
| `SUB`       | Resta el operando fuente del destino                      |
| `INC`       | Incrementa el operando en 1                               |
| `JMP`       | Salto incondicional                                       |
| `PUSH`      | Empuja un valor a la pila                                 |
| `CALL`      | Llama a un procedimiento                                  |

---

## Requisitos

- **Ensamblador:** MASM (`ml.exe`), incluido con Visual Studio.
- **Arquitectura:** x86 (32 bits), modo protegido plano (`.model flat, stdcall`).
- **Sistema operativo:** Windows (usa `ExitProcess` de la WinAPI).
- **LaTeX (opcional):** TeX Live o MiKTeX para recompilar el reporte.

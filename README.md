# 🔤 Práctica 01 — Conversión de Minúsculas a Mayúsculas en Ensamblador x86

Programa escrito en **ensamblador x86 (MASM)** que recorre una cadena de texto almacenada en memoria y convierte cada letra **minúscula** a su equivalente en **mayúscula**, operando directamente sobre los valores ASCII de los caracteres, sin usar funciones externas de C/C++.

---

## 📑 Índice

- [🎯 ¿Qué hace el programa?](#-qué-hace-el-programa)
- [🧠 Idea central del algoritmo](#-idea-central-del-algoritmo)
- [📂 Estructura del repositorio](#-estructura-del-repositorio)
- [🚀 Cómo empezar](#-cómo-empezar)
- [🔍 Trazado del ejemplo `"Hola Mundo"`](#-trazado-del-ejemplo-hola-mundo)
- [📘 Instrucciones x86 utilizadas](#-instrucciones-x86-utilizadas)
- [📄 Documentación adicional](#-documentación-adicional)

---

## 🎯 ¿Qué hace el programa?

El programa toma una cadena de texto declarada en la sección `.data` (por ejemplo, `"Hola Mundo"`) y la recorre **carácter por carácter** modificándola **directamente en memoria**:

- Si el carácter es una **letra minúscula** (`'a'` a `'z'`), lo convierte a su **mayúscula** correspondiente.
- Si el carácter es **cualquier otra cosa** (dígito, espacio, signo de puntuación, letra ya mayúscula), lo **deja intacto**.

El resultado es una transformación *in-place*: la misma cadena en memoria queda convertida, sin crear copias.

---

## 🧠 Idea central del algoritmo

Aprovecha que, en la **tabla ASCII**, las minúsculas (`'a'..'z'` → 97..122) y las mayúsculas (`'A'..'Z'` → 65..90) están separadas **exactamente por 32 posiciones**:

```
si  'a' ≤ carácter ≤ 'z'   →  carácter -= 32   (se convierte a mayúscula)
caso contrario             →  no se modifica   (se conserva tal cual)
```

### Flujo de ejecución

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

---

## 📂 Estructura del repositorio

```
Practica01_ConversionMinusculasMayusculas/
├── documentacion/
│   ├── README_compilacion_latex.md                       # Cómo compilar el .tex a PDF
│   ├── reporte.tex                                       # Reporte técnico en LaTeX
│   ├── reporte.pdf                                       # Reporte ya compilado
│   └── imagenes/                                         # Imágenes usadas en el reporte
│
├── proyecto/
│   ├── README_instalacion.md                             # Guía de instalación y puesta en marcha
│   ├── Practica01_ConversionMinusculasMayusculas.slnx    # Solución de Visual Studio
│   ├── Practica01_ConversionMinusculasMayusculas.vcxproj # Proyecto MSBuild + MASM
│   └── src/
│       └── conversion.asm                                # Código fuente principal (MASM x86)
|
├── .gitattributes                                        # Normalización de finales de línea
├── .gitignore                                            # Archivos ignorados por Git
└── README.md                                             # Este archivo
```

---

## 🚀 Cómo empezar

La guía detallada con todos los pasos (instalar Git, Visual Studio, habilitar MASM, compilar y ejecutar) está en un documento aparte:

➡️ **[Guía de instalación y puesta en marcha](proyecto/README_instalacion.md)**

Resumen rápido para quien ya tiene el entorno listo:

1. Abre el **Símbolo del sistema** (`cmd`) o **Git Bash**, ubícate en la carpeta donde quieras guardar el proyecto y ejecuta:
```bash
git clone git@github.com:7mo-ArquitecturaComputadoras/Practica01_ConversionMinusculasMayusculas.git
```
2. Abrir `proyecto/Practica01_ConversionMinusculasMayusculas.slnx` en Visual Studio.
3. Seleccionar configuración **Debug | Win32**.
4. Compilar con `Ctrl + Shift + B` y ejecutar con `F5`.
5. Inspeccionar la cadena `cad` desde la ventana **Depurar → Ventanas → Memoria**.

---

## 🔍 Trazado del ejemplo `"Hola Mundo"`

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

Resultado final en memoria: **`"HOLA MUNDO"`**.

---

## 📘 Instrucciones x86 utilizadas

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

## 📄 Documentación adicional

| Documento | Descripción |
|---|---|
| 🛠️ [`README_instalacion.md`](proyecto/README_instalacion.md) | Cómo instalar Git, Visual Studio con MASM, compilar y ejecutar el programa paso a paso. |
| 📄 [`README_compilacion_latex.md`](documentacion/README_compilacion_latex.md) | Cómo regenerar el PDF del reporte a partir de `reporte.tex` usando TeX Live, Geany o VS Code, tanto en Linux como en Windows. |
| 📕 [`reporte.pdf`](documentacion/reporte.pdf) | Reporte técnico ya compilado, con explicación detallada y capturas de memoria. |
| 📝 [`reporte.tex`](documentacion/reporte.tex) | Fuente LaTeX del reporte. |

---

> **Autor:** Edson Joel Carrera Avila

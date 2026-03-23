---
name: code-review
description: Revisa código como un senior dev: correctitud, seguridad, mantenibilidad, performance y convenciones del proyecto.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---

# Code Review ($ARGUMENTS)

## Objetivo
Revisar: $ARGUMENTS (archivo, carpeta, o diff/PR)

## Qué revisar (en orden de prioridad)

### 🔴 Crítico — debe bloquearse
- **Seguridad**: inyección SQL, XSS, CSRF, secrets hardcodeados, auth bypass, path traversal.
- **Correctitud**: bugs lógicos obvios, race conditions, pérdida de datos, manejo de errores ausente.
- **Breaking change no documentado**: cambio de contrato de API/DB sin migración.

### 🟡 Mejora — debería corregirse
- **Performance**: N+1, loops O(n²) evitables, falta de memoización, over-fetching.
- **Mantenibilidad**:
  - Función >40 líneas o >3 niveles de indentación.
  - Magic numbers / strings sin constante.
  - Lógica duplicada (DRY violation).
  - Nombre de variable/función que no describe su propósito.
- **Tipado**: `any` sin justificación, castings forzados, tipos demasiado amplios.
- **Tests**: código nuevo sin tests, mocks que ocultan el comportamiento real.

### 🟢 Nitpick — sugerencia
- Naming conventions del proyecto.
- Orden de imports.
- Consistencia de estilo.
- Comentarios desactualizados o redundantes.

## Formato de salida
Para cada hallazgo:
```
[🔴/🟡/🟢] archivo.ts:línea — Descripción del problema
→ Sugerencia concreta o snippet de fix
```

Al final: resumen de 3-5 puntos más importantes y veredicto (Approve / Request Changes / Needs Discussion).

## Reglas
- Distingue entre opinión y hecho objetivo.
- Si hay varias formas válidas, menciona pros/cons en lugar de imponer una.
- Celebra lo que está bien hecho (1-2 puntos positivos).

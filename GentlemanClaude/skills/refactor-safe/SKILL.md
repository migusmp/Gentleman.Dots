---
name: refactor-safe
description: Refactor seguro con pasos y verificación: plan, cambios pequeños, QA, resumen.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Refactor seguro ($ARGUMENTS)

## Objetivo
Refactor sin romper comportamiento: $ARGUMENTS

## Checklist
1) Delimita alcance (qué archivos, qué NO tocar).
2) Haz refactor en commits pequeños (si el flujo lo permite).
3) Mantén APIs/contratos.
4) Ejecuta QA al final (y si puedes, durante).

## Reglas
- No “optimices” a la vez que refactorizas si no es necesario.
- Si aparece incertidumbre funcional, prioriza test o confirmación con logs.
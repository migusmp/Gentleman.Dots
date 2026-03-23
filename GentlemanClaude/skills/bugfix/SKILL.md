---
name: bugfix
description: Arregla un bug de forma reproducible: reproduce, añade test si procede, arregla, pasa QA.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Bugfix reproducible ($ARGUMENTS)

## Input
- Bug/issue: $ARGUMENTS

## Método
1) Identifica el punto de entrada (ruta/handler/componente).
2) Reproduce:
   - Encuentra log/stacktrace o crea un repro mínimo.
3) Si es viable, añade test que falle (unit/integration/e2e).
4) Aplica fix mínimo y explica el porqué.
5) Ejecuta QA (o al menos el set relevante).
6) Devuelve:
   - Causa raíz
   - Fix aplicado
   - Tests/comandos ejecutados
   - Riesgos/edge cases
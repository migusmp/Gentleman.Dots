---
name: qa
description: Ejecuta QA del proyecto (lint, tests, typecheck, build) y arregla errores hasta pasar.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# QA end-to-end

## Objetivo
Dejar el repo en estado verde: lint + tests + typecheck + build (según aplique).

## Pasos
1) Descubre comandos válidos:
   - Busca `package.json`, `Makefile`, `justfile`, `cargo`, `mvn/gradle`, README.
2) Ejecuta en orden (elige lo que exista):
   - `lint` → `test` → `typecheck` → `build`
3) Si falla:
   - Corrige con el cambio mínimo.
   - Repite el comando exacto hasta que pase.
4) Al finalizar:
   - Resume qué fallaba, qué tocaste y qué comandos pasaron.

## Reglas
- No actualices dependencias ni regeneres lockfiles salvo que el error lo exija.
- No hagas cambios grandes si un fix pequeño basta.
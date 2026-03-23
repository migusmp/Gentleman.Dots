---
name: pr-summary
description: Resume una PR con gh: qué cambia, riesgos, checklist de revisión y testing.
context: fork
agent: Explore
disable-model-invocation: true
allowed-tools: Bash(gh *)
---

## Contexto PR
- Diff: !`gh pr diff $ARGUMENTS`
- Archivos: !`gh pr diff $ARGUMENTS --name-only`
- Detalles: !`gh pr view $ARGUMENTS --comments`

## Tu tarea
1) Resumen en 5-10 bullets.
2) Cambios por área (frontend/backend/db/infra).
3) Riesgos/edge cases.
4) Qué probar manualmente.
5) Si detectas smells, sugiere mejoras concretas.
---
name: commit-msg
description: Genera un mensaje de commit (Conventional Commits) a partir de git diff.
disable-model-invocation: true
allowed-tools: Bash(git diff *), Bash(git status *), Read
---

# Commit message

## Contexto
- Status: !`git status --porcelain`
- Diff: !`git diff`

## Salida
Devuelve 3 opciones:
1) Conventional Commit corto (type(scope): summary)
2) Otro más descriptivo (máx 72 chars)
3) Uno orientado a release notes

Incluye también 2-4 bullets “body” opcionales.
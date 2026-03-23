---
name: repo-map
description: Genera un mapa del repo: árbol, módulos, puntos de entrada, y hotspots.
disable-model-invocation: true
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob, Bash
---

# Repo Map ($ARGUMENTS)

## Objetivo
Entender rápido el repo (ideal al empezar o antes de refactor): $ARGUMENTS

## Pasos
1) Árbol de carpetas (nivel 3-4).
2) Puntos de entrada (main, app root, routers).
3) Módulos principales y dependencias.
4) “Hotspots”: archivos grandes, complejos o muy acoplados.
5) Propuesta de 3 mejoras de estructura (sin tocar nada).

Entrega en Markdown.
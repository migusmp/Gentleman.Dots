---
name: secrets-scan
description: Busca posibles secretos antes de commit/PR (tokens, keys, .env) y sugiere mitigaciones.
disable-model-invocation: true
allowed-tools: Grep, Glob, Read, Bash
---

# Secrets scan

## Qué buscar
- Archivos: .env, *.pem, keys, credentials, config con tokens
- Patrones: api_key, secret, token, bearer, private_key, aws_access_key_id, etc.

## Pasos
1) Lista archivos sospechosos.
2) Grep por patrones (con contexto corto).
3) Reporta hallazgos con: archivo, línea, por qué es riesgo.
4) Mitigación: mover a env var, gitignore, rotar credenciales si aplica.
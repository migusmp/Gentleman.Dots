---
name: api-design
description: Diseña o revisa una API REST/GraphQL: contratos, convenciones, seguridad, versionado y spec OpenAPI.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# API Design / Review ($ARGUMENTS)

## Objetivo
$ARGUMENTS (diseñar nueva API, revisar existente, o generar spec OpenAPI)

## Pasos

### Si es diseño nuevo
1) Entiende el dominio: entidades, relaciones, acciones.
2) Propone estructura de endpoints:
   - Recursos en plural, sustantivos (`/users`, `/orders/{id}/items`)
   - Métodos HTTP semánticos (GET/POST/PUT/PATCH/DELETE)
   - Anidación máx 2 niveles
3) Define contratos de request/response (JSON con tipos).
4) Propone códigos de estado HTTP correctos por caso.
5) Señala dónde aplicar autenticación/autorización (JWT, API Key, OAuth scope).
6) Propone paginación (cursor > offset para listas grandes).
7) Genera stub OpenAPI 3.1 en YAML.

### Si es revisión de API existente
1) Escanea rutas/controladores (`routes/`, `controllers/`, `resolvers/`, `handlers/`).
2) Revisa:
   - Consistencia de naming y verbos HTTP
   - Manejo de errores (¿devuelve stack en producción?)
   - Validación de input
   - N+1 queries o over-fetching
   - Falta de rate limiting / auth guards
3) Lista hallazgos por severidad: 🔴 crítico / 🟡 mejora / 🟢 nitpick.
4) Propone refactors concretos con código.

## Reglas
- Sigue REST semántico o convenciones GraphQL según el stack del proyecto.
- Nunca expongas IDs internos de DB sin motivo (usa slugs/UUIDs).
- Documenta breaking changes claramente.

---
name: docker-dev
description: Genera o mejora Dockerfile y docker-compose para entorno de desarrollo local (hot-reload, DB, servicios auxiliares).
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Docker Dev Setup ($ARGUMENTS)

## Objetivo
$ARGUMENTS (crear setup desde cero, revisar Dockerfile/compose existente, o añadir servicio)

## Pasos

### 1. Detecta el stack
- Lee `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, etc.
- Identifica: runtime, framework, puerto de app, servicios necesarios (DB, cache, queue, mail).

### 2. Dockerfile (multi-stage para producción, stage dev para desarrollo)

```dockerfile
# Ejemplo Node.js
FROM node:22-alpine AS base
WORKDIR /app

FROM base AS deps
COPY package*.json ./
RUN npm ci

FROM deps AS dev
# Hot reload en dev
CMD ["npm", "run", "dev"]

FROM deps AS builder
COPY . .
RUN npm run build

FROM base AS production
COPY --from=builder /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
CMD ["node", "dist/main.js"]
```

**Buenas prácticas Dockerfile**:
- `node:XX-alpine` / `python:XX-slim` (imagen ligera).
- Usuario no-root: `USER node` antes de CMD.
- `.dockerignore` con `node_modules`, `.git`, `dist`, `*.log`.
- `COPY package*.json` antes que `COPY .` para cachear deps.
- Variables de entorno sólo con `ENV` para valores no secretos.

### 3. docker-compose.yml (entorno de desarrollo)

Incluye:
- Servicio `app` con `volumes: [.:/app]` para hot-reload.
- `depends_on` con healthcheck para DB.
- Servicios auxiliares según stack:
  - PostgreSQL / MySQL / MongoDB
  - Redis
  - MailHog (SMTP de desarrollo)
  - Adminer / pgAdmin (UI de DB)
- Red interna (`networks`) para aislamiento.
- Secrets/credenciales en archivo `.env` (generado desde `.env.example`).

### 4. Si es revisión de setup existente
- Revisa imagen base (¿está desactualizada? ¿usa latest sin pin?).
- Capas innecesarias (muchos RUN separados que podrían unirse con `&&`).
- Secretos hardcodeados en ENV o ARG.
- Sin healthcheck en servicios críticos.
- Bind mount de `node_modules` (causa problemas en Mac/Windows).
- Falta de límites de recursos (memory, cpus) en compose.

### 5. Entrega
- Dockerfile + docker-compose.yml + .env.example + .dockerignore.
- Comandos de uso:
  ```bash
  docker compose up -d        # levantar
  docker compose logs -f app  # logs
  docker compose exec app sh  # shell
  ```

---
name: db-schema
description: Diseña o revisa un schema de base de datos (SQL/NoSQL): normalización, índices, relaciones, migraciones y naming.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Database Schema ($ARGUMENTS)

## Objetivo
$ARGUMENTS (diseñar nuevo schema, revisar existente, o generar migración)

## Si es diseño nuevo

### 1. Modelado
- Identifica entidades y relaciones (1:1, 1:N, N:M).
- Normaliza a 3FN salvo que haya razón de performance para desnormalizar.
- Para N:M usa tabla pivot explícita con sus propios metadatos si aplica.

### 2. Naming conventions
- Tablas: `snake_case`, plural (`users`, `order_items`).
- Columnas: `snake_case`, descriptivas (`created_at`, `user_id`).
- PKs: `id` (serial/uuid según caso).
- FKs: `{tabla_referenciada_singular}_id`.
- Booleans: `is_*`, `has_*`, `can_*`.

### 3. Campos estándar en toda tabla
```sql
id          uuid/serial PRIMARY KEY
created_at  timestamptz NOT NULL DEFAULT now()
updated_at  timestamptz NOT NULL DEFAULT now()
```

### 4. Índices
- PK siempre.
- FK siempre (la mayoría de ORMs no los crean automáticamente).
- Campos frecuentes en WHERE, ORDER BY, JOIN.
- Índice compuesto para queries con múltiples filtros frecuentes.
- Índice parcial si hay muchos NULLs o valores dominantes.

### 5. Constraints
- NOT NULL donde tenga sentido.
- CHECK constraints para enums/rangos.
- UNIQUE donde aplique.
- ON DELETE: CASCADE o RESTRICT según semántica del dominio.

## Si es revisión de schema existente
1) Lee archivos de migración (`migrations/`, `prisma/schema.prisma`, `schema.rb`, `alembic/`).
2) Revisa:
   - FKs sin índice
   - Columnas nullable sin justificación
   - Ausencia de timestamps
   - Tipos incorrectos (varchar para fechas, int para UUIDs)
   - Tablas desnormalizadas sin justificación de performance
3) Lista hallazgos con severidad y propone ALTER/migración.

## Si genera migración
- Escribe la migración up y down.
- Advierte sobre migraciones destructivas (DROP, cambio de tipo en tabla grande).
- Si la tabla tiene >1M filas sugiere estrategia sin lock (pg: `ADD COLUMN` con default null, backfill, luego NOT NULL).

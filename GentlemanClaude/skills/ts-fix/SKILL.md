---
name: ts-fix
description: Arregla errores de TypeScript (tsc, ts-check), mejora tipos sueltos (any, as, !) y activa strict mode progresivamente.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# TypeScript Fix ($ARGUMENTS)

## Objetivo
$ARGUMENTS (arreglar errores de compilación, mejorar tipos, o migrar a strict)

## Pasos

### 1. Diagnóstico
```bash
npx tsc --noEmit 2>&1 | head -60   # errores actuales
```
Si no hay tsconfig, créalo mínimo:
```json
{ "compilerOptions": { "strict": true, "target": "ES2022", "moduleResolution": "bundler" } }
```

### 2. Prioriza errores por tipo

| Prioridad | Tipo de error | Estrategia |
|-----------|---------------|------------|
| 🔴 | `Property does not exist`, `is not assignable` | Fix inmediato: definir tipos correctos |
| 🔴 | `Object is possibly null/undefined` | Narrowing, optional chaining, guard |
| 🟡 | `Parameter implicitly has 'any' type` | Anotar o inferir desde uso |
| 🟡 | `as any`, `@ts-ignore` sin comentario | Reemplazar con tipo real o `unknown` |
| 🟢 | `Non-null assertion (!)` excesivo | Refactor a optional chaining o guard |

### 3. Patrones de fix

**Narrowing en lugar de cast:**
```ts
// ❌
const val = (data as User).name
// ✅
if (isUser(data)) { const val = data.name }
```

**Tipado de respuestas fetch:**
```ts
// ❌
const data = await res.json()
// ✅
const data: User = await res.json() as User  // o usa zod/valibot
```

**Discriminated union en lugar de optional fields:**
```ts
// ❌
type Result = { data?: User; error?: string }
// ✅
type Result = { ok: true; data: User } | { ok: false; error: string }
```

**Genérico en lugar de any:**
```ts
// ❌
function wrap(val: any): any { return { value: val } }
// ✅
function wrap<T>(val: T): { value: T } { return { value: val } }
```

### 4. Activar strict progresivamente (si aplica)
Orden recomendado en tsconfig:
1. `"noImplicitAny": true`
2. `"strictNullChecks": true`
3. `"strictFunctionTypes": true`
4. `"strict": true` (activa todo)

Arregla errores que aparezcan en cada paso antes de continuar.

### 5. Reglas
- No uses `any` ni `@ts-ignore` como escape fácil.
- Prefiere `unknown` + narrowing sobre `any`.
- Si un tipo externo no tiene `@types/*`, crea un `.d.ts` mínimo.
- No cambies lógica de negocio para satisfacer al compilador — si el tipo no encaja, el tipo está mal, no la lógica.

---
name: perf-audit
description: Audita rendimiento (frontend y/o backend): identifica bottlenecks, N+1, bundle size, renders innecesarios y propone fixes.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---

# Performance Audit ($ARGUMENTS)

## Objetivo
Auditar rendimiento de: $ARGUMENTS (ruta, componente, endpoint, o repo completo)

## Frontend

### Bundle & carga
- Revisa `next.config`, `vite.config`, `webpack.config` → chunks, splitting, tree-shaking.
- Detecta imports pesados sin lazy load (`import X from 'heavyweight-lib'`).
- Imágenes sin optimizar o sin `width/height`.
- Fonts bloqueantes.

### React/Vue renders
- Grep por `useEffect` sin deps o con deps inestables (objetos/arrays inline).
- Componentes que reciben props de objeto completo cuando sólo necesitan un campo.
- Listas sin `key` estable o con `key={index}`.
- Estado en componente padre que provoca re-render masivo de árbol.

### Web Vitals targets
| Métrica | Bueno | Mejorar |
|---------|-------|---------|
| LCP     | <2.5s | >4s     |
| CLS     | <0.1  | >0.25   |
| INP     | <200ms| >500ms  |

## Backend

### Queries / N+1
- Grep por ORM calls dentro de loops (`forEach`, `map`, `for`).
- Falta de `include`/`select`/`join` → over-fetching.
- Índices faltantes: busca columnas en WHERE/ORDER sin índice declarado.
- Transacciones largas o locks innecesarios.

### API & caching
- Endpoints sin paginación en listas.
- Ausencia de cache (Redis, in-memory, HTTP cache-control).
- Payload de respuesta excesivo (campos no usados por el cliente).

### Node.js específico
- Operaciones síncronas (`fs.readFileSync`, `JSON.parse` de payloads grandes) en el request path.
- Falta de streaming para respuestas grandes.

## Entrega
Lista de hallazgos con:
- 🔴 Impacto alto / 🟡 Medio / 🟢 Bajo
- Archivo + línea
- Fix concreto con código o config

---
name: test-gen
description: Genera tests (unit, integration, e2e) para el código indicado: casos happy path, edge cases y errores.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Test Generation ($ARGUMENTS)

## Objetivo
Generar tests completos para: $ARGUMENTS

## Pasos
1) **Detecta el framework de testing**:
   - Busca `jest`, `vitest`, `mocha`, `pytest`, `testing-library`, `playwright`, `cypress` en `package.json`/`requirements.txt`.
2) **Lee el código objetivo** para entender:
   - Inputs / outputs / side effects
   - Dependencias externas (DB, APIs, FS) → candidatos a mock/stub
3) **Genera tests en capas**:

   ### Unit tests
   - Happy path (caso normal)
   - Cada rama condicional (if/else, switch)
   - Edge cases: null, undefined, string vacío, array vacío, valores límite
   - Error paths (throws, promise reject)

   ### Integration tests (si aplica)
   - Flujo completo de un feature (handler → service → repo)
   - Con DB en memoria o test container si es posible

   ### E2E tests (si aplica)
   - Flujos críticos del usuario (login, checkout, CRUD principal)

4) **Convenciones**:
   - Nombrado: `describe('NombreUnidad') > it('debería X cuando Y')`
   - Arrange / Act / Assert bien separados
   - Un solo assert lógico por test (o agrupar con `expect.soft`)
   - Mocks explícitos, nada de `any`

5) **Coverage objetivo**: ≥80% branches del archivo objetivo.

## Reglas
- No generes tests que sólo comprueban implementación interna (test behavior, not implementation).
- Si el código es muy difícil de testear, señálalo y sugiere cómo refactorizar para testeabilidad.
- Usa factories/builders para datos de test, no literales inline repetidos.

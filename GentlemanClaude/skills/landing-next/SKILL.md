---
name: landing-next
description: Genera una landing en Next.js (responsive, accesible, moderna) con secciones, CTA y animaciones suaves.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Landing Next.js ($ARGUMENTS)

## Input
- Negocio/tema: $ARGUMENTS

## Requisitos
- Mobile-first
- Menú mobile
- Secciones típicas: Hero, Servicios, Beneficios, Testimonios, FAQ, Contacto
- Componentes reutilizables
- Accesibilidad (labels, contraste, teclado)
- Animaciones sutiles (aparición por sección)

## Proceso
1) Detecta stack del repo (App Router, Tailwind, shadcn/ui).
2) Crea estructura de componentes.
3) Implementa la landing.
4) Asegura CTA claro (WhatsApp/llamar/form).
5) Ejecuta build/lint si existen.

## Entrega
- Archivos creados/modificados
- Comandos ejecutados
- Qué queda por personalizar (copy, imágenes, datos reales)
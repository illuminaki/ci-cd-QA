# Hola Mundo - Suma de Números en Ruby

Programa simple en Ruby que suma dos números con CI/CD configurado.

## 📋 Descripción

Este proyecto incluye:
- ✅ Programa Ruby que suma dos números
- ✅ Linter RuboCop configurado
- ✅ CI/CD con GitHub Actions
- ✅ Verificación automática de código

## 🚀 Uso

### Ejecutar el programa

```bash
ruby suma.rb
```

El programa te pedirá dos números y mostrará la suma.

## 🔧 Configuración del Linter

### Instalar dependencias

```bash
bundle install
```

### Ejecutar RuboCop manualmente

```bash
# Verificar el código
bundle exec rubocop

# Auto-corregir problemas
bundle exec rubocop -a
```

## 🔄 CI/CD con GitHub Actions

El workflow se ejecuta automáticamente en:
- Push a ramas: `main`, `master`, `develop`
- Pull requests a estas ramas

### Jobs configurados:

1. **Lint**: Ejecuta RuboCop para verificar el estilo del código
2. **Test**: Verifica la sintaxis y que el programa sea válido

## 📁 Estructura del Proyecto

```
.
├── suma.rb              # Programa principal
├── Gemfile              # Dependencias Ruby
├── .rubocop.yml         # Configuración del linter
├── .github/
│   └── workflows/
│       └── ci.yml       # Workflow de GitHub Actions
└── README.md            # Este archivo
```

## 🛠️ Requisitos

- Ruby >= 2.7.0
- Bundler

## 📝 Notas

- El linter RuboCop está configurado con reglas estándar
- La longitud máxima de línea es 120 caracteres
- El workflow de CI/CD verifica automáticamente cada commit

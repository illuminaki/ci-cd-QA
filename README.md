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

1. **Lint**: Ejecuta RuboCop para verificar el estilo del código ❌ **FALLA si hay errores**
2. **Test**: Verifica la sintaxis y que el programa sea válido (solo se ejecuta si lint pasa)

### 🔒 Protección de rama

Para configurar GitHub y evitar merges cuando el linter falla, consulta: **[CONFIGURACION_GITHUB.md](CONFIGURACION_GITHUB.md)**

### 🧪 Ver el CI/CD en acción

El archivo `ejemplo_con_error.rb` contiene errores intencionales de linter. Puedes ver cómo falla el CI/CD:

```bash
# Ver los errores
bundle exec rubocop ejemplo_con_error.rb

# El workflow de GitHub Actions fallará automáticamente con este archivo
```

**Estado actual del CI/CD**: Ve a [GitHub Actions](https://github.com/illuminaki/ci-cd-QA/actions) para ver los resultados.

## 📁 Estructura del Proyecto

```
.
├── suma.rb                    # Programa principal (sin errores)
├── ejemplo_con_error.rb       # Ejemplo con errores de linter
├── Gemfile                    # Dependencias Ruby
├── .rubocop.yml               # Configuración del linter
├── CONFIGURACION_GITHUB.md    # Guía para configurar protección de rama
├── .github/
│   └── workflows/
│       └── ci.yml             # Workflow de GitHub Actions
└── README.md                  # Este archivo
```

## 🛠️ Requisitos

- Ruby >= 2.7.0
- Bundler

## 📝 Notas

- El linter RuboCop está configurado con reglas estándar
- La longitud máxima de línea es 120 caracteres
- El workflow de CI/CD verifica automáticamente cada commit

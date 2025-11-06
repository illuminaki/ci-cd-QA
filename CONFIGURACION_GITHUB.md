# Configuración de GitHub para Protección de Ramas

## 🔒 Cómo configurar la protección de rama en GitHub

Para evitar que se hagan merge si el linter falla, sigue estos pasos:

### 1. Ir a la configuración del repositorio

1. Ve a tu repositorio en GitHub: `https://github.com/illuminaki/ci-cd-QA`
2. Haz clic en **Settings** (Configuración)
3. En el menú lateral, selecciona **Branches** (Ramas)

### 2. Agregar regla de protección

1. Haz clic en **Add branch protection rule** (Agregar regla de protección de rama)
2. En **Branch name pattern**, escribe: `main`

### 3. Configurar las reglas

Marca las siguientes opciones:

#### ✅ Require a pull request before merging
- Esto obliga a crear un Pull Request antes de hacer merge

#### ✅ Require status checks to pass before merging
- Marca esta opción
- Haz clic en **Add checks**
- Busca y selecciona:
  - `RuboCop Linter` (el job de lint)
  - `Pruebas del programa` (el job de test)

#### ✅ Require branches to be up to date before merging
- Asegura que la rama esté actualizada con main

#### ✅ Do not allow bypassing the above settings
- Evita que los administradores salten estas reglas

### 4. Guardar cambios

Haz clic en **Create** o **Save changes** al final de la página.

## 🧪 Probar la configuración

### Crear una rama con errores de linter:

```bash
# Crear una nueva rama
git checkout -b test-linter-error

# El archivo ejemplo_con_error.rb ya tiene errores
git add ejemplo_con_error.rb
git commit -m "Agregar archivo con errores de linter"
git push origin test-linter-error
```

### Crear Pull Request:

1. Ve a GitHub y crea un Pull Request desde `test-linter-error` hacia `main`
2. Verás que el check de **RuboCop Linter** falla ❌
3. GitHub no permitirá hacer merge hasta que se corrijan los errores

## 📊 Estado del CI/CD

El workflow se ejecuta automáticamente en:
- ✅ Push a ramas: `main`, `master`, `develop`
- ✅ Pull Requests a estas ramas

### Jobs configurados:

1. **lint**: Ejecuta RuboCop (DEBE pasar para continuar)
2. **test**: Verifica sintaxis (solo se ejecuta si lint pasa)

## 🔧 Corregir errores de linter

```bash
# Ver errores
bundle exec rubocop

# Auto-corregir errores simples
bundle exec rubocop -a

# Auto-corregir todos los errores posibles (incluso los inseguros)
bundle exec rubocop -A
```

## 📝 Notas importantes

- El workflow **fallará automáticamente** si RuboCop encuentra errores
- El job `test` solo se ejecuta si el job `lint` pasa exitosamente (gracias a `needs: lint`)
- No se puede hacer merge a `main` si los checks no pasan (una vez configurada la protección)

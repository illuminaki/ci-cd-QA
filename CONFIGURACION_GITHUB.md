# Configuración de GitHub para Protección de Ramas

## 🔒 Cómo configurar la protección de rama con Branch Rulesets (Método Moderno)

Para evitar que se hagan merge si el linter falla, usa **Branch Rulesets**, la forma moderna de proteger ramas en GitHub.

### 1. Ir a la configuración del repositorio

1. Ve a tu repositorio en GitHub: `https://github.com/illuminaki/ci-cd-QA`
2. Haz clic en **Settings** (Configuración)
3. En el menú lateral, busca la sección **Code and automation**
4. Selecciona **Rules** → **Rulesets**

### 2. Crear un nuevo Branch Ruleset

1. Haz clic en **New branch ruleset** (o **Add branch ruleset**)
2. Verás la interfaz de configuración de Rulesets

### 3. Configuración básica del Ruleset

#### Ruleset Name
- Nombre: `Protección Main - CI/CD Required`

#### Enforcement status
- Selecciona: **Active** (para que las reglas se apliquen inmediatamente)
- Opciones disponibles:
  - **Active**: Las reglas se aplican
  - **Evaluate**: Solo evalúa pero no bloquea (modo prueba)
  - **Disabled**: Desactivado

#### Bypass list (opcional)
- Deja vacío para que nadie pueda saltarse las reglas
- O agrega roles/equipos específicos que puedan hacer bypass si es necesario

### 4. Configurar Target branches (Ramas objetivo)

1. En la sección **Target branches**, haz clic en **Add target**
2. Selecciona **Include by pattern**
3. Escribe el patrón: `main`
4. También puedes agregar: `master` y `develop` si los usas

### 5. Configurar las reglas (Rules)

Marca las siguientes opciones en la sección **Branch rules**:

#### ✅ Require a pull request before merging
- **Marca esta opción**
- Configuración recomendada:
  - **Required approvals**: 1 (opcional, si quieres revisiones)
  - **Dismiss stale pull request approvals when new commits are pushed**: Activado
  - **Require approval of the most recent reviewable push**: Activado

#### ✅ Require status checks to pass
- **Marca esta opción** (Esta es la más importante para el CI/CD)
- Haz clic en **Add checks**
- Busca y selecciona los siguientes checks:
  - `RuboCop Linter` (el job de lint del workflow)
  - `Pruebas del programa` (el job de test del workflow)
- **Require branches to be up to date before merging**: Activado
  - Esto asegura que la rama esté actualizada con main antes del merge

#### ✅ Block force pushes
- **Marca esta opción**
- Previene que se hagan force push a la rama protegida

#### ✅ Require linear history (opcional)
- Marca si quieres evitar merge commits
- Fuerza a usar rebase o squash merge

#### ⚠️ Restrict deletions (recomendado)
- **Marca esta opción**
- Solo usuarios con bypass permission pueden eliminar la rama main

### 6. Guardar el Ruleset

1. Revisa todas las configuraciones
2. Haz clic en **Create** al final de la página
3. El ruleset estará activo inmediatamente

---

## 📋 Resumen de configuración mínima requerida

Para que el CI/CD bloquee merges cuando falla el linter:

| Configuración | Valor |
|--------------|-------|
| **Ruleset Name** | `Protección Main - CI/CD Required` |
| **Enforcement status** | Active |
| **Target branches** | `main` |
| **Require a pull request before merging** | ✅ Activado |
| **Require status checks to pass** | ✅ Activado |
| **Status checks requeridos** | `RuboCop Linter`, `Pruebas del programa` |
| **Require branches to be up to date** | ✅ Activado |
| **Block force pushes** | ✅ Activado |

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
- No se puede hacer merge a `main` si los checks no pasan (una vez configurado el ruleset)

---

## 🆚 Branch Rulesets vs Branch Protection Rules (Clásico)

### ¿Por qué usar Branch Rulesets?

**Branch Rulesets** es el método moderno y recomendado por GitHub. Ventajas:

| Característica | Branch Rulesets (Moderno) | Branch Protection (Clásico) |
|----------------|---------------------------|----------------------------|
| **Interfaz** | Más clara y organizada | Interfaz antigua |
| **Múltiples ramas** | Un ruleset para múltiples patrones | Una regla por rama |
| **Modo evaluación** | Sí (puedes probar sin bloquear) | No |
| **Gestión centralizada** | Todos los rulesets en un lugar | Disperso por ramas |
| **Futuro** | ✅ Recomendado por GitHub | ⚠️ Será deprecado eventualmente |

### ¿Cómo identificar qué método usar?

En **Settings** → **Rules**:
- Si ves **"Rulesets"** y **"Branch protection rules"** separados → Usa **Rulesets** (moderno)
- Si solo ves **"Branches"** → Usa Branch Protection Rules (clásico)

### Migración desde Branch Protection Rules

Si ya tienes Branch Protection Rules configuradas:
1. Ve a **Settings** → **Rules** → **Rulesets**
2. GitHub te mostrará las reglas clásicas existentes
3. Puedes crear un nuevo Ruleset con la misma configuración
4. Una vez verificado, puedes eliminar las reglas clásicas

---

## 🔍 Verificar que los checks están disponibles

**Importante**: Los status checks (`RuboCop Linter`, `Pruebas del programa`) solo aparecerán en la lista después de que el workflow se haya ejecutado **al menos una vez**.

### Pasos para que aparezcan los checks:

1. Haz un commit y push a cualquier rama
2. Espera a que el workflow de GitHub Actions se ejecute
3. Regresa a la configuración del Ruleset
4. Ahora los checks aparecerán en la lista para seleccionar

### Si no aparecen los checks:

Verifica que los nombres en el workflow coincidan:

```yaml
# En .github/workflows/ci.yml
jobs:
  lint:
    name: RuboCop Linter    # ← Este nombre debe aparecer en GitHub
  
  test:
    name: Pruebas del programa    # ← Este nombre debe aparecer en GitHub
```

---

## 🎯 Configuración recomendada para proyectos profesionales

Para un entorno de producción, considera esta configuración:

### Ruleset para rama `main`:
- ✅ Require a pull request before merging (con 1-2 aprobaciones)
- ✅ Require status checks to pass (todos los checks del CI/CD)
- ✅ Require branches to be up to date
- ✅ Block force pushes
- ✅ Restrict deletions
- ✅ Require linear history (opcional, para historial limpio)

### Ruleset para ramas `develop` o `staging`:
- ✅ Require status checks to pass (checks básicos)
- ✅ Block force pushes
- ⚠️ Menos restrictivo que main

### Bypass list:
- Solo para casos de emergencia
- Agrega solo a usuarios/equipos específicos con permisos de administrador

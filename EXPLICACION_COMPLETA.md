# Explicación Completa del Proyecto: CI/CD con GitHub Actions

## ¿Qué es este proyecto?

Este es un proyecto educativo en Ruby que demuestra la implementación de **CI/CD (Integración Continua y Despliegue Continuo)** usando **GitHub Actions** con un **linter (RuboCop)** para garantizar la calidad del código.

### Componentes principales:
1. **Programa Ruby**: Suma dos números (`suma.rb`)
2. **Linter RuboCop**: Verifica calidad y estilo del código
3. **GitHub Actions**: Automatiza la verificación del código en cada commit
4. **Ejemplo de errores**: Archivo con errores intencionales para demostrar el flujo

---

## ¿Qué es CI/CD?

### **CI (Continuous Integration - Integración Continua)**
Es la práctica de integrar cambios de código frecuentemente en un repositorio compartido. Cada integración se verifica automáticamente mediante:
- ✅ Compilación automática
- ✅ Pruebas automatizadas
- ✅ Análisis de calidad de código (linting)

### **CD (Continuous Deployment - Despliegue Continuo)**
Es la práctica de desplegar automáticamente el código que pasa todas las verificaciones a producción.

### **Beneficios:**
- Detecta errores tempranamente
- Mantiene la calidad del código
- Acelera el desarrollo
- Facilita la colaboración en equipo
- Proporciona feedback inmediato

---

## GitHub Actions: ¿Qué es y cómo funciona?

**GitHub Actions** es una plataforma de CI/CD integrada en GitHub que permite automatizar flujos de trabajo.

### Conceptos clave:

#### 1. **Workflow (Flujo de trabajo)**
Archivo YAML que define el proceso automatizado. Se guarda en `.github/workflows/`

#### 2. **Events (Eventos)**
Acciones que disparan el workflow:
- `push`: Cuando se hace push a una rama
- `pull_request`: Cuando se crea/actualiza un PR
- `schedule`: Ejecución programada
- `workflow_dispatch`: Ejecución manual

#### 3. **Jobs (Trabajos)**
Conjunto de pasos que se ejecutan en una máquina virtual. Pueden ejecutarse en paralelo o secuencialmente.

#### 4. **Steps (Pasos)**
Tareas individuales dentro de un job (ejecutar comandos, usar acciones, etc.)

#### 5. **Runners**
Servidores que ejecutan los workflows (GitHub proporciona runners gratuitos: Ubuntu, Windows, macOS)

---

## Explicación del Código

### 1. **Programa Principal (`suma.rb`)**

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

# Clase para realizar operaciones matemáticas
class Calculadora
  def self.sumar(numero1, numero2)
    numero1 + numero2
  end
end

# Programa principal
def main
  puts '¡Hola Mundo!'
  puts 'Programa de suma de dos números'
  puts '================================'
  
  print 'Ingresa el primer número: '
  num1 = gets.chomp.to_f
  
  print 'Ingresa el segundo número: '
  num2 = gets.chomp.to_f
  
  resultado = Calculadora.sumar(num1, num2)
  puts "\nResultado: #{num1} + #{num2} = #{resultado}"
end

main if __FILE__ == $PROGRAM_NAME
```

**Explicación:**
- `#!/usr/bin/env ruby`: Shebang para ejecutar el archivo directamente
- `frozen_string_literal: true`: Optimización de Ruby para strings inmutables
- `class Calculadora`: Clase que encapsula la lógica de suma
- `def self.sumar`: Método de clase (no requiere instanciar)
- `gets.chomp.to_f`: Lee entrada del usuario y convierte a float
- `main if __FILE__ == $PROGRAM_NAME`: Solo ejecuta main si el archivo se llama directamente

### 2. **Configuración del Linter (`.rubocop.yml`)**

```yaml
AllCops:
  NewCops: enable
  TargetRubyVersion: 2.7
  Exclude:
    - 'vendor/**/*'
    - 'node_modules/**/*'

Style/Documentation:
  Enabled: false

Metrics/MethodLength:
  Max: 20

Metrics/AbcSize:
  Max: 20

Layout/LineLength:
  Max: 120
```

**Explicación:**
- `AllCops`: Configuración global de RuboCop
- `NewCops: enable`: Habilita nuevas reglas automáticamente
- `TargetRubyVersion`: Versión de Ruby objetivo
- `Exclude`: Directorios a ignorar
- `Style/Documentation`: Desactiva la obligación de documentar clases
- `Metrics/MethodLength`: Máximo 20 líneas por método
- `Layout/LineLength`: Máximo 120 caracteres por línea

### 3. **Workflow de CI/CD (`.github/workflows/ci.yml`)**

```yaml
name: CI - Ruby Linter

on:
  push:
    branches: [ main, master, develop ]
  pull_request:
    branches: [ main, master, develop ]

jobs:
  lint:
    name: RuboCop Linter
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout código
        uses: actions/checkout@v4
      
      - name: Configurar Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          bundler-cache: true
      
      - name: Instalar dependencias
        run: bundle install
      
      - name: Ejecutar RuboCop
        run: bundle exec rubocop
      
      - name: Verificar sintaxis Ruby
        run: ruby -c suma.rb

  test:
    name: Pruebas del programa
    runs-on: ubuntu-latest
    needs: lint
    
    steps:
      - name: Checkout código
        uses: actions/checkout@v4
      
      - name: Configurar Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
      
      - name: Verificar que el programa se ejecuta
        run: |
          echo "Verificando que el programa Ruby es válido..."
          ruby -c suma.rb
          echo "✓ Sintaxis correcta"
```

**Explicación línea por línea:**

- `name: CI - Ruby Linter`: Nombre del workflow que aparece en GitHub
- `on:`: Define cuándo se ejecuta el workflow
  - `push: branches: [ main, master, develop ]`: Se ejecuta en push a estas ramas
  - `pull_request: branches: [ main, master, develop ]`: Se ejecuta en PRs a estas ramas
- `jobs:`: Define los trabajos a ejecutar
- `lint:`: Primer job (linting)
  - `runs-on: ubuntu-latest`: Usa una máquina virtual Ubuntu
  - `steps:`: Pasos del job
    - `uses: actions/checkout@v4`: Descarga el código del repositorio
    - `uses: ruby/setup-ruby@v1`: Instala Ruby 3.2
    - `bundler-cache: true`: Cachea las dependencias para acelerar
    - `run: bundle install`: Instala las gemas del Gemfile
    - `run: bundle exec rubocop`: **Ejecuta el linter (FALLA si hay errores)**
    - `run: ruby -c suma.rb`: Verifica la sintaxis
- `test:`: Segundo job (pruebas)
  - `needs: lint`: **Solo se ejecuta si el job lint pasa exitosamente**

---

## Comandos para Ejecutar Todo

### **1. Instalación inicial**

```bash
# Clonar el repositorio (si aún no lo tienes)
git clone git@github.com:illuminaki/ci-cd-QA.git
cd ci-cd-QA

# Instalar Ruby (si no está instalado)
sudo apt update
sudo apt install -y ruby-full ruby-bundler

# Verificar instalación
ruby -v
bundle -v
```

### **2. Instalar dependencias del proyecto**

```bash
# Instalar las gemas (RuboCop y dependencias)
bundle install --path vendor/bundle
```

### **3. Ejecutar el programa principal**

```bash
# Ejecutar el programa de suma
ruby suma.rb

# O darle permisos de ejecución y ejecutarlo directamente
chmod +x suma.rb
./suma.rb
```

### **4. Ejecutar el linter (RuboCop)**

```bash
# Ver todos los archivos y sus errores
bundle exec rubocop

# Ver errores de un archivo específico
bundle exec rubocop suma.rb
bundle exec rubocop ejemplo_con_error.rb

# Auto-corregir errores simples
bundle exec rubocop -a

# Auto-corregir todos los errores posibles (incluso los "inseguros")
bundle exec rubocop -A

# Ver solo archivos con errores
bundle exec rubocop --format offenses
```

### **5. Verificar sintaxis Ruby**

```bash
# Verificar sintaxis de un archivo
ruby -c suma.rb
ruby -c ejemplo_con_error.rb
```

### **6. Comandos de Git**

```bash
# Ver estado del repositorio
git status

# Ver historial de commits
git log --oneline

# Crear una nueva rama
git checkout -b nombre-de-rama

# Agregar archivos al staging
git add .
git add archivo_especifico.rb

# Hacer commit
git commit -m "Descripción del cambio"

# Subir cambios a GitHub (esto dispara el CI/CD)
git push origin main
git push origin nombre-de-rama

# Ver ramas remotas
git remote -v

# Actualizar desde el remoto
git pull origin main
```

### **7. Comandos para probar el CI/CD**

```bash
# 1. Crear una rama con errores
git checkout -b test-linter-falla

# 2. Modificar el archivo con errores
# (editar ejemplo_con_error.rb para agregar más errores)

# 3. Hacer commit y push
git add ejemplo_con_error.rb
git commit -m "Agregar más errores de linter"
git push origin test-linter-falla

# 4. Ir a GitHub y crear un Pull Request
# Verás que el check de RuboCop falla ❌

# 5. Corregir los errores
bundle exec rubocop -a ejemplo_con_error.rb

# 6. Hacer commit de las correcciones
git add ejemplo_con_error.rb
git commit -m "Corregir errores de linter"
git push origin test-linter-falla

# Ahora el check pasará ✅
```

---

## Cómo Funciona el Flujo Completo

### **Flujo sin errores (✅ Pasa el CI/CD):**

1. Desarrollador escribe código limpio
2. Hace commit y push a GitHub
3. GitHub Actions se dispara automáticamente
4. Job `lint` se ejecuta:
   - Descarga el código
   - Instala Ruby y dependencias
   - Ejecuta RuboCop → **✅ No encuentra errores**
   - Verifica sintaxis → **✅ Correcta**
5. Job `test` se ejecuta (porque `lint` pasó):
   - Verifica que el programa es válido → **✅ Pasa**
6. **Resultado: ✅ Workflow exitoso**
7. Se puede hacer merge al main

### **Flujo con errores (❌ Falla el CI/CD):**

1. Desarrollador escribe código con errores de estilo
2. Hace commit y push a GitHub
3. GitHub Actions se dispara automáticamente
4. Job `lint` se ejecuta:
   - Descarga el código
   - Instala Ruby y dependencias
   - Ejecuta RuboCop → **❌ Encuentra 12 errores**
   - **Job falla con exit code 1**
5. Job `test` **NO se ejecuta** (porque `lint` falló)
6. **Resultado: ❌ Workflow fallido**
7. **NO se puede hacer merge** (si la protección de rama está configurada)
8. Desarrollador debe corregir errores y hacer nuevo push

---

## Ver los Resultados en GitHub

### **1. Ver todos los workflows:**
```
https://github.com/illuminaki/ci-cd-QA/actions
```

### **2. Ver un workflow específico:**
- Click en el workflow que quieres ver
- Verás los jobs: `lint` y `test`
- Click en cada job para ver los logs detallados

### **3. Interpretar los resultados:**
- ✅ **Verde**: Todo pasó correctamente
- ❌ **Rojo**: Hay errores que deben corregirse
- 🟡 **Amarillo**: En ejecución

---

## Configurar Protección de Rama en GitHub

Para evitar que se haga merge con errores:

### **Pasos:**

1. Ve a: `https://github.com/illuminaki/ci-cd-QA/settings/branches`

2. Click en **"Add branch protection rule"**

3. En **"Branch name pattern"** escribe: `main`

4. Marca estas opciones:
   - ☑️ **Require a pull request before merging**
   - ☑️ **Require status checks to pass before merging**
     - Busca y selecciona: `RuboCop Linter`
     - Busca y selecciona: `Pruebas del programa`
   - ☑️ **Require branches to be up to date before merging**

5. Click en **"Create"** o **"Save changes"**

### **Resultado:**
- No se podrá hacer merge si el linter falla
- Solo código limpio puede entrar a `main`
- Protege la calidad del código base

---

## Conceptos Importantes

### **¿Qué es un Linter?**
Un linter es una herramienta que analiza el código para encontrar:
- Errores de sintaxis
- Problemas de estilo
- Malas prácticas
- Código que no sigue convenciones

**RuboCop** es el linter más popular para Ruby.

### **¿Por qué usar CI/CD?**
1. **Calidad**: Detecta errores antes de que lleguen a producción
2. **Consistencia**: Todo el equipo sigue las mismas reglas
3. **Confianza**: Sabes que el código funciona antes de hacer merge
4. **Velocidad**: Automatiza tareas repetitivas
5. **Documentación**: Los workflows documentan el proceso

### **¿Qué es un Pipeline?**
Es la secuencia de pasos automatizados que se ejecutan:
```
Código → Checkout → Instalar → Lint → Test → Deploy
```

En este proyecto:
```
Push → GitHub Actions → Lint (RuboCop) → Test → ✅/❌
```

---

## Resumen de Archivos

| Archivo | Propósito |
|---------|-----------|
| `suma.rb` | Programa principal sin errores |
| `ejemplo_con_error.rb` | Ejemplo con errores para demostrar el linter |
| `Gemfile` | Define las dependencias (RuboCop) |
| `.rubocop.yml` | Configuración del linter |
| `.github/workflows/ci.yml` | Define el workflow de CI/CD |
| `README.md` | Documentación del proyecto |
| `CONFIGURACION_GITHUB.md` | Guía para configurar protección de rama |
| `EXPLICACION_COMPLETA.md` | Este archivo (explicación detallada) |

---

## Casos de Uso Reales

### **En un equipo de desarrollo:**
1. Desarrollador crea una rama: `feature/nueva-funcionalidad`
2. Escribe código y hace commit
3. Crea Pull Request a `main`
4. GitHub Actions ejecuta automáticamente:
   - Linter verifica el estilo
   - Tests verifican que no se rompió nada
5. Si todo pasa ✅, el equipo puede revisar el código
6. Si algo falla ❌, el desarrollador debe corregir
7. Una vez aprobado, se hace merge a `main`

### **Beneficios:**
- Evita código de mala calidad en `main`
- Mejora la calidad del código del equipo
- Ahorra tiempo en revisiones de código
- Automatiza tareas repetitivas

---

## Troubleshooting (Solución de Problemas)

### **Problema: Bundle install falla con permisos**
```bash
# Solución: Instalar localmente
bundle install --path vendor/bundle
```

### **Problema: Ruby no está instalado**
```bash
# Solución: Instalar Ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler
```

### **Problema: El workflow no se ejecuta**
- Verifica que el archivo esté en `.github/workflows/`
- Verifica que sea un archivo `.yml` válido
- Verifica que hayas hecho push a una rama configurada (`main`, `master`, `develop`)

### **Problema: RuboCop encuentra demasiados errores**
```bash
# Auto-corregir lo que se pueda
bundle exec rubocop -a

# Ver solo los errores más importantes
bundle exec rubocop --format simple
```

---

## Recursos Adicionales

- **GitHub Actions Docs**: https://docs.github.com/en/actions
- **RuboCop Docs**: https://docs.rubocop.org/
- **Ruby Style Guide**: https://rubystyle.guide/
- **CI/CD Best Practices**: https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment

---

## Checklist de Verificación

- [ ] Ruby instalado (`ruby -v`)
- [ ] Bundler instalado (`bundle -v`)
- [ ] Dependencias instaladas (`bundle install`)
- [ ] Programa ejecuta sin errores (`ruby suma.rb`)
- [ ] Linter pasa en código limpio (`bundle exec rubocop suma.rb`)
- [ ] Linter detecta errores (`bundle exec rubocop ejemplo_con_error.rb`)
- [ ] Código subido a GitHub (`git push`)
- [ ] Workflow ejecutándose en GitHub Actions
- [ ] Protección de rama configurada (opcional pero recomendado)

---

**¡Proyecto completo y funcionando!**

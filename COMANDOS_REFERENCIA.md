# Referencia Rápida de Comandos

## Instalación y Setup

### Instalar Ruby y Bundler (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install -y ruby-full ruby-bundler
```

### Verificar instalación
```bash
ruby -v
bundle -v
```

### Clonar el repositorio
```bash
git clone git@github.com:illuminaki/ci-cd-QA.git
cd ci-cd-QA
```

### Instalar dependencias del proyecto
```bash
# Opción 1: Instalación local (recomendado)
bundle install --path vendor/bundle

# Opción 2: Instalación global (requiere permisos)
bundle install
```

---

## Ejecutar el Programa

### Ejecutar el programa principal
```bash
ruby suma.rb
```

### Dar permisos de ejecución y ejecutar
```bash
chmod +x suma.rb
./suma.rb
```

### Verificar sintaxis sin ejecutar
```bash
ruby -c suma.rb
```

---

## Linter (RuboCop)

### Ver todos los errores
```bash
bundle exec rubocop
```

### Ver errores de un archivo específico
```bash
bundle exec rubocop suma.rb
bundle exec rubocop ejemplo_con_error.rb
```

### Ver solo archivos con errores
```bash
bundle exec rubocop --format offenses
```

### Ver errores en formato simple
```bash
bundle exec rubocop --format simple
```

### Auto-corregir errores seguros
```bash
bundle exec rubocop -a
```

### Auto-corregir todos los errores (incluso inseguros)
```bash
bundle exec rubocop -A
```

### Ver solo errores críticos
```bash
bundle exec rubocop --only Layout,Lint
```

### Ignorar un archivo específico
```bash
bundle exec rubocop --except-cops Style/Documentation
```

### Generar archivo de configuración
```bash
bundle exec rubocop --auto-gen-config
```

---

## Git - Comandos Básicos

### Ver estado del repositorio
```bash
git status
```

### Ver historial de commits
```bash
git log --oneline
git log --oneline -5  # Últimos 5 commits
git log --graph --oneline --all  # Vista gráfica
```

### Ver diferencias
```bash
git diff  # Cambios no staged
git diff --staged  # Cambios staged
git diff HEAD  # Todos los cambios
```

### Ver ramas
```bash
git branch  # Ramas locales
git branch -a  # Todas las ramas (locales y remotas)
git branch -v  # Con último commit
```

### Ver remotos
```bash
git remote -v
```

---

## Git - Trabajar con Ramas

### Crear nueva rama
```bash
git checkout -b nombre-de-rama
```

### Cambiar de rama
```bash
git checkout nombre-de-rama
git switch nombre-de-rama  # Alternativa moderna
```

### Crear rama desde un commit específico
```bash
git checkout -b nueva-rama abc123
```

### Eliminar rama local
```bash
git branch -d nombre-de-rama  # Solo si está mergeada
git branch -D nombre-de-rama  # Forzar eliminación
```

### Eliminar rama remota
```bash
git push origin --delete nombre-de-rama
```

---

## Git - Commits y Push

### Agregar archivos al staging
```bash
git add .  # Todos los archivos
git add archivo.rb  # Archivo específico
git add *.rb  # Todos los archivos .rb
git add -p  # Agregar por partes (interactivo)
```

### Hacer commit
```bash
git commit -m "Mensaje descriptivo"
git commit -am "Mensaje"  # Add + commit (solo archivos tracked)
```

### Modificar el último commit
```bash
git commit --amend -m "Nuevo mensaje"
git commit --amend --no-edit  # Sin cambiar mensaje
```

### Push a GitHub
```bash
git push origin main
git push origin nombre-de-rama
git push -u origin nombre-de-rama  # Primera vez (set upstream)
git push --force  # Forzar (¡cuidado!)
```

---

## Git - Actualizar y Sincronizar

### Actualizar desde remoto
```bash
git pull origin main
git pull --rebase origin main  # Con rebase
```

### Traer cambios sin mergear
```bash
git fetch origin
```

### Ver cambios en remoto
```bash
git fetch origin
git log origin/main
```

### Sincronizar rama con main
```bash
git checkout mi-rama
git merge main
# O con rebase:
git rebase main
```

---

## Git - Probar el CI/CD

### Flujo completo para probar CI/CD con errores
```bash
# 1. Crear rama de prueba
git checkout -b test-linter-error

# 2. Modificar archivo con errores
# (editar ejemplo_con_error.rb)

# 3. Commit y push
git add ejemplo_con_error.rb
git commit -m "Agregar errores de linter para prueba"
git push origin test-linter-error

# 4. Ir a GitHub y crear Pull Request
# Verás que el CI/CD falla ❌

# 5. Corregir errores
bundle exec rubocop -a ejemplo_con_error.rb

# 6. Commit de correcciones
git add ejemplo_con_error.rb
git commit -m "Corregir errores de linter"
git push origin test-linter-error

# Ahora el CI/CD pasa ✅
```

### Flujo para código limpio
```bash
# 1. Crear rama
git checkout -b feature/nueva-funcionalidad

# 2. Escribir código limpio
# (editar archivos)

# 3. Verificar con linter ANTES de commit
bundle exec rubocop

# 4. Si pasa, hacer commit
git add .
git commit -m "Agregar nueva funcionalidad"
git push origin feature/nueva-funcionalidad

# 5. Crear Pull Request en GitHub
# El CI/CD pasará ✅
```

---

## Git - Inspección y Debugging

### Ver quién modificó cada línea
```bash
git blame archivo.rb
```

### Ver historial de un archivo
```bash
git log --follow archivo.rb
git log -p archivo.rb  # Con diferencias
```

### Ver cambios de un commit específico
```bash
git show abc123
```

### Buscar en el historial
```bash
git log --grep="palabra"  # Buscar en mensajes
git log -S"código"  # Buscar en código
```

### Ver archivos en un commit
```bash
git show abc123 --name-only
```

---

## Git - Deshacer Cambios

### Descartar cambios no staged
```bash
git checkout -- archivo.rb  # Archivo específico
git checkout -- .  # Todos los archivos
git restore archivo.rb  # Alternativa moderna
```

### Deshacer staging (unstage)
```bash
git reset HEAD archivo.rb
git restore --staged archivo.rb  # Alternativa moderna
```

### Deshacer último commit (mantener cambios)
```bash
git reset --soft HEAD~1
```

### Deshacer último commit (descartar cambios)
```bash
git reset --hard HEAD~1  # ¡CUIDADO! Pérdida de datos
```

### Revertir un commit (crear nuevo commit)
```bash
git revert abc123
```

---

## Ver Estado del CI/CD

### Ver workflows en GitHub (navegador)
```
https://github.com/illuminaki/ci-cd-QA/actions
```

### Ver estado del último workflow (CLI con gh)
```bash
# Instalar GitHub CLI primero
sudo apt install gh

# Ver workflows
gh run list
gh run view
gh run watch  # Ver en tiempo real
```

---

## Limpieza y Mantenimiento

### Limpiar archivos no tracked
```bash
git clean -n  # Ver qué se eliminará (dry-run)
git clean -f  # Eliminar archivos
git clean -fd  # Eliminar archivos y directorios
```

### Limpiar vendor/bundle
```bash
rm -rf vendor/bundle
bundle install --path vendor/bundle
```

### Actualizar dependencias
```bash
bundle update
```

### Ver dependencias instaladas
```bash
bundle list
```

---

## Configuración de Git

### Configurar usuario (local al proyecto)
```bash
git config user.name "Tu Nombre"
git config user.email "tu@email.com"
```

### Configurar usuario (global)
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### Ver configuración
```bash
git config --list
git config user.name
git config user.email
```

### Configurar editor
```bash
git config --global core.editor "nano"
git config --global core.editor "vim"
```

---

## Comandos de Verificación Rápida

### Verificar todo antes de commit
```bash
# 1. Ver estado
git status

# 2. Ver diferencias
git diff

# 3. Ejecutar linter
bundle exec rubocop

# 4. Verificar sintaxis
ruby -c suma.rb

# 5. Si todo está bien, commit
git add .
git commit -m "Mensaje"
git push
```

### Verificar después de pull
```bash
# 1. Pull cambios
git pull origin main

# 2. Instalar dependencias (por si hay nuevas)
bundle install

# 3. Ejecutar linter
bundle exec rubocop

# 4. Ejecutar programa
ruby suma.rb
```

---

## Comandos de Emergencia

### Recuperar commit eliminado
```bash
git reflog  # Ver historial de referencias
git checkout abc123  # Recuperar commit
```

### Abortar merge con conflictos
```bash
git merge --abort
```

### Abortar rebase
```bash
git rebase --abort
```

### Limpiar todo y volver a estado limpio
```bash
git reset --hard HEAD
git clean -fd
```

### Sincronizar con remoto (sobrescribir local)
```bash
git fetch origin
git reset --hard origin/main  # ¡CUIDADO! Pérdida de cambios locales
```

---

## Checklist de Comandos Diarios

### Al empezar el día
```bash
git pull origin main
bundle install
```

### Antes de cada commit
```bash
git status
bundle exec rubocop
git diff
```

### Al terminar una feature
```bash
bundle exec rubocop
git add .
git commit -m "Descripción clara"
git push origin mi-rama
# Crear Pull Request en GitHub
```

---

## Enlaces Útiles

- **Repositorio**: https://github.com/illuminaki/ci-cd-QA
- **Actions**: https://github.com/illuminaki/ci-cd-QA/actions
- **Settings**: https://github.com/illuminaki/ci-cd-QA/settings
- **Branches**: https://github.com/illuminaki/ci-cd-QA/settings/branches

---

## Tips y Trucos

### Alias útiles de Git
```bash
# Agregar a ~/.bashrc o ~/.zshrc
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
```

### Alias de RuboCop
```bash
alias rc='bundle exec rubocop'
alias rca='bundle exec rubocop -a'
alias rcA='bundle exec rubocop -A'
```

### Recargar aliases
```bash
source ~/.bashrc
# o
source ~/.zshrc
```

---

**¡Guarda este archivo como referencia rápida!**

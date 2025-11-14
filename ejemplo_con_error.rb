#!/usr/bin/env ruby
# frozen_string_literal: true

# Este archivo tiene errores de estilo intencionales para demostrar el linter

def suma_con_errores(a, b) # Falta espacio después de las comas
  resultado = a + b # Falta espacios alrededor de los operadores
  puts "El resultado es: #{resultado}"
  resultado # Return innecesario
end

# Línea muy larga que excede el límite de 120 caracteres establecido en la configuración de RuboCop para este proyecto
suma_con_errores(5, 10)

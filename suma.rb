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

# Ejecutar el programa si se llama directamente
main if __FILE__ == $PROGRAM_NAME

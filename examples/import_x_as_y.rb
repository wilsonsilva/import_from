# frozen_string_literal: true

require '../lib/import_from'

# Simple import
import 'money', as: 'Plata'

raise 'Global namespace pollution. Expected: Money not defined. Plata defined. Got: Money defined.' if defined?(Money)

puts "import 'money', as: 'Plata'"
puts "Plata::VERSION => #{Plata::VERSION}"

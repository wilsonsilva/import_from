# frozen_string_literal: true

require '../lib/import_from'

# Import with alias
import 'money-7.0.2', as: 'Plata'

raise 'Global namespace pollution. Expected: Money not defined. Plata defined. Got: Money defined.' if defined?(Money)

puts "import 'money-7.0.2', as: 'Plata'"
puts "Plata::VERSION => #{Plata::VERSION}"

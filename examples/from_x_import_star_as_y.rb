# frozen_string_literal: true

require '../lib/import_from'

# Simple import with alias
from 'money', import: '*', as: 'Plata'

raise 'Global namespace pollution. Expected: Money not defined. Plata defined. Got: Money defined.' if defined?(Money)

puts "from 'money', import: '*', as: 'Plata'"
puts "Plata::VERSION => #{Plata::VERSION}"

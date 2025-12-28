# frozen_string_literal: true

require '../lib/import_from'

# Simple import
from 'money', import: '*'

raise 'Expected: Money defined. Got: Money undefined.' unless defined?(Money)

puts "from 'money', import: '*'"
puts "Money::VERSION => #{Money::VERSION}"

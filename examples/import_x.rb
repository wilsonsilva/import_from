# frozen_string_literal: true

require '../lib/import_from'

# Simple import
import 'money'

raise 'Expected: Money defined. Got: Money undefined.' unless defined?(Money)

puts "import 'money'"
puts "Money::VERSION => #{Money::VERSION}"

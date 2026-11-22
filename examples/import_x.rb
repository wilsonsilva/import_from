# frozen_string_literal: true

require 'rubygems'
require '../lib/import_from'

# Simple import
Money = import 'money', as: 'Money'

# raise 'Expected: Money defined. Got: Money undefined.' unless defined?(Money)

puts "import 'money'"
puts "Money::VERSION => #{Money::VERSION}"

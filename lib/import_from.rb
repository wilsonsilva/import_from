# frozen_string_literal: true

require_relative 'import_from/version'
require_relative 'import_from/core_ext/kernel'

ENV['RUBY_BOX'] = '1' unless Ruby::Box.enabled?

# Entry point
module ImportFrom
end

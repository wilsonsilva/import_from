# frozen_string_literal: true

# Kernel extensions providing Python-like import syntax for Ruby.
module Kernel
  # Imports constants from a gem into an isolated Ruby::Box namespace
  #
  # This method creates a new isolated Ruby::Box, loads the specified gem
  # within that box, and extracts requested constants into the Object namespace.
  # This prevents namespace collisions and allows multiple versions of gems
  # to coexist.
  #
  # @api public
  #
  # @example Import specific classes from a gem
  #   from 'active_support', import: 'HashWithIndifferentAccess'
  #   HashWithIndifferentAccess.new # => Available in global namespace
  #
  # @example Import multiple constants
  #   from 'my_gem', import: ['User', 'Post']
  #
  # @example Import all constants with wildcard and alias the box
  #   from 'my_gem', import: '*', as: :MyGem
  #   MyGem.const_get('User') # => Access via box
  #
  # @example Import from relative path
  #   from './lib/my_module', import: 'MyClass'
  #
  # @param gem_name [String] The name of the gem to load, or a relative path starting with '.'
  # @param import [String, Array<String>] The constant name(s) to import, or '*' for wildcard import
  # @param as [Symbol, String, nil] Optional alias name to assign the Ruby::Box instance to
  #
  # @return [Object, Array<Object>, Ruby::Box] Returns the imported constant, an array of constants if multiple, or the
  #   Ruby::Box if wildcard import
  #
  # @raise [NameError] If the requested constant does not exist in the gem
  #
  # @raise [LoadError] If the gem cannot be loaded
  #
  def from(gem_name, import:, as: nil)
    # Create a new isolated box
    box = Ruby::Box.new

    puts box.load_path

    # Load the library into the box
    # If it's a relative path, use require_relative, otherwise require
    if gem_name.start_with?('.')
      box.require_relative(gem_name)
    else
      # box.eval <<-EVAL
      #   begin
      #     gem_original_require('#{gem_name}')
      #   rescue LoadError => load_error
      #     if load_error.path == #{gem_name} && RUBYGEMS_ACTIVATION_MONITOR.synchronize { Gem.try_activate(#{gem_name}) }
      #       return gem_original_require(#{gem_name})
      #     end
      #
      #     raise load_error
      #   end
      # EVAL

      puts box.eval(<<~RUBY)
        require "#{gem_name}"

        puts Money::VERSION
      RUBY

      # This does not work
      # puts box.require(gem_name)
    end

    # if as
    #   puts "Aliasing box as #{as}"
    #   Object.const_set(as, box)
    # else
    #   puts "Aliasing box as #{gem_name.capitalize}"
    #   Object.const_set(gem_name.capitalize, box)
    # end

    if import == '*'
      puts 'Importing all constants from gem'
      return box
    end

    # # Extract the requested constants
    # targets = Array(import)
    # results = targets.map do |const_name|
    #   # Fetch the constant from the box namespace
    #   klass = box.const_get(const_name)
    #
    #   # Inject the constant into the caller's namespace (Object by default)
    #   # This makes it look like it was imported globally/locally
    #   Object.const_set(const_name, klass)
    #   klass
    # end
    #
    # results.size == 1 ? results.first : results

    box
  end

  # Imports constants with Python-style syntax supporting flexible parameter order
  #
  # This method provides a more Pythonic interface to the +from+ method, allowing
  # either "import 'gem_name'" to import entire namespaces or "import 'Class', from: 'gem_name'"
  # to import specific constants.
  #
  # @api public
  #
  # @example Import entire gem namespace
  #   import 'active_support', as: :AS
  #   AS.const_get('HashWithIndifferentAccess')
  #
  # @example Import specific constants from a gem
  #   import ['User', 'Post'], from: 'my_gem'
  #
  # @example Import with alias
  #   import 'MyClass', from: 'my_gem', as: :MyAlias
  #
  # @param imports [String, Array<String>] The gem name (when from: is nil) or constant name(s) to import
  # @param from [String, nil] The gem name to import from, or nil to import entire namespace
  # @param as [Symbol, String, nil] Optional alias name for the imported constant or Ruby::Box
  #
  # @return [Object, Array<Object>, Ruby::Box] Returns the imported constant(s) or Ruby::Box instance
  #
  # @raise [NameError] If the requested constant does not exist in the gem
  #
  # @raise [LoadError] If the gem cannot be loaded
  #
  def import(imports, from: nil, as: nil)
    if from.nil?
      from(imports, import: '*', as: as)
    else
      from(from, import: imports, as: as)
    end
  end
end

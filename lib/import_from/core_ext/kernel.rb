# frozen_string_literal: true

# Kernel extensions
module Kernel
  # Usage: from 'my_lib', import: 'User', 'Post'
  # Returns the imported classes (or an array if multiple)
  def from(gem_name, import:, as: nil)
    # Create a new isolated box
    box = Ruby::Box.new

    require 'bundler/setup'

    # Copy the load path into the box
    $LOAD_PATH.each do |path|
      # $LOAD_PATH << path
      box.eval("$LOAD_PATH << #{path.inspect}")
    end

    # Load the library into the box
    # If it's a relative path, use require_relative, otherwise require
    if gem_name.start_with?('.')
      box.require_relative(gem_name)
    else
      require gem_name
      box.require(gem_name)
    end

    Object.const_set(as, box) if as

    return box if import == '*'

    # Extract the requested constants
    targets = Array(import)
    results = targets.map do |const_name|
      # Fetch the constant from the box namespace
      klass = box.const_get(const_name)

      # Inject the constant into the caller's namespace (Object by default)
      # This makes it look like it was imported globally/locally
      Object.const_set(const_name, klass)
      klass
    end

    results.size == 1 ? results.first : results
  end

  def import(imports, from: nil, as: nil)
    if from.nil?
      from(imports, import: '*', as: as)
    else
      from(from, import: imports, as: as)
    end
  end
end

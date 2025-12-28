# frozen_string_literal: true

require_relative 'lib/import_from/version'

Gem::Specification.new do |spec|
  spec.name = 'import_from'
  spec.version = ImportFrom::VERSION
  spec.authors = ['Wilson Silva']
  spec.email = ['wilson.dsigns@gmail.com']

  spec.summary = 'Provides a Python-like syntax for importing modules from Ruby gems and files.'
  spec.description = 'A Ruby gem that provides a Python-like syntax for importing modules from Ruby gems and files, making it easier to manage dependencies and imports in your Ruby applications.'
  spec.homepage = 'https://github.com/wilsonsilva/import_from'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 4.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/wilsonsilva/import_from'
  spec.metadata['changelog_uri'] = 'https://github.com/wilsonsilva/import_from/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ spec/ .git .github Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end

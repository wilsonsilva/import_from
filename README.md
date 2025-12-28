# ImportFrom

<div align="center">

[![Gem Version](https://badge.fury.io/rb/import_from.svg)](https://badge.fury.io/rb/import_from)
![Build](https://github.com/wilsonsilva/import_from/actions/workflows/main.yml/badge.svg)
[![Maintainability](https://qlty.sh/gh/wilsonsilva/projects/import_from/maintainability.svg)](https://qlty.sh/gh/wilsonsilva/projects/import_from)
[![Code Coverage](https://qlty.sh/gh/wilsonsilva/projects/import_from/coverage.svg)](https://qlty.sh/gh/wilsonsilva/projects/import_from)

</div>

Provides a Python-like syntax for importing modules and from Ruby gems and files.

## Table of contents

- [Key features](#-key-features)
- [Installation](#-installation)
- [Quickstart](#-quickstart)
- [Examples](#-examples)
- [Documentation](#-documentation)
- [Development](#-development)
  * [Type checking](#-type-checking)
- [Contributing](#-contributing)
- [License](#-license)
- [Code of Conduct](#-code-of-conduct)

## 🔑 Key features

- **TODO**: TODO

## 📦 Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add import_from

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install import_from

## ⚡️ Quickstart

Create a file called `main.rb` and run it with `RUBY_BOX=1 ruby -W:no-experimental main.rb`:

```ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'import_from'

# Simple import
import 'money'

# Import with alias
import 'money', as: 'Mon'
```

## 📚 Documentation

- [YARD documentation](https://rubydoc.info/gems/import_from)

## 📜 Examples

All examples can be found [here](https://github.com/wilsonsilva/import_from/blob/main/examples/README.md)

## 🔨 Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

The health and maintainability of the codebase is ensured through a set of
Rake tasks to test, lint and audit the gem for security vulnerabilities and documentation:

```
rake build                    # Build import_from.gem into the pkg directory
rake build:checksum           # Generate SHA512 checksum of import_from.gem into the checksums directory
rake bundle:audit:check       # Checks the Gemfile.lock for insecure dependencies
rake bundle:audit:update      # Updates the bundler-audit vulnerability database
rake clean                    # Remove any temporary products
rake clobber                  # Remove any generated files
rake coverage                 # Run spec with coverage
rake install                  # Build and install import_from.gem into system gems
rake install:local            # Build and install import_from.gem into system gems without network access
rake qa                       # Test, lint and perform security and documentation audits
rake release[remote]          # Create tag and build and push import_from.gem to rubygems.org
rake rubocop                  # Run RuboCop
rake rubocop:autocorrect      # Autocorrect RuboCop offenses (only when it's safe)
rake rubocop:autocorrect_all  # Autocorrect RuboCop offenses (safe and unsafe)
rake spec                     # Run RSpec code examples
rake verify_measurements      # Verify that yardstick coverage is at least 100%
rake yard                     # Generate YARD Documentation
rake yard:format              # Format YARD documentation
rake yard:junk                # Check the junk in your YARD Documentation
rake yardstick_measure        # Measure docs in lib/**/*.rb with yardstick
```

### 🧪 Type checking

This gem leverages [RBS](https://github.com/ruby/rbs), a language to describe the structure of Ruby programs. It is
used to provide type checking and autocompletion in your editor. Run `bundle exec typeprof FILENAME` to generate
an RBS definition for the given Ruby file. And validate all definitions using [Steep](https://github.com/soutaro/steep)
with the command `bundle exec steep check`.

## 🐞 Issues & Bugs

If you find any issues or bugs, please report them [here](https://github.com/wilsonsilva/import_from/issues), I will be happy
to have a look at them and fix them as soon as possible.

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/import_from.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere
to the [code of conduct](https://github.com/wilsonsilva/import_from/blob/main/CODE_OF_CONDUCT.md).

## 📜 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 👔 Code of Conduct

Everyone interacting in the ImportFrom Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected
to follow the [code of conduct](https://github.com/wilsonsilva/import_from/blob/main/CODE_OF_CONDUCT.md).

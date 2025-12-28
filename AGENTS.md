# AGENTS.md

This file provides guidance to WARP (warp.dev), Gemini CLI and Claude Code when working with code in this repository.

## Project Overview

`import_from` is a Ruby gem that provides Python-like import syntax for Ruby modules and classes. It leverages Ruby::Box (Ruby 4.0+ feature) to create isolated namespaces, preventing conflicts between different versions of gems and their dependencies.

**Critical requirement**: All code execution requires Ruby 4.0+ with `RUBY_BOX=1` environment variable set.

## Common Commands

### Running Code
All Ruby code must be executed with Ruby::Box enabled:
```bash
RUBY_BOX=1 ruby -W:no-experimental <file.rb>
```

The `-W:no-experimental` flag suppresses the experimental feature warning.

### Development Setup
```bash
bin/setup                      # Install dependencies
bin/console                    # Interactive console with gem loaded
```

### Testing
```bash
bundle exec rake spec          # Run all tests
bundle exec rake coverage      # Run tests with coverage report
```

### Code Quality
```bash
bundle exec rake               # Run default task (spec + rubocop)
bundle exec rake qa            # Full quality audit (rspec, rubocop, yard:junk, verify_measurements, bundle:audit)
bundle exec rake rubocop       # Run RuboCop linter
bundle exec rake rubocop:autocorrect      # Auto-fix safe RuboCop offenses
bundle exec rake rubocop:autocorrect_all  # Auto-fix all RuboCop offenses
```

### Type Checking
```bash
bundle exec steep check        # Validate RBS type definitions
bundle exec typeprof <file>    # Generate RBS definition for a Ruby file
```

### Documentation
```bash
bundle exec rake yard          # Generate YARD documentation
bundle exec rake yard:format   # Format YARD documentation tags
bundle exec rake yard:junk     # Check for documentation issues
bundle exec rake yardstick_measure        # Measure documentation coverage
bundle exec rake verify_measurements      # Verify 100% documentation coverage
```

### Security & Dependencies
```bash
bundle exec rake bundle:audit:check   # Check for security vulnerabilities
bundle exec rake bundle:audit:update  # Update vulnerability database
```

### Release
```bash
bundle exec rake release       # Create tag, build gem, push to rubygems.org
```

## Architecture

### Core Components

**Ruby::Box Integration** (`lib/import_from.rb`)
- Entry point that enforces `RUBY_BOX=1` is set
- Raises an error immediately if Ruby::Box is not enabled
- Loads the Kernel extensions that provide import syntax

**Kernel Extensions** (`lib/import_from/core_ext/kernel.rb`)
- Defines two main methods: `from()` and `import()`
- Creates isolated Ruby::Box instances to load gems/modules
- Handles constant extraction and namespace injection

### How It Works

The gem extends Ruby's `Kernel` module with two methods that mimic Python's import patterns:

1. **`from(gem_name, import:, as:)`** - Import specific constants from a gem
  - Creates a new isolated Ruby::Box
  - Copies `$LOAD_PATH` into the box
  - Requires the gem inside the box
  - Extracts requested constants and injects them into `Object`
  - Supports wildcard imports with `import: '*'`

2. **`import(imports, from:, as:)`** - Flexible import with optional aliasing
  - Wrapper around `from()` with more Pythonic parameter order
  - When `from:` is nil, imports entire gem namespace
  - Allows aliasing the box itself with `as:`

### Ruby::Box Isolation

Ruby::Box (experimental Ruby 4.0 feature) provides process-level namespace isolation:
- Each box has its own set of constants, class variables, and global variables
- Built-in classes can be monkey-patched within a box without affecting other boxes
- Changes made in one box don't leak to other boxes or the main namespace
- All code in a single `.rb` file runs in the same box

Key limitations to be aware of:
- Experimental feature requiring `RUBY_BOX=1` at Ruby process startup
- Native extension installation may fail (stack level too deep)
- `require 'active_support/core_ext'` may fail under Ruby::Box
- Built-in methods won't see monkey-patched methods from user boxes

## Code Style Guidelines

### RuboCop Configuration
- Target Ruby version: 4.0
- String literals: Single quotes (enforced)
- String interpolation: Double quotes (enforced)
- Line length: 120 characters max
- Most Metrics cops disabled (AbcSize, BlockLength, CyclomaticComplexity, MethodLength, etc.)

### Documentation Standards
- YARD documentation required for all public APIs
- Project enforces 100% documentation coverage via yardstick
- Use `bundle exec rake yard:format` to auto-format YARD tags
- YARD tags are grouped (e.g., `@param` tags together with no blank lines between them)
- Blank lines separate different tag types

## Testing Approach

### Framework
- RSpec 3.13+
- Monkey patching disabled (`config.disable_monkey_patching!`)
- Expect syntax only (no `should`)
- Example status persistence enabled (`.rspec_status`)

### Running Single Tests
```bash
bundle exec rspec spec/specific_spec.rb
bundle exec rspec spec/specific_spec.rb:42  # Run specific line
```

### Coverage
SimpleCov is configured to generate coverage reports. Run `bundle exec rake coverage` to generate and automatically open the HTML report.

## Project Constraints

### Ruby Version
Requires Ruby 4.0.0+ due to dependency on Ruby::Box. This is an experimental feature and may have breaking changes.

### Runtime Environment
Must run with `RUBY_BOX=1` environment variable set at process startup. Setting it after Ruby starts has no effect.

### Known Issues with Ruby::Box
- Stack overflow issues when installing native extensions
- Compatibility problems with Active Support's core extensions
- Built-in Ruby methods may not call overridden methods in boxes
- No way to expose top-level methods defined in boxes to other boxes

```ruby

# Import multiple modules
import 'http', 'money', 'rails'

# Import multiple with individual aliases
import 'temp', as: 'Temporary'
import 'sys', as: 'System'

# Import from package
from 'money', import: 'Currency'

# Import from package with alias
from 'money', import: 'Currency', as: 'C'

# Import multiple items from module
from 'money', import: %w[Counter Currency]

# Import multiple items with aliases
from 'money', import: { Currency: 'Cur', Bank: 'Banco' }

# Import all (wildcard)
from 'money', import: '*'

# Import nested module
import 'money/currency/loader' # most ruby-like syntax

# Import nested module with alias
import 'money/currency/loader', as: 'CurrencyLoader'

# From nested module import item
from 'money/currency', import: 'Loader'

# From nested module import with alias
from 'money/currency', import: 'Loader', as: 'L'

# Multiple from nested
from 'money/currency', import: %w[Heuristics Loader]

# Deep nesting with aliases
from 'money/currency', import: { Heuristics: 'H', Loader: 'L' }
```

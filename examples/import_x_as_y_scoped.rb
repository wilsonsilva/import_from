# frozen_string_literal: true

require '../lib/import_from'

# Scoped import (block-based)
import 'money', as: 'Mon' do
  # Mon only available in this block

  # 10.00 USD
  money = Mon.from_cents(1000, 'USD')
  money.cents     #=> 1000
  money.currency  #=> Currency.new("USD")
end

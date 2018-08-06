# Setup Exchange Rates for Money gem
require 'money/bank/open_exchange_rates_bank'

open_exchange = Money::Bank::OpenExchangeRatesBank.new
open_exchange.app_id = 'abb47bbd898442878f65ba7b133ae713'

open_exchange.update_rates
open_exchange.ttl_in_seconds = 1.day.to_i

Money.default_bank = open_exchange

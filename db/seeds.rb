# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Add currencies (should move to operation Tasks)
currencies = [
  {code: 'USD',  symbol: '$',  name: 'United States Dollar'},
  {code: 'EUR',  symbol: '€',  name: 'Euro'},
  {code: 'GBP',  symbol: '£',  name: 'British Pound'},
  {code: 'AUD',  symbol: 'A$', name: 'Australian Dollar'},
  {code: 'CAD',  symbol: 'C$', name: 'Canadian Dollar'},
  {code: 'JPY',  symbol: '¥',  name: 'Japanese Yen'},
  {code: 'PLN',  symbol: 'zł', name: 'Polish Złoty'},
  {code: 'SGD',  symbol: 'S$', name: 'Singapore Dollar'},
  {code: 'RUB',  symbol: '₽',  name: 'Russian Ruble'},
  {code: 'HKD',  symbol: 'HK$', name: 'Hong Kong Dollar'}
].freeze

currencies.each do |currency|
  Currency.new(
    code: currency[:code],
    name: currency[:name],
    symbol: currency[:symbol]
  ).save
end

# Add crypto currencies
Tasks::SeedCryptoCurrencies.()

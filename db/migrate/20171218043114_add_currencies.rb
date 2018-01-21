class AddCurrencies < ActiveRecord::Migration[5.1]
  CURRENCIES = [
    {code: 'USD',  symbol: '$',  name: 'United States Dollar'},
    {code: 'AUD',  symbol: 'A$', name: 'Australian Dollar'},
    {code: 'CAD',  symbol: 'C$', name: 'Canadian Dollar'},
    {code: 'EUR',  symbol: '$',  name: 'Euro'},
    {code: 'GBP',  symbol: '£',  name: 'British Pound'},
  ].freeze

  def up
    CURRENCIES.each do |currency|
      Currency.new(
        code: currency[:code],
        name: currency[:name],
        symbol: currency[:symbol]
      ).save
    end
  end

  def down
    Currency.delete_all
  end
end

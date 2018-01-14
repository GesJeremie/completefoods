class AddCurrencies < ActiveRecord::Migration[5.1]
  CURRENCIES = [
    {symbol: 'USD',  name: 'United States Dollar'},
    {symbol: 'AUD',  name: 'Australian Dollar'},
    {symbol: 'CAD',  name: 'Canadian Dollar'},
    {symbol: 'EUR',  name: 'Euro'},
    {symbol: 'GBP',  name: 'British Pound'},
  ].freeze

  def up
    CURRENCIES.each do |currency|
      Currency.new(
        symbol: currency[:symbol],
        name: currency[:name]
      ).save
    end
  end

  def down
    Currency.delete_all
  end
end

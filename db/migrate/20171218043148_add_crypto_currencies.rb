class AddCryptoCurrencies < ActiveRecord::Migration[5.1]
  def up
    Tasks::SeedCryptoCurrencies.()
  end

  def down
    CryptoCurrency.delete_all
  end
end

class AddColumnMediaCryptoCurrencies < ActiveRecord::Migration[5.1]
  def up
    add_column :crypto_currencies, :media, :string
  end

  def down
    remove_column :crypto_currencies, :media, :string
  end
end

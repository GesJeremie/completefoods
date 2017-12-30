class CreateCryptoCurrencies < ActiveRecord::Migration[5.1]
  def up
    create_table :crypto_currencies do |t|
      t.string :symbol
      t.string :name

      t.timestamps
    end

    add_index :crypto_currencies, [:symbol], unique: true
  end

  def down
    drop_table :crypto_currencies
  end
end

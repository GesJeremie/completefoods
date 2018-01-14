class CreateFolioCryptoCurrencies < ActiveRecord::Migration[5.1]
  def up
    create_table :folio_crypto_currencies do |t|
      t.references :folio
      t.references :crypto_currency
      t.decimal :holding

      t.timestamps
    end
  end

  def down
    drop_table :folio_crypto_currencies
  end
end

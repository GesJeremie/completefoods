class CreateMarketExchanges < ActiveRecord::Migration[5.1]
  def up
    create_table :market_exchanges do |t|
      t.references :crypto_currency
      t.references :currency
      t.decimal :price

      t.timestamps
    end
  end

  def down
    drop_table :market_exchanges
  end
end

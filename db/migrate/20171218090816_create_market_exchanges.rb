class CreateMarketExchanges < ActiveRecord::Migration[5.1]
  def up
    create_table :market_exchanges do |t|
      t.references :crypto_currency
      t.references :currency
      t.string :price
      t.string :price_open_24_hours
      t.string :price_high_24_hours
      t.string :price_low_24_hours
      t.string :change_percentage_24_hours

      t.timestamps
    end
  end

  def down
    drop_table :market_exchanges
  end
end

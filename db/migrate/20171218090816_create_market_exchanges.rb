class CreateMarketExchanges < ActiveRecord::Migration[5.1]
  def up
    create_table :market_exchanges do |t|
      t.string :crypto_currency
      t.string :fiat_currency
      t.string :price

      t.timestamps
    end
  end

  def down
    drop_table :market_exchanges
  end
end

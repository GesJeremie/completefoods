class CreateProductPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :product_prices do |t|
      t.references :product
      t.references :currency
      t.decimal :per_serving_minimum_order
      t.decimal :per_serving_bulk_order

      t.timestamps
    end
  end
end

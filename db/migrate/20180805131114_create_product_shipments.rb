class CreateProductShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :product_shipments do |t|
        t.references :product
        t.boolean :rest_of_world
        t.boolean :united_states
        t.boolean :canada
        t.boolean :europe

        t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :brand
      t.string :name
      t.string :slug
      t.float :kcal_per_serving
      t.float :protein_per_serving
      t.float :carbs_per_serving
      t.float :fat_per_serving
      t.boolean :subscription_available
      t.boolean :discount_for_subscription
      t.boolean :shaker_free_first_order
      t.boolean :sample_pack_available
      t.integer :state, default: 0
      t.string :notes

      t.boolean :active
      t.timestamps
    end

    add_index :products, [:slug], unique: true
  end
end

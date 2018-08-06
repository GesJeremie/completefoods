class CreateProductAllergens < ActiveRecord::Migration[5.1]
  def change
    create_table :product_allergens do |t|
      t.references :product
      t.boolean :gluten
      t.boolean :lactose
      t.boolean :nut
      t.boolean :ogm
      t.boolean :soy

      t.timestamps
    end
  end
end

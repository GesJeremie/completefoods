class CreateProductDiets < ActiveRecord::Migration[5.1]
  def change
    create_table :product_diets do |t|
      t.references :product
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :ketogenic

      t.timestamps
    end
  end
end

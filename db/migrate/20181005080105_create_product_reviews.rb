class CreateProductReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :product_reviews do |t|
      t.references :product

      t.integer :score
      t.string :description
      t.string :ip

      t.timestamps
    end
  end
end

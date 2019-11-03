class CreateProductVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_votes do |t|
      t.references :product

      t.string :ip
      t.boolean :recommend
      t.string :reason
      t.boolean :active

      t.timestamps
    end
  end
end

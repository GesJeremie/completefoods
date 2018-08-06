class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.references :country
      t.string :name
      t.string :website
      t.string :facebook
    end
  end
end

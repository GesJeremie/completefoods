class AddDescriptionTableBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :description, :string
  end
end

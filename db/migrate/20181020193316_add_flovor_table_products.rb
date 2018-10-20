class AddFlovorTableProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :flavor, :integer, default: 0
  end
end

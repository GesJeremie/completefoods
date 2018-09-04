class RemoveShakerFreeFirstOrderAndSamplePackAvailableColumnsFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :shaker_free_first_order, :boolean
    remove_column :products, :sample_pack_available, :boolean
  end
end

class AddTimestampsTableBrands < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :brands, null: true

    Brand.all.each do |brand|
      brand.created_at = Time.now
      brand.updated_at = Time.now
      brand.save
    end

    change_column_null :brands, :created_at, false
    change_column_null :brands, :updated_at, false
  end
end

class DeleteProductReviews < ActiveRecord::Migration[5.2]
  def change
    drop_table :product_reviews
  end
end

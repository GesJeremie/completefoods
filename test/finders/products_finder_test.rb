# require 'test_helper'

# class ProductFinderTest < ActiveSupport::TestCase

#   def setup
#     5.times { create_product_matching_filters }
#     5.times { create_product_not_matching_filters }
#   end

#   test 'filters correctly' do
#     params = {
#       vegan: true,
#       united_states: true,
#       gluten_free: true,
#       lactose_free: true,
#       subscription_available: true
#     }

#     products = ProductResultsFinder.new(params).execute

#     assert products.length == 5

#     products.each do |product|
#       assert product.diet.vegan
#       assert product.shipment.united_states
#       assert product.subscription_available
#       assert_not product.allergen.gluten
#     end
#   end

#   test 'sorts correctly per kcal' do
#     products = ProductResultsFinder.new({ sort: :kcal_per_serving_lowest }).execute
#     assert products.first.kcal_per_serving <= products.last.kcal_per_serving

#     products = ProductResultsFinder.new({ sort: :kcal_per_serving_most }).execute
#     assert products.first.kcal_per_serving >= products.last.kcal_per_serving
#   end

#   test 'sorts correctly per fat' do
#     products = ProductResultsFinder.new({ sort: :fat_per_serving_lowest }).execute
#     assert products.first.fat_per_serving <= products.last.fat_per_serving

#     products = ProductResultsFinder.new({ sort: :fat_per_serving_most }).execute
#     assert products.first.fat_per_serving >= products.last.fat_per_serving
#   end

#   test 'sorts correctly per fat ratio' do
#     products = ProductResultsFinder.new({ sort: :fat_per_serving_ratio_lowest }).execute
#     assert products.first.fat_per_serving_ratio <= products.last.fat_per_serving_ratio

#     products = ProductResultsFinder.new({ sort: :fat_per_serving_ratio_most }).execute
#     assert products.first.fat_per_serving_ratio >= products.last.fat_per_serving_ratio
#   end

#   test 'sorts correctly per carbs' do
#     products = ProductResultsFinder.new({ sort: :carbs_per_serving_lowest }).execute
#     assert products.first.carbs_per_serving <= products.last.carbs_per_serving

#     products = ProductResultsFinder.new({ sort: :carbs_per_serving_most }).execute
#     assert products.first.carbs_per_serving >= products.last.carbs_per_serving
#   end

#   test 'sorts correctly per carbs ratio' do
#     products = ProductResultsFinder.new({ sort: :carbs_per_serving_ratio_lowest }).execute
#     assert products.first.carbs_per_serving_ratio <= products.last.carbs_per_serving_ratio

#     products = ProductResultsFinder.new({ sort: :carbs_per_serving_ratio_most }).execute
#     assert products.first.carbs_per_serving_ratio >= products.last.carbs_per_serving_ratio
#   end

#   test 'sorts correctly per protein' do
#     products = ProductResultsFinder.new({ sort: :protein_per_serving_lowest }).execute
#     assert products.first.protein_per_serving <= products.last.protein_per_serving

#     products = ProductResultsFinder.new({ sort: :protein_per_serving_per_serving_most }).execute
#     assert products.first.protein_per_serving >= products.last.protein_per_serving
#   end

#   test 'sorts correctly per protein ratio' do
#     products = ProductResultsFinder.new({ sort: :protein_per_serving_ratio_lowest }).execute
#     assert products.first.protein_per_serving_ratio <= products.last.protein_per_serving_ratio

#     products = ProductResultsFinder.new({ sort: :protein_per_serving_ratio_most }).execute
#     assert products.first.protein_per_serving_ratio >= products.last.protein_per_serving_ratio
#   end

#   test 'sorts correctly price per serving' do
#     products = ProductResultsFinder.new({ sort: :price_per_serving_minimum_order_cheapest }).execute
#     assert products.first.price.per_serving_minimum_order_in_currency('USD') <= products.last.price.per_serving_minimum_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_serving_minimum_order_most_expensive }).execute
#     assert products.first.price.per_serving_minimum_order_in_currency('USD') >= products.last.price.per_serving_minimum_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_serving_bulk_order_cheapest }).execute
#     assert products.first.price.per_serving_bulk_order_in_currency('USD') <= products.last.price.per_serving_bulk_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_serving_bulk_order_most_expensive }).execute
#     assert products.first.price.per_serving_bulk_order_in_currency('USD') >= products.last.price.per_serving_bulk_order_in_currency('USD')
#   end

#   test 'sorts correctly price per day' do
#     products = ProductResultsFinder.new({ sort: :price_per_day_minimum_order_cheapest }).execute
#     assert products.first.price.per_day_minimum_order_in_currency('USD') <= products.last.price.per_day_minimum_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_day_minimum_order_most_expensive }).execute
#     assert products.first.price.per_day_minimum_order_in_currency('USD') >= products.last.price.per_day_minimum_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_day_bulk_order_cheapest }).execute
#     assert products.first.price.per_day_bulk_order_in_currency('USD') <= products.last.price.per_day_bulk_order_in_currency('USD')

#     products = ProductResultsFinder.new({ sort: :price_per_day_bulk_order_most_expensive }).execute
#     assert products.first.price.per_day_bulk_order_in_currency('USD') >= products.last.price.per_day_bulk_order_in_currency('USD')
#   end

#   test 'narrows correctly' do
#     products = ProductResultsFinder.new({ sort: :price_per_day_minimum_order_cheapest, narrow: :kcal_per_serving_lowest }).execute

#     assert products.first.kcal_per_serving <= products.second.kcal_per_serving
#     assert products.first.kcal_per_serving <= products.last.kcal_per_serving
#     assert products.fourth.kcal_per_serving <= products.fifth.kcal_per_serving
#   end


#   private

#     def create_product_matching_filters
#       ProductFactory.new(
#         active: true,
#         subscription_available: true,
#         diet: ProductDietFactory.new(vegan: true).build,
#         shipment: ProductShipmentFactory.new(united_states: true).build,
#         allergen: ProductAllergenFactory.new(gluten: false, lactose: false).build
#       ).create
#     end

#     def create_product_not_matching_filters
#       ProductFactory.new(
#         active: true,
#         subscription_available: false
#       ).create
#     end

# end

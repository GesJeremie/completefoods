require 'test_helper'

class ProductFilterFinderTest < ActiveSupport::TestCase

  def setup
    5.times { create_product_matching_filters }
    5.times { create_product_not_matching_filters }
  end

  test 'filters_correctly' do
    params = ActionController::Parameters.new({
      vegan: true,
      united_states: true,
      gluten_free: true,
      lactose_free: true,
      subscription_available: true
    })

    products = ProductFilterFinder.new(params).execute

    assert products.length == 5

    products.each do |product|
      assert product.diet.vegan == true
      assert product.shipment.united_states == true
      assert product.allergen.gluten == false
      assert product.subscription_available == true
    end
  end

  private

    def create_product_matching_filters
      ProductFactory.new(
        active: true,
        subscription_available: true,
        diet: ProductDietFactory.new(vegan: true).build,
        shipment: ProductShipmentFactory.new(united_states: true).build,
        allergen: ProductAllergenFactory.new(gluten: false, lactose: false).build
      ).create
    end

    def create_product_not_matching_filters
      ProductFactory.new(
        active: true,
        subscription_available: false
      ).create
    end

end

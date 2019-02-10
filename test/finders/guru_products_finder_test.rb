require 'test_helper'

class GuruProductsFinderTest < ActiveSupport::TestCase
  include Factories::Support::Traits

  def finder(answers)
    GuruProductsFinder.new(answers).perform
  end

  def create_subscription_products
    create(:product, { subscription_available: false })
    create(:product, { subscription_available: true, discount_for_subscription: false })
    create(:product, { subscription_available: true, discount_for_subscription: true })
  end

  test 'allergen gluten' do
    create(:product, { allergen: trait_gluten })
    create(:product, { allergen: trait_gluten_free })

    products = finder({ gluten: 'on' })

    assert_equal 1, products.count
    assert_equal false, products.first.allergen.gluten?
  end

  test 'allergen lactose' do
    create(:product, { allergen: trait_lactose })
    create(:product, { allergen: trait_lactose_free })

    products = finder({ lactose: 'on' })

    assert_equal 1, products.count
    assert_equal false, products.first.allergen.lactose?
  end

  test 'country' do
    create(:product, { shipment: trait_shipment_united_states })
    create(:product, { shipment: trait_shipment_europe })

    products = finder({ country: 'united_states' })

    assert_equal 1, products.count
    assert_equal true, products.first.shipment.united_states?
  end

  test 'subscription yes_only_discount' do
    create_subscription_products

    products = finder({ subscription: 'yes_only_discount' })

    assert_equal 1, products.count
    assert_equal true, products.first.subscription_available?
    assert_equal true, products.first.discount_for_subscription?
  end

  test 'subscription yes' do
    create_subscription_products

    products = finder({ subscription: 'yes' })

    assert_equal 2, products.count
    assert_equal true, products.first.subscription_available?
  end

  test 'subscription no' do
    create_subscription_products

    products = finder({ subscription: 'no' })

    assert_equal 3, products.count
  end

  test 'sort' do
    create(:product, { kcal: 100, fat_per_serving: 20 })
    create(:product, { kcal: 100, fat_per_serving: 80 })

    products = finder({ sort: 'fat_lowest' })

    assert_equal 2, products.count
    assert products.first.fat_per_serving < products.second.fat_per_serving
  end
end

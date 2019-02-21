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

  test 'find by state' do
    create(:product, { state: :powder })
    create(:product, { state: :snack })
    create(:product, { state: :bottle })

    products_powder = finder({ powder: 'on' })
    products_snack = finder({ snack: 'on' })
    products_bottle = finder({ ready_to_drink: 'on' })

    products_powder_and_snack = finder({ powder: 'on', snack: 'on' })

    assert_equal 1, products_powder.count
    assert_equal 1, products_snack.count
    assert_equal 1, products_bottle.count
    assert_equal 2, products_powder_and_snack.count

    assert_equal 'powder', products_powder.first.state
    assert_equal 'snack', products_snack.first.state
    assert_equal 'bottle', products_bottle.first.state
    refute_equal 'bottle', products_powder_and_snack.first.state
    refute_equal 'bottle', products_powder_and_snack.second.state
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
    create(:product, { shipment: trait_shipment_not_united_states })

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
    create(:product, { kcal_per_serving: 100, fat_per_serving: 20 })
    create(:product, { kcal_per_serving: 100, fat_per_serving: 80 })

    products = finder({ sort: 'fat_lowest' })

    assert_equal 2, products.count
    assert products.first.fat_per_serving < products.second.fat_per_serving
  end
end

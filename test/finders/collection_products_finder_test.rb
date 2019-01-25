require 'test_helper'

class CollectionProductsFinderTest < ActiveSupport::TestCase

  def product_price(product)
    product.price.per_day_in_currency(type: :bulk_order, currency: :usd)
  end

  test 'cheapest' do
    20.times do
      create(:product)
    end

    collection = CollectionProductsFinder.new('cheapest').perform

    assert_equal 15, collection.count
    assert product_price(collection.first) <= product_price(collection.last)
  end

  test 'most expensive' do
    20.times do
      create(:product)
    end

    collection = CollectionProductsFinder.new('most-expensive').perform

    assert_equal 15, collection.count
    assert product_price(collection.first) >= product_price(collection.last)
  end

  test 'for athletes' do
    #assert false
  end

  test 'for vegans' do
    10.times do
      create(:product, { diet: build(:product_diet, { vegan: true }) })
    end

    10.times do
      create(:product, { diet: build(:product_diet, { vegan: false }) })
    end

    collection = CollectionProductsFinder.new('for-vegans').perform

    assert_equal 10, collection.count
    assert_equal true, collection.first.diet.vegan
  end

  test 'for vegetarians' do
    10.times do
      create(:product, { diet: build(:product_diet, { vegetarian: true }) })
    end

    10.times do
      create(:product, { diet: build(:product_diet, { vegetarian: false }) })
    end

    collection = CollectionProductsFinder.new('for-vegetarians').perform

    assert_equal 10, collection.count
    assert_equal true, collection.first.diet.vegetarian
  end
end

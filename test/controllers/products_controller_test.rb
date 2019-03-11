require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'display index' do
    get products_path
    assert_response :success
  end

  test 'display show' do
    product = create(:product)
    get product_path(product.slug)
    assert_response :success
  end
end

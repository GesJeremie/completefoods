class ProductFinder
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def execute
    products = Product.active
    products = ProductFilterFinder.new(products, params).execute
    products = ProductSortFinder.new(products, params).execute
    products = ProductNarrowFinder.new(products, params).execute
    products
  end
end

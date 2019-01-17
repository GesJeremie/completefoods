class ProductFinder
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def execute
    products = active_products
    products = ProductMadeInFinder.new(products, params).execute
    products = ProductFilterFinder.new(products, params).execute
    products = ProductSortFinder.new(products, params).execute
    products = ProductNarrowFinder.new(products, params).execute

    products
  end

  private

    def active_products
      Product.includes( { brand: [:country] }, { price: [:currency] }, { image_attachment: [:blob] } ).active.order(name: :asc)
    end
end

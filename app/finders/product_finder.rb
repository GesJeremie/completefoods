class ProductFinder
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def perform
    products = active_products
    products = ProductMadeInFinder.new(products, params).perform
    products = ProductFilterFinder.new(products, params).perform
    products = ProductSortFinder.new(products, params).perform
    products = ProductNarrowFinder.new(products, params).perform

    products
  end

  private

    def active_products
      Product.includes( { brand: [:country] }, { price: [:currency] }, { image_attachment: [:blob] } ).active.order(name: :asc)
    end
end

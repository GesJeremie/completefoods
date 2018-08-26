class ProductFinder
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def execute
    products = eager_load
    products = products.active
    products = ProductFilterFinder.new(products, params).execute
    products = ProductSortFinder.new(products, params).execute
    products = ProductNarrowFinder.new(products, params).execute
    products
  end

  private

    def eager_load
      Product
        .includes(brand: :country)
        .includes(image_attachment: :blob)
        .includes(price: :currency)
    end

end

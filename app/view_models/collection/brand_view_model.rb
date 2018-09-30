class Collection::BrandViewModel < CollectionViewModel

  def initialize(products:, brand:, current_currency:)
    super(products: products, current_currency: current_currency)
    @brand = brand
  end

  def description
    [
      description_brand,
      description_products_count,
      description_products_names,
      description_average_price
    ].compact.join(' ') << '.'
  end

  private

    def description_brand
      "#{@brand.name} based in #{@brand.country.name}"
    end

    def description_products_count
      if @products.count == 1
        "produces 1 soylent alternative"
      else
        "produces #{@products.count} soylent alternatives"
      end
    end
end

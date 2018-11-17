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
      "#{brand_link} based in #{brand_country_link}"
    end

    def brand_link
      "<a target='_blank' href='#{@brand.website}' class='link link--alt'>#{@brand.name}</a> "
    end

    def brand_country_link
      "<a class='link link--alt' href='/made-in-#{@brand.country.name.parameterize}'>#{@brand.country.name}</a>"
    end

    def description_products_count
      if @products.count == 1
        'produces 1 soylent alternative'
      else
        "produces #{@products.count} soylent alternatives"
      end
    end
end

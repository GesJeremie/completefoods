class Collection::MadeInViewModel < CollectionViewModel

  def initialize(products:, country:, current_currency:)
    super(products: products, current_currency: current_currency)
    @country = country
  end

  def description
    [
      description_products_count,
      description_made_in,
      description_products_names,
      description_average_price,
      description_produced_by_brands_count,
    ].compact.join(' ') << '.'
  end

  private

    def description_made_in
      "made in #{@country.name}"
    end
end

class Collection::VeganViewModel < CollectionViewModel

  def initialize(products:, current_currency:)
    super(products: products, current_currency: current_currency)
  end

end

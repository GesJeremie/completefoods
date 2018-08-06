class ProductPriceFactory
  attr_accessor :overrides

  def initialize(overrides = {})
    @overrides = overrides
  end

  def build
    ProductPrice.new(attributes)
  end

  private

    def attributes
      {
        currency: Currency.all.sample,
        per_serving_minimum_order: Faker::Number.between(5, 10),
        per_serving_bulk_order: Faker::Number.between(3, 6)
      }.merge(@overrides)
    end
end

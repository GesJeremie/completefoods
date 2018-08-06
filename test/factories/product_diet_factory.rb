class ProductDietFactory
  attr_accessor :overrides

  def initialize(overrides = {})
    @overrides = overrides
  end

  def build
    ProductDiet.new(attributes)
  end

  private

    def attributes
      {
        vegan: Faker::Boolean.boolean,
        vegetarian: Faker::Boolean.boolean,
        ketogenic: Faker::Boolean.boolean
      }.merge(@overrides)
    end
end

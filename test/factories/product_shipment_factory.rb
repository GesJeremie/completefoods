class ProductShipmentFactory
  attr_accessor :overrides

  def initialize(overrides = {})
    @overrides = overrides
  end

  def build
    ProductShipment.new(attributes)
  end


  private

    def attributes
      {
        rest_of_world: Faker::Boolean.boolean,
        united_states: Faker::Boolean.boolean,
        canada: Faker::Boolean.boolean,
        europe: Faker::Boolean.boolean
      }.merge(@overrides)
    end
end
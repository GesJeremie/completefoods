FactoryBot.define do
  factory :product_allergen do
    product
    gluten { Faker::Boolean.boolean }
    lactose { Faker::Boolean.boolean }
    nut { Faker::Boolean.boolean }
    ogm { Faker::Boolean.boolean }
    soy { Faker::Boolean.boolean }
  end
end

# class ProductAllergenFactory

#   def initialize(overrides = {})
#     @overrides = overrides
#   end

#   def build
#     ProductAllergen.new(attributes)
#   end

#   private

#     def attributes
#       {
#         gluten: Faker::Boolean.boolean,
#         lactose: Faker::Boolean.boolean,
#         nut: Faker::Boolean.boolean,
#         ogm: Faker::Boolean.boolean,
#         soy: Faker::Boolean.boolean
#       }.merge(@overrides)
#     end
# end

FactoryBot.define do
  factory :product_diet do
    product
    vegan { Faker::Boolean.boolean }
    vegetarian { vegan? ? true : Faker::Boolean.boolean }
    ketogenic { Faker::Boolean.boolean }
  end
end


# class ProductDietFactory

#   def initialize(overrides = {})
#     @overrides = overrides
#   end

#   def build
#     ProductDiet.new(attributes)
#   end

#   private

#     def attributes
#       {
#         vegan: Faker::Boolean.boolean,
#         vegetarian: Faker::Boolean.boolean,
#         ketogenic: Faker::Boolean.boolean
#       }.merge(@overrides)
#     end
# end

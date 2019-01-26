module Factories
  module Support
    module Traits
      def vegetarian
        build(:product_diet, { vegetarian: true })
      end

      def non_vegetarian
        build(:product_diet, { vegetarian: false })
      end

      def vegan
        build(:product_diet, { vegan: true })
      end

      def non_vegan
        build(:product_diet, { vegan: false })
      end

      def gluten
        build(:product_allergen, { gluten: true })
      end

      def gluten_free
        build(:product_allergen, { gluten: false })
      end

      def lactose
        build(:product_allergen, { lactose: true })
      end

      def lactose_free
        build(:product_allergen, { lactose: false })
      end

      def made_in(country)
        country = Country.find_by_name(country.titleize)

        { brand: create(:brand, { country: country }) }
      end
    end
  end
end

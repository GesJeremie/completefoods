class ProductRatio
  attr_reader :product

  KCAL_IN_CARBS = 4.freeze
  KCAL_IN_PROTEIN = 4.freeze
  KCAL_IN_FAT = 9.freeze

  def initialize(product)
    @product = product
  end

   def carbs_ratio
     (kcal_per_serving_from_carbs / total_kcal) * 100
   end

   def protein_ratio
     (kcal_per_serving_from_protein / total_kcal) * 100
   end

   def fat_ratio
     (kcal_per_serving_from_fat / total_kcal) * 100
   end

   private

    def total_kcal
      @total_kcal ||= [
        kcal_per_serving_from_carbs,
        kcal_per_serving_from_protein,
        kcal_per_serving_from_fat
      ].reduce(&:+)
    end

    def kcal_per_serving_from_carbs
      product.carbs_per_serving * KCAL_IN_CARBS
    end

    def kcal_per_serving_from_protein
      product.protein_per_serving * KCAL_IN_PROTEIN
    end

    def kcal_per_serving_from_fat
      product.fat_per_serving * KCAL_IN_FAT
    end
end

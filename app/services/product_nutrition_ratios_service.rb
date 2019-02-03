# class ProductNutritionRatiosService
#   attr_reader :product

#   KCAL_IN_CARBS = 4.freeze
#   KCAL_IN_PROTEIN = 4.freeze
#   KCAL_IN_FAT = 9.freeze

#   def initialize(params = {})
#     @product = params[:product]
#   end

#   def execute
#     calculate_nutrition_ratios
#   end

#   private

#     def calculate_nutrition_ratios
#       # TODO: Don't like it, fix me
#       carbs, protein, fat = ratios

#       {
#         carbs_ratio: carbs,
#         protein_ratio: protein,
#         fat_ratio: fat
#       }
#     end

#     def ratios
#       @ratios ||= rounded_percentages([carbs_ratio, protein_ratio, fat_ratio])
#     end

#     def sum_kcal
#       @sum_kcal ||= kcal_carbs_per_serving + kcal_protein_per_serving + kcal_fat_per_serving
#     end

#     def kcal_carbs_per_serving
#       product.carbs_per_serving * KCAL_IN_CARBS
#     end

#     def kcal_protein_per_serving
#       product.protein_per_serving * KCAL_IN_PROTEIN
#     end

#     def kcal_fat_per_serving
#       product.fat_per_serving * KCAL_IN_FAT
#     end

#     def carbs_ratio
#       (kcal_carbs_per_serving / sum_kcal) * 100
#     end

#     def protein_ratio
#       (kcal_protein_per_serving / sum_kcal) * 100
#     end

#     def fat_ratio
#       (kcal_fat_per_serving / sum_kcal) * 100
#     end

#     def rounded_percentages(dataset)
#       difference = 100 - dataset.map(&:floor).reduce(&:+)

#       dataset.map.with_index { |value, index| index < difference ? value.floor + 1 : value.floor }
#     end

# end

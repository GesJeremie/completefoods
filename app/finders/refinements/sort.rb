class Refinements::Sort
  attr_reader :products
  attr_reader :sort

  KCAL_REFERENCE = 500.freeze

  #
  # Example: Refinements::Sort.new(Product.active, :price_highest_possible).perform
  #
  def initialize(products, sort)
    @products = products
    @sort = sort
  end

  def perform
    if self.respond_to?(sort, true)
      send(sort)
    else
      products
    end
  end

  private

    def name
      products.sort_by { |product| product.name }
    end

    def price_highest_possible
      products.sort_by { |product| product.price.per_kcal_in_currency(KCAL_REFERENCE, currency: 'USD', type: :bulk_order) }.reverse
    end

    def price_lowest_possible
      products.sort_by { |product| product.price.per_kcal_in_currency(KCAL_REFERENCE, currency: 'USD', type: :bulk_order) }
    end

    def protein_lowest
      products.sort_by { |product| product.protein_per_kcal(KCAL_REFERENCE) }
    end

    def protein_highest
      protein_lowest.reverse
    end

    def carbs_lowest
      products.sort_by { |product| product.carbs_per_kcal(KCAL_REFERENCE) }
    end

    def carbs_highest
      carbs_lowest.reverse
    end

    def fat_lowest
      products.sort_by { |product| product.fat_per_kcal(KCAL_REFERENCE) }
    end

    def fat_highest
      fat_lowest.reverse
    end

    def protein_ratio_lowest
      products.sort_by(&:protein_ratio)
    end

    def protein_ratio_highest
      protein_ratio_lowest.reverse
    end

    def fat_ratio_lowest
      products.sort_by(&:fat_ratio)
    end

    def fat_ratio_highest
      fat_ratio_lowest.reverse
    end

    def carbs_ratio_lowest
      products.sort_by(&:carbs_ratio)
    end

    def carbs_ratio_highest
      carbs_ratio_lowest.reverse
    end
end

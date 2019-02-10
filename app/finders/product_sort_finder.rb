class ProductSortFinder

  attr_reader :products, :params

  # Examples:
  # ProductSortFinder.new(Product.active, { sort: 'kcal_per_serving_most' }).perform
  # ProductSortFinder.new(Product.all, { sort: 'carbs_per_serving_lowest' }).perform

  def initialize(products, params = {})
    @products = products
    @params = params
  end

  def perform
    return products unless params[:sort]&.present?

    if self.respond_to?(params[:sort], true)
      send(params[:sort])
    else
      products
    end
  end

  private

    def price_highest_possible
      products.sort_by { |product| product.price.per_kcal_in_currency(500, currency: 'USD', type: :minimum_order) }.reverse
    end

    def price_lowest_possible
      products.sort_by { |product| product.price.per_kcal_in_currency(500, currency: 'USD', type: :bulk_order) }
    end

    def protein_highest
      products.sort_by { |product| product.protein_per_kcal(100) }
    end

    def protein_lowest
      protein_highest.reverse
    end

    def carbs_highest
      products.sort_by { |product| product.carbs_per_kcal(100) }
    end

    def carbs_lowest
      carbs_highest.reverse
    end

    def fat_highest
      products.sort_by { |product| product.fat_per_kcal(100) }
    end

    def fat_lowest
      fat_highest.reverse
    end
end

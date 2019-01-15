class ProductSortFinder

  attr_reader :products, :params
  # Examples:
  # ProductSortFinder.new(Product.active, { sort: 'kcal_per_serving_most' }).execute
  # ProductSortFinder.new(Product.all, { sort: 'carbs_per_serving_lowest' }).execute

  def initialize(products, params = {})
    @products = products
    @params = params
  end

  def execute
    return products unless params[:sort]&.present?

    if self.respond_to?(params[:sort], true)
      send(params[:sort])
    else
      products
    end
  end

    private

      def nothing
        products
      end

      # KCAL
      def kcal_per_serving_lowest
        products.sort_by(&:kcal_per_serving)
      end

      def kcal_per_serving_most
        products.sort_by(&:kcal_per_serving).reverse
      end

      # FAT
      def fat_per_serving_lowest
        products.sort_by(&:fat_per_serving)
      end

      def fat_per_serving_most
        products.sort_by(&:fat_per_serving).reverse
      end

      def fat_per_serving_ratio_lowest
        products.sort_by(&:fat_per_serving_ratio)
      end

      def fat_per_serving_ratio_most
        products.sort_by(&:fat_per_serving_ratio).reverse
      end

      # CARBS
      def carbs_per_serving_lowest
        products.sort_by(&:carbs_per_serving)
      end

      def carbs_per_serving_most
        products.sort_by(&:carbs_per_serving).reverse
      end

      def carbs_per_serving_ratio_lowest
        products.sort_by(&:carbs_per_serving_ratio)
      end

      def carbs_per_serving_ratio_most
        products.sort_by(&:carbs_per_serving_ratio).reverse
      end

      # PROTEIN
      def protein_per_serving_lowest
        products.sort_by(&:protein_per_serving)
      end

      def protein_per_serving_most
        products.sort_by(&:protein_per_serving).reverse
      end

      def protein_per_serving_ratio_lowest
        products.sort_by(&:protein_per_serving_ratio)
      end

      def protein_per_serving_ratio_most
        products.sort_by(&:protein_per_serving_ratio).reverse
      end

      # PRICE (day)
      def price_per_day_minimum_order_cheapest
        products.sort_by { |product| product.price.per_day_minimum_order_in_currency('USD') }
      end

      def price_per_day_minimum_order_most_expensive
        products.sort_by { |product| product.price.per_day_minimum_order_in_currency('USD') }.reverse
      end

      def price_per_day_bulk_order_cheapest
        products.sort_by { |product| product.price.per_day_bulk_order_in_currency('USD') }
      end

      def price_per_day_bulk_order_most_expensive
        products.sort_by { |product| product.price.per_day_bulk_order_in_currency('USD') }.reverse
      end

end

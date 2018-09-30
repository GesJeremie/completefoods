class ProductNarrowFinder

  # Examples:
  # ProductNarrowFinder.new(Product.active, { narrow: 'kcal_per_serving_most' })
  # ProductNarrowFinder.new(Product.active, { narrow: 'carbs_per_serving_lowest' })

  def initialize(products, params = {})
    @products = products
    @params = params
  end

  def execute
    return @products unless @params[:narrow]&.present?
    return @products if @params[:narrow] == 'nothing'

    products = @products.take(max_results)

    ProductSortFinder.new(products, { sort: @params[:narrow] }).execute
  end

  private

    def max_results
      Rails.configuration.narrow_max_results
    end

end

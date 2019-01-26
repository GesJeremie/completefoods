class ProductNarrowFinder
  attr_reader :products, :params

  # Examples:
  # ProductNarrowFinder.new(Product.active, { narrow: 'kcal_per_serving_most' })
  # ProductNarrowFinder.new(Product.active, { narrow: 'carbs_per_serving_lowest' })

  def initialize(products, params = {})
    @products = products
    @params = params
  end

  def perform
    return products unless params[:narrow]&.present?
    return products if params[:narrow] == 'nothing'

    products_narrowed = products.take(max_results)

    ProductSortFinder.new(products_narrowed, { sort: params[:narrow] }).perform
  end

  private

    def max_results
      Rails.configuration.narrow_max_results
    end

end

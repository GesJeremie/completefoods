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
    return @products if @products.count < number_of_products_needed_to_activate_narrow

    products = @products.take(number_of_products_needed_to_activate_narrow)

    ProductSortFinder.new(products, { sort: @params[:narrow] }).execute
  end

  private

    def number_of_products_needed_to_activate_narrow
      Rails.configuration.number_of_products_needed_to_activate_narrow
    end

end

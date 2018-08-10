class ProductNarrowFinder
  attr_reader :products, :params

  ALLOWED_PARAMS = [:narrow].freeze

  def initialize(products, params = {})
    @products = products
    @params = params.permit(ALLOWED_PARAMS)
  end

  def execute
    return @products unless @params[:narrow].present?
    return @products if @products.count < number_of_products_needed_to_activate_narrow

    products = @products.take(number_of_products_needed_to_activate_narrow)

    ProductSortFinder.new(products, params_for_sort).execute
  end

  private

    def number_of_products_needed_to_activate_narrow
      Rails.configuration.number_of_products_needed_to_activate_narrow
    end

    def params_for_sort
      ActionController::Parameters.new(sort: @params[:narrow])
    end

end

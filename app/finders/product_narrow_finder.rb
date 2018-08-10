class ProductNarrowFinder
  attr_reader :products, :params

  ALLOWED_PARAMS = [:narrow].freeze

  def initialize(products, params = {})
    @products = products
    @params = params.permit(ALLOWED_PARAMS)
  end

  def execute
    binding.pry
    return @products unless @params[:narrow].present?
    return @products if @products.count < minimum_records

    products = @products.take(minimum_records)

    ProductSortFinder.new.execute(products, {
      sort_by: @params[:narrow]
    })
  end

  private

    def minimum_records
      Rails.configuration.number_of_products_needed_to_activate_narrow
    end

end

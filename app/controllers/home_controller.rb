class HomeController < BaseController
  def index
    @products = ProductFinder.new(params).execute
    @products = ProductDecorator.decorate_collection(@products, context: {
      currency: current_currency
    })

    @sorters = Rails.configuration.sorters
  end
end

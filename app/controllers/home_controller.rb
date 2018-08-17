class HomeController < BaseController
  def index
    @products = ProductFinder.new(params).execute
    @products = ProductDecorator.decorate_collection(@products)

    @sorters = Rails.configuration.sorters
  end
end

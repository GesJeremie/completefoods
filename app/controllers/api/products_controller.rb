class Api::ProductsController < Api::BaseController
  def index
    @products = ProductFinder.new(params).execute
    @products = ProductDecorator.decorate_collection(@products)
  end
end

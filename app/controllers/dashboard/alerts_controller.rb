class Dashboard::AlertsController < Dashboard::BaseController
  def index
    @products_with_empty_description = Product.where(description: nil)
  end
end

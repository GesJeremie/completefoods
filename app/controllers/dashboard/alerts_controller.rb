class Dashboard::AlertsController < Dashboard::BaseController
  def index
    @products_without_description = Product.where(description: nil)
  end
end

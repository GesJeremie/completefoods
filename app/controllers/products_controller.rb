class ProductsController < BaseController
  def index
    @browse = BrowseProductsViewModel.new(nil, view_model_options)
  end

  def show
    model = Product.find_by_slug(params[:slug])
    @product = ProductViewModel.wrap(model, view_model_options)
  end
end

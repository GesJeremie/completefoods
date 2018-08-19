class ProductsController < BaseController

  def show
    @product = Product.find_by_slug(params[:slug]).decorate
    @brand = @product.brand
  end

end

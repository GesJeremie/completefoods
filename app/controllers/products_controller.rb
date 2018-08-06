class ProductsController < BaseController

  def show
    @product = Product.find(params[:id]).decorate
    @brand = @product.brand
  end

end

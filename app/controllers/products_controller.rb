class ProductsController < BaseController
  def index
    products = ProductViewModel.wrap(find_products, view_model_options)

    @products = PagedArray.new(
      products,
      page: params[:page],
      per_page: products_per_page
    )
  end

  def show
    model = Product.find_by_slug(params[:slug])
    @product = ProductViewModel.wrap(model, view_model_options)
  end

  private

    def find_products
      if params[:search].present?
        Product.active.search(params[:search])
      else
        Product.active.order('name ASC')
      end
    end

    def products_per_page
      Rails.configuration.products_per_page
    end
end

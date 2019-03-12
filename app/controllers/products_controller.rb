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
        products.search(params[:search])
      else
        products.order('name ASC')
      end
    end

    def products
      Product.preload_defaults.active
    end

    def products_per_page
      Rails.configuration.products_per_page
    end
end

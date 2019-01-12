class ProductsController < BaseController
  def index
    model = ProductResultsFinder.new(filter_params.to_h).execute
    @products = ProductViewModel.wrap(model, view_model_options)
  end

  def show
    model = Product.find_by_slug(params[:slug])
    @product = ProductViewModel.new(model, view_model_options)
  end

  private

    def filter_params
      params.permit(%i[
          powder
          bottle
          snack
          vegetarian
          vegan
          gluten_free
          lactose_free
          united_states
          canada
          europe
          rest_of_world
          subscription_available
          discount_for_subscription
          made_in
          sort
          narrow
        ])
    end
end

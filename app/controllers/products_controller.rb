class ProductsController < BaseController
  def index
    @products = ProductResultsFinder.new(filter_params.to_h).execute
    @products = ProductDecorator.decorate_collection(@products)
  end

  def show
    @product = Product.find_by_slug(params[:slug]).decorate
    @brand = @product.brand
    @reviews = ProductReviewDecorator.decorate_collection(@product.reviews)
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

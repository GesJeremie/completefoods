class HomeController < BaseController
  def index
    @products = ProductResultsFinder.new(filter_params.to_h).execute

    unless sorting?
      @products = @products.reorder(:brand_id)
    end

    @products = ProductDecorator.decorate_collection(@products)

    @sorters = Rails.configuration.sorters
  end


  private

    def sorting?
      sort? || narrow?
    end

    def sort?
      params[:sort].present? && params[:sort] != 'nothing'
    end

    def narrow?
      params[:narrow].present? && params[:narrow] != 'nothing'
    end

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

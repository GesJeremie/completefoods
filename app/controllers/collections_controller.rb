class CollectionsController < BaseController

  before_action :valid_country?, only: [:made_in]

  def made_in
    find_products({ made_in: params[:country], sort: :price_per_day_bulk_order_cheapest })

    @view_model = Collection::MadeInViewModel.new(
      products: @products,
      country: @country,
      current_currency: current_currency
    )

    # Populate drawer finder with default values
    params[:made_in] = params[:country]
  end

  def vegan
    find_products({ vegan: true, sort: :price_per_day_bulk_order_cheapest })

    @view_model = Collection::VeganViewModel.new(
      products: @products,
      current_currency: current_currency
    )

    # Populate drawer finder with default values
    params[:vegan] = true
  end

  private

    def find_products(filters)
      @products = ProductResultsFinder.new(filters).execute
      @products = ProductDecorator.decorate_collection(@products)
    end

    def valid_country?
      return redirect_to root_path unless country.present?
      return redirect_to root_path unless Country.currently_active_in_brands.include?(country)
    end

    def country
      @country ||= Country.where('lower(name) = ?', params[:country].titleize.downcase).first
    end
end

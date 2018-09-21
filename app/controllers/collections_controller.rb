class CollectionsController < BaseController

  before_action :valid_country, only: [:made_in]

  def made_in
    @products = ProductResultsFinder.new({ made_in: params[:country], sort: :price_per_day_bulk_order_cheapest }).execute
    @products = ProductDecorator.decorate_collection(@products)

    # Populate drawer finder with default values
    params[:made_in] = params[:country]
  end

  private

    def valid_country
      return redirect_to root_path unless country.present?
      return redirect_to root_path unless Country.currently_active_in_brands.include?(country)
    end

    def country
      @country ||= Country.where('lower(name) = ?', params[:country].titleize.downcase).first
    end


end

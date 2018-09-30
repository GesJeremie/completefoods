class CollectionsController < BaseController

  before_action :valid_country?, only: [:made_in]
  before_action :valid_brand?, only: [:made_by]

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

  def made_by
    @products = @brand.products.where(active: true)
    @products = ProductSortFinder.new(@products, { sort: :price_per_day_bulk_order_cheapest }).execute
    @products = ProductDecorator.decorate_collection(@products)

    @view_model = Collection::BrandViewModel.new(
      brand: @brand,
      products: @products,
      current_currency: current_currency
    )
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

    def valid_brand?
      return redirect_to root_path unless brand.present?
    end

    def brand
      @brand ||= Brand.where('lower(name) = ?', params[:brand].titleize.downcase).first&.decorate
    end
end

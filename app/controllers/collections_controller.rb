class CollectionsController < BaseController

  before_action :valid_country?, only: [:made_in]
  before_action :valid_brand?, only: [:made_by]

  def index
  end

  def cheapest
    @products = find_products({ sort: :price_per_day_bulk_order_cheapest }).take(15)
    @view_model = Collection::CheapestViewModel.new(view_model_options)
  end

  def athletes
    @products = find_products({ sort: :protein_per_serving_most }).take(15)
    @view_model = Collection::AthletesViewModel.new(view_model_options)
  end

  def vegan
    @products = find_products({ vegan: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def vegetarian
    @products = find_products({ vegetarian: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def gluten_free
    @products = find_products({ gluten_free: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def lactose_free
    @products = find_products({ lactose_free: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def made_by
    @products = @brand.products.where(active: true)
    @products = ProductSortFinder.new(@products, { sort: :price_per_day_bulk_order_cheapest }).execute
    @products = ProductDecorator.decorate_collection(@products)

    @view_model = Collection::BrandViewModel.new(
      view_model_options.merge(brand: @brand)
    )
  end

  def made_in
    @products = find_products({ made_in: params[:country] })

    @view_model = Collection::MadeInViewModel.new(
      view_model_options.merge(country: @country)
    )
  end

  def most_expensive
    @products = find_products({ sort: :price_per_day_bulk_order_most_expensive })

    @view_model = Collection::MostExpensiveViewModel.new(
      products: @products,
      current_currency: current_currency
    )
  end

  def powders
    @products = find_products({ powder: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def ready_to_drink
    @products = find_products({ bottle: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  def snacks
    @products = find_products({ snack: true })
    @view_model = CollectionViewModel.new(view_model_options)
  end

  private

    def view_model_options
      {
        products: @products,
        current_currency: current_currency
      }
    end

    def find_products(filters)
      products = ProductResultsFinder.new(filters).execute
      ProductDecorator.decorate_collection(products)
    end

    def valid_brand?
      return redirect_to root_path unless brand.present?
    end

    def valid_country?
      return redirect_to root_path unless country.present?
      return redirect_to root_path unless Country.currently_active_in_brands.include?(country)
    end

    def country
      @country ||= Country.where('lower(name) = ?', params[:country].titleize.downcase).first
    end

    def brand
      @brand ||= Brand.where('lower(name) = ?', params[:brand].titleize.downcase).first&.decorate
    end
end

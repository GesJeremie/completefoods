class BrowseProductsFinder < ApplicationFinder
  attr_reader :filters
  attr_reader :search

  def initialize(params)
    @filters = params[:filters]
    @search = params[:search]
  end

  def perform
    products = Product.preload_defaults.active

    if search.present?
      products = products.search(search)
    end

    return products unless filters.present?

    shipping_countries_requested.each do |country|
      products = products.joins(:shipment).where("product_shipments.#{country} = true")
    end

    if product_states_requested.any?
      products = products.where(state: product_states_requested)
    end

    if has_filter?(:lactose_free)
      products = products.joins(:allergen).where(product_allergens: { lactose: false })
    end

    if has_filter?(:gluten_free)
      products = products.joins(:allergen).where(product_allergens: { gluten: false })
    end

    if has_filter?(:vegan)
      products = products.joins(:diet).where(product_diets: { vegan: true })
    end

    if has_filter?(:vegetarian)
      products = products.joins(:diet).where(product_diets: { vegetarian: true})
    end

    if has_filter?(:subscription_available)
      products = products.where(subscription_available: true)
    end

    if has_filter?(:discount_for_subscription)
      products = products.where(discount_for_subscription: true)
    end

    products
  end

  private

    def shipping_countries_requested
      @shipping_countries_requested ||= ProductShipment::SHIPPING_COUNTRIES.select { |country| has_filter?(country) }
    end

    def product_states_requested
      @product_states_requested ||= Product::STATES.map(&:to_sym).select { |state| has_filter?(state) }
    end

    def has_filter?(name)
      filters.has_key?(name)
    end
end

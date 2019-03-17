class BrowseProductsFinder < ApplicationFinder
  attr_reader :filters
  attr_reader :search

  def initialize(params)
    @filters = params[:filters]
    @search = params[:search]
  end

  # TODO: Switch to real SQL implementation
  def perform
    products = Product.preload_defaults.active

    if shipping_countries_requested.any?
      products = products.select do |product|
        (shipping_countries_requested - product.shipment.shippable_countries).empty?
      end
    end

    if product_states_requested.any?
      products = products.select do |product|
        product_states_requested.include?(product.state)
      end
    end

    if has_filter?(:lactose_free)
      products = products.select { |product| !product.allergen.lactose? }
    end

    if has_filter?(:gluten_free)
      products = products.select { |product| !product.allergen.gluten? }
    end

    if has_filter?(:vegan)
      products = products.select { |product| product.diet.vegan? }
    end

    if has_filter?(:vegetarian)
      products = products.select { |product| product.diet.vegetarian? }
    end

    if has_filter?(:subscription_available)
      products = products.select { |product| product.subscription_available? }
    end

    if has_filter?(:discount_for_subscription)
      products = products.select { |product| product.subscription_available? && product.discount_for_subscription?}
    end

    products
  end

  private

    def shipping_countries_requested
      ProductShipment::SHIPPING_COUNTRIES.select { |country| has_filter?(country) }
    end

    def product_states_requested
      Product::STATES.select { |state| has_filter?(state) }
    end

    def has_filter?(name)
      filters.has_key?(name)
    end
end

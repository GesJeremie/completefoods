class CollectionProductsFinder < ApplicationFinder
  attr_reader :collection_slug

  def initialize(collection_slug)
    @collection_slug = collection_slug.underscore
  end

  def perform
    if self.respond_to?(collection_slug)
      send(collection_slug)
    else
      products
    end
  end

  ##
  # Define made_in_xxxx methods
  #
  # Examples:
  # => made_in_canada
  # => made_in_france
  # => made_in_india
  # => ...
  ##
  Rails.application.config.collections_made_in.each do |country|
    method_name = "made_in_#{country}"

    define_method method_name do
      Refinements::MadeIn.new(products, country.to_sym).perform
    end
  end

  def cheapest
    Refinements::Sort.new(products, :price_lowest_possible).perform.take(15)
  end

  def for_athletes
    Refinements::Sort.new(products, :protein_ratio_highest).perform.take(15)
  end

  def for_vegans
    products.select { |product| product.diet.vegan? }
  end

  def for_vegetarians
    products.select { |product| product.diet.vegetarian? }
  end

  def gluten_free
    products.select { |product| !product.allergen.gluten? }
  end

  def lactose_free
    products.select { |product| !product.allergen.lactose? }
  end

  def most_expensive
    Refinements::Sort.new(products, :price_highest_possible).perform.take(15)
  end

  def powders
    products.select { |product| product.state == 'powder' }
  end

  def ready_to_drink
    products.select { |product| product.state == 'bottle' }
  end

  def ready_to_eat
    products.select { |product| product.state == 'snack' }
  end

  private

    def products
      Product.preload_defaults.reorder(name: :asc).active
    end
end

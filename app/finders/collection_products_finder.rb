class CollectionProductsFinder
  attr_reader :collection_slug

  def initialize(collection_slug)
    @collection_slug = collection_slug.underscore
  end

  def perform
    if collection_slug_method?
      send(collection_slug)
    else
      Product.active
    end
  end

  private

    def collection_slug_method?
      self.respond_to?(collection_slug, true)
    end

    def find_products(filters)
      ProductResultsFinder.new(filters).execute
    end

    def cheapest
      find_products({ sort: :price_per_day_bulk_order_cheapest }).take(15)
    end

    def athletes
      find_products({ sort: :protein_per_serving_most }).take(15)
    end

    def vegan
      find_products({ vegan: true })
    end

    def vegetarian
      find_products({ vegetarian: true })
    end

    def gluten_free
      find_products({ gluten_free: true })
    end

    def lactose_free
      find_products({ lactose_free: true })
    end

    def made_in_france
      find_products({ made_in: 'france' })
    end

    def most_expensive
      find_products({ sort: :price_per_day_bulk_order_most_expensive }).take(15)
    end

    def powders
      find_products({ powder: true })
    end

    def ready_to_drink
      find_products({ bottle: true })
    end

    def snacks
      find_products({ snack: true })
    end
end

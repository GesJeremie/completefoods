class CollectionProductsFinder
  attr_reader :collection_slug

  def initialize(collection_slug)
    @collection_slug = collection_slug.underscore
  end

  def perform
    if self.respond_to?(collection_slug, true)
      send(collection_slug)
    else
      find_products
    end
  end

  private

    def find_products(options = {})
      ProductFinder.new(options).execute
    end

    # Queries for each collection

    def cheapest
      find_products({ sort: 'cheapest_bulk_order' }).take(15)
    end

    def most_expensive
      find_products({ sort: 'most_expensive_bulk_order' }).take(15)
    end

    def for_athletes
      find_products({ sort: 'protein_per_serving_most' }).take(15)
    end

    def for_vegans
      find_products({ vegan: true })
    end

    def for_vegetarians
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

    def made_in_canada
      find_products({ made_in: 'canada' })
    end

    def made_in_france
      find_products({ made_in: 'france' })
    end

    def made_in_united_states
      find_products({ made_in: 'united_states' })
    end

    def made_in_india
      find_products({ made_in: 'india' })
    end

    def made_in_finland
      find_products({ made_in: 'finland' })
    end

    def made_in_italy
      find_products({ made_in: 'italy' })
    end

    def made_in_estonia
      find_products({ made_in: 'estonia' })
    end

    def made_in_spain
      find_products({ made_in: 'spain' })
    end

    def made_in_austria
      find_products({ made_in: 'austria' })
    end

    def made_in_sweden
      find_products({ made_in: 'sweden' })
    end

    def made_in_germany
      find_products({ made_in: 'germany' })
    end

    def made_in_netherlands
      find_products({ made_in: 'netherlands' })
    end

    def made_in_singapore
      find_products({ made_in: 'singapore' })
    end

    def made_in_united_kingdom
      find_products({ made_in: 'united_kingdom' })
    end

    def made_in_czech_republic
      find_products({ made_in: 'czech_republic' })
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

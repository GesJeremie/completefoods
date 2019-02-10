class CollectionProductsFinder < ApplicationFinder
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
      ProductFinder.new(options).perform
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
        find_products({ made_in: country })
      end
    end

    def cheapest
      find_products({ sort: :price_lowest_possible }).take(15)
    end

    def for_athletes
      find_products({ sort: :most_protein }).take(15)
    end

    def for_vegans
      find_products({ vegan: true })
    end

    def for_vegetarians
      find_products({ vegetarian: true })
    end

    def gluten_free
      find_products({ gluten: false })
    end

    def lactose_free
      find_products({ lactose: false })
    end

    def most_expensive
      find_products({ sort: :price_highest_possible }).take(15)
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

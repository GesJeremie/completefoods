class CollectionViewModel::Description
  include CounterHelper

  def initialize(collection)
    @collection = collection
  end

  def perform
    if self.respond_to?(slug, true)
      send(slug).html_safe
    end
  end

  private
    attr_reader :collection

    def slug
      collection.slug.underscore
    end

    def cheapest
      "This is the <strong>Top 15</strong> of the cheapest <strong>Complete Foods</strong> " \
      "based on the <strong>#{count_active_products} products</strong> we reference."
    end

    def most_expensive
      "This is the <strong>Top 15</strong> of the most expensive <strong>Complete Foods</strong> " \
      "based on the <strong>#{count_active_products} products</strong> we reference."
    end

    def for_athletes
      "This is the <strong>Top 15 Complete Foods</strong> for Athletes " \
      "based on the <strong>#{count_active_products} products</strong> we reference."
    end
end

class CollectionDescription
  include CounterHelper
  attr_reader :collection

  def initialize(collection_view_model)
    @collection = collection_view_model
  end

  def perform
    if self.respond_to?(slug)
      send(slug).html_safe
    end
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

  private

    def slug
      collection.slug.underscore
    end
end

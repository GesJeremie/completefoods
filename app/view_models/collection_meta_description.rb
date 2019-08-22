class CollectionMetaDescription
  attr_reader :collection

  def initialize(collection_view_model)
    @collection = collection_view_model
  end

  def perform
    if self.respond_to?(slug)
      send(slug)
    else
      default
    end
  end

  def default
    "Looking for the complete foods #{collection.name.downcase}? #{preview_product_names}"
  end

  def cheapest
    "Looking for the cheapest complete foods? #{preview_product_names}"
  end

  def most_expensive
    "Looking for the most expensive complete foods? #{preview_product_names}"
  end

  def for_vegans
    "Looking for the complete foods suitable for vegans? #{preview_product_names}"
  end

  def for_vegetarians
    "Looking for the complete foods suitable for vegetarians? #{preview_product_names}"
  end

  def powders
    "Looking for the powdered complete foods? #{preview_product_names}"
  end

  def for_athletes
    "Looking for the complete foods suitable for athletes? #{preview_product_names}"
  end

  private

  def slug
    collection.slug.underscore
  end

  def preview_product_names
    names = collection.products.pluck(:name).take(3).join(', ')

    if names.present?
      "Take a look at #{names} and the others."
    end
  end
end

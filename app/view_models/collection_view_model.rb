class CollectionViewModel < ApplicationViewModel

  def cache_key
    [
      model.cache_key,
      Product.maximum(:updated_at)&.to_s(:number),
      Brand.maximum(:updated_at)&.to_s(:number),
      options[:current_currency]
    ].join('/')
  end

  def meta_description
    @meta_description ||= CollectionMetaDescription.new(self).perform
  end

  def meta_image
    "meta/#{model.slug.underscore}.png"
  end

  def description
    @description ||= CollectionDescription.new(self).perform
  end

  def image
    "collections/#{model.slug.underscore}.jpg"
  end

  def products
    @products ||= ProductViewModel.wrap(
      CollectionProductsFinder.new(model.slug).perform,
      options
    )
  end
end

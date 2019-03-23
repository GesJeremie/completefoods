class CollectionViewModel < ApplicationViewModel

  def cache_key
    @cache_key ||= [model.cache_key, options_cache_key].join('/')
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

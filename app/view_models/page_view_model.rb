class PageViewModel < ApplicationViewModel
  def preview_brands
    @preview_brands ||= BrandViewModel.wrap(brands, options)
  end

  def preview_collections
    @preview_collections ||= CollectionViewModel.wrap(collections, options)
  end

  private
    def brands
      Brand.includes(:country).with_active_products.reorder(name: :asc).take(number_items_preview_brands)
    end

    def collections
      Collection.all.take(number_items_preview_collections)
    end

    def number_items_preview_brands
      Rails.configuration.number_items_preview_brands
    end

    def number_items_preview_collections
      Rails.configuration.number_items_preview_collections
    end
end

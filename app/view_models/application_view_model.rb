class ApplicationViewModel
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  def preview_brands
    @preview_brands ||=
      begin
        brands = Brand.reorder(name: :asc).slice(0, number_items_preview_brands)
        BrandDecorator.decorate_collection(brands)
      end
  end

  def preview_collections
    @preview_collections ||= Rails.configuration.collections.slice(0, number_items_preview_collections)
  end

  def count_active_products
    @count_active_products ||= Product.active.count
  end

  private

    def number_items_preview_brands
      Rails.configuration.number_items_preview_brands
    end

    def number_items_preview_collections
      Rails.configuration.number_items_preview_collections
    end
end

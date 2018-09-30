class SitemapController < BaseController

  def index
    set_products
    set_collection_made_in
    set_collection_made_by
    respond_to :xml
  end


  private

    def set_products
      @products = Product.active
    end

    def set_collection_made_in
      @collection_made_in = Country.currently_active_in_brands.pluck(:name).map(&:parameterize)
    end

    def set_collection_made_by
      @collection_made_by = Brand.pluck(:name).map(&:parameterize)
    end

end

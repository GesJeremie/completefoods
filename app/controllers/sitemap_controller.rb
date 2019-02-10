class SitemapController < BaseController
  def index
    @products = Product.active
    @collections = Collection.all
    @brands = Brand.all
    respond_to :xml
  end
end

class CollectionsController < BaseController
  def index
    @browse_collections = BrowseCollectionsViewModel.new(nil, view_model_options)
  end

  # TODO: Ensure collection exists.
  def show
    model = Collection.where(slug: params[:slug]).first

    @collection = CollectionViewModel.wrap(model, view_model_options)
    @products = PagedArray.new(@collection.products, page: params[:page], per_page: products_per_page)
  end

  private

  def products_per_page
    Rails.configuration.collection_products_per_page
  end
end

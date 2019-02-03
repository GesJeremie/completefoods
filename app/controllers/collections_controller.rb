class CollectionsController < BaseController
  def index
    model = Collection.all
    @collections = CollectionViewModel.wrap(model, view_model_options)
  end

  # TODO: Ensure collection exists.
  def show
    collection = Collection.where(slug: params[:slug]).first
    products = CollectionProductsFinder.new(collection.slug).perform
    products = ProductViewModel.wrap(products, view_model_options)

    @collection = CollectionViewModel.wrap(collection, view_model_options)
    @products = PagedArray.new(products, page: params[:page], per_page: products_per_page)
  end

  private

    def products_per_page
      Rails.configuration.products_per_page
    end
end

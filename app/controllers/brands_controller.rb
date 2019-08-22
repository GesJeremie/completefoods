class BrandsController < BaseController
  def index
    @browse_brands = BrowseBrandsViewModel.new(nil, view_model_options)
  end

  def show
    model = Brand.find(id_from_slug)
    @brand = BrandViewModel.new(model, view_model_options)
  end

  private

  def id_from_slug
    @id_from_slug ||= params[:slug].split('-').first rescue nil
  end
end

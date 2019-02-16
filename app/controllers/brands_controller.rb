class BrandsController < BaseController
  def index
    model = Brand.with_active_products

    @brands = BrandViewModel.wrap(model, view_model_options)
    @navigation = BrandNavigationViewModel.new(model, view_model_options)
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

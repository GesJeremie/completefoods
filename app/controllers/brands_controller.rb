class BrandsController < BaseController
  def index
    @view_model = Brands::IndexViewModel.new(brands: Brand.with_active_products)
  end

  def show
    brand = brand_from_slug
    @view_model = Brands::ShowViewModel.new(brand: brand)
  end

  private

    def brand_from_slug
      @brand_from_slug ||= Brand.find(id_from_slug).decorate
    end

    def id_from_slug
      @id_from_slug ||= params[:slug].split('-').first rescue nil
    end
end

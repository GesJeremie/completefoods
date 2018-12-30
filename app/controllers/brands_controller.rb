class BrandsController < BaseController

  def index
    @brands = brands_with_active_products
    @view_model = BrandViewModel.new(brands: @brands)
  end

  def show
  end

  private

    def brands_with_active_products
      @brands_with_active_products ||=
        begin
          BrandDecorator.decorate_collection(Brand.with_active_products)
        end
    end

    def id_from_slug
      @id_from_slug ||= params[:slug].split('-').first rescue nil
    end
end

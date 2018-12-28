class BrandsController < BaseController

  def index
    @brands = brands_with_active_products
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
end

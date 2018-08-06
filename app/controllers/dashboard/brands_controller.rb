class Dashboard::BrandsController < Dashboard::BaseController
  def index
    @brands = Brand.all
    @brands = BrandDecorator.decorate_collection(@brands)
  end

  def show
    @brand = Brand.find(params[:id]).decorate
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to dashboard_brands_path
    else
      render :new
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    @brand.update(brand_params)

    render :edit
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    redirect_to dashboard_brands_path
  end

  private

    def brand_params
      params.require(:brand).permit(allowed_brand_params)
    end

    def allowed_brand_params
      %i[
        name
        website
        facebook
        country_id
      ]
    end
end

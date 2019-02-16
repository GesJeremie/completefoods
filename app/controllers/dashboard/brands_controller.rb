class Dashboard::BrandsController < Dashboard::BaseController
  def index
    model = Brand.includes(:country, :products).all
    @brands = BrandViewModel.wrap(model, view_model_options)
  end

  def show
    model = Brand.find(params[:id])
    @brand = BrandViewModel.wrap(model, view_model_options)
  end

  def new
    @brand = Brand.new
  end

  def create
    brand = Brand.new(brand_params)

    if brand.save
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
    Brand.find(params[:id]).destroy

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

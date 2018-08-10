class Dashboard::ProductsController < Dashboard::BaseController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.build_diet
    @product.build_allergen
    @product.build_price
    @product.build_shipment
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to dashboard_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to edit_dashboard_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to dashboard_products_path, notice: 'Product was successfully destroyed.'
  end

  private

    def product_params
      params.require(:product).permit(
        allowed_product_params,
        allergen_attributes: allowed_allergens_params,
        diet_attributes: allowed_diets_params,
        price_attributes: allowed_prices_params,
        shipment_attributes: allowed_shipments_params
      )
    end

    def allowed_product_params
      %i[
        brand_id
        name
        kcal_per_serving
        protein_per_serving
        carbs_per_serving
        fat_per_serving
        subscription_available
        discount_for_subscription
        shaker_free_first_order
        sample_pack_available
        state
        active
        image
      ]
    end

    def allowed_allergens_params
      %i[
        gluten
        lactose
        nut
        ogm
        soy
      ]
    end

    def allowed_diets_params
      %i[
        vegan
        vegetarian
        ketogenic
      ]
    end

    def allowed_prices_params
      %i[
        currency_id
        per_serving_minimum_order
        per_serving_bulk_order
      ]
    end

    def allowed_shipments_params
      %i[
        united_states
        canada
        europe
        rest_of_world
      ]
    end

end

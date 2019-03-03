class Dashboard::ProductsController < Dashboard::BaseController
  def index
    model = Product.includes(:brand).all
    @products = ProductViewModel.wrap(model)
  end

  def show
    model = Product.find_by_slug(params[:slug])
    @product = ProductViewModel.wrap(model)
  end

  def new
    product = Product.new
    product.build_diet
    product.build_allergen
    product.build_price
    product.build_shipment

    @product = product
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
    @product = Product.find_by_slug(params[:slug])
  end

  def update
    @product = Product.find_by_slug(params[:slug])

    if @product.update(product_params)
      redirect_to edit_dashboard_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find_by_slug(params[:slug])
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
        active
        brand_id
        carbs_per_serving
        description
        discount_for_subscription
        fat_per_serving
        flavor
        image
        kcal_per_serving
        name
        notes
        protein_per_serving
        slug
        state
        subscription_available
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
        ketogenic
        vegan
        vegetarian
      ]
    end

    def allowed_prices_params
      %i[
        currency_id
        per_serving_bulk_order
        per_serving_minimum_order
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

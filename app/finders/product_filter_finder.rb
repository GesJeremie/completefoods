class ProductFilterFinder
  ALLOWED_PARAMS = [
    :subscription_available,
    :discount_for_subscription,
    :shaker_free_first_order,
    :sample_pack_available,
    :state,

    :vegetarian,
    :vegan,
    :ketogenic,

    :gluten_free,
    :lactose_free,
    :nut_free,
    :ogm_free,
    :soy_free,

    :united_states,
    :canada,
    :europe,
    :rest_of_world
  ].freeze

  def initialize(products, params = {})
    @products = products
    @params = params.permit(ALLOWED_PARAMS)
  end

  def execute
    by(:subscription_available)
    by(:discount_for_subscription)
    by(:shaker_free_first_order)
    by(:sample_pack_available)
    by(:state)

    by_diet(:vegetarian)
    by_diet(:vegan)
    by_diet(:ketogenic)

    by_shipment(:united_states)
    by_shipment(:canada)
    by_shipment(:europe)
    by_shipment(:rest_of_world)

    by_allergen(:gluten)
    by_allergen(:lactose)

    @products
  end

  private

    def by(column)
      return unless @params[column].present?

      @products = @products.where(column => true)
    end

    def by_diet(column)
      by_relation(:diet, :product_diets, column)
    end

    def by_shipment(column)
      by_relation(:shipment, :product_shipments, column)
    end

    def by_allergen(column)
      column_as_param = "#{column}_free".to_sym # :gluten becomes :gluten_free

      return unless @params[column_as_param].present?

      @products = @products.joins(:allergen).where(product_allergens: { column => false })
    end

    private

      def by_relation(relation, relation_scope, column)
        return unless @params[column].present?

        @products = @products.joins(relation).where(relation_scope => { column => true })
      end
end

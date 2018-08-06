class ProductFilterFinder
  attr_reader :params

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

  def initialize(params = {})
    @params = params.permit(ALLOWED_PARAMS)
  end

  def execute
    products = Product.active

    products = by(:subscription_available, products)
    products = by(:discount_for_subscription, products)
    products = by(:shaker_free_first_order, products)
    products = by(:sample_pack_available, products)
    products = by(:state, products)

    products = by_diet(:vegetarian, products)
    products = by_diet(:vegan, products)
    products = by_diet(:ketogenic, products)

    products = by_shipment(:united_states, products)
    products = by_shipment(:canada, products)
    products = by_shipment(:europe, products)
    products = by_shipment(:rest_of_world, products)

    products = by_allergen(:gluten, products)
    products = by_allergen(:lactose, products)

    # products = by_relation_not(:allergen, :product_allergens, :gluten_free, products)
    # products = by_relation_not(:allergen, :product_allergens, :lactose_free, products)
    # products = by_relation_not(:allergen, :product_allergens, :nut_free, products)
    # products = by_relation_not(:allergen, :product_allergens, :ogm_free, products)
    # products = by_relation_not(:allergen, :product_allergens, :soy_free, products)
  end

  private

    def by(column, items)
      return items unless params[column].present?

      items.where(column => true)
    end

    def by_diet(column, items)
      by_relation(:diet, :product_diets, column, items)
    end

    def by_shipment(column, items)
      by_relation(:shipment, :product_shipments, column, items)
    end

    def by_allergen(column, items)
      column_as_param = "#{column}_free".to_sym # :gluten becomes :gluten_free

      return items unless params[column_as_param].present?

      items.joins(:allergen).where(product_allergens: { column => false })
    end

    def by_relation(relation, relation_scope, column, items)
      return items unless params[column].present?

      items = items.joins(relation).where(relation_scope => { column => true })
    end
end

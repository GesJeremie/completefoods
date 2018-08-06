class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :brand

  DAYS_PER_MONTH = 30.4167.freeze
  KCAL_PER_DAY = 2000.freeze
  KCAL_PER_MONTH = (DAYS_PER_MONTH * KCAL_PER_DAY).freeze

  def flag
    country = product.brand.country.code.downcase.to_sym
    h.flag_icon(country)
  end

  def name
    object.name.capitalize
  end

  def kcal_per_serving
    decimal(object.kcal_per_serving, 0)
  end

  def protein_per_serving
    decimal(object.protein_per_serving, 2)
  end

  def carbs_per_serving
    decimal(object.carbs_per_serving, 2)
  end

  def fat_per_serving
    decimal(object.fat_per_serving, 2)
  end

  def estimated_cost_per_month_bulk_order
    estimated_cost_per_month(object.price.per_serving_bulk_order)
  end

  def estimated_cost_per_month_minimum_order
    estimated_cost_per_month(object.price.per_serving_minimum_order)
  end

  def estimated_cost_per_day_bulk_order
    estimated_cost_per_day(object.price.per_serving_bulk_order)
  end

  def estimated_cost_per_day_minimum_order
    estimated_cost_per_day(object.price.per_serving_minimum_order)
  end

  def estimated_cost_per_month_bulk_order_format
    cost = estimated_cost_per_month_bulk_order
    format_currency(cost)
  end

  def image_url
    h.url_for(product.image.variant(resize: '200x200').processed)
  end

  def image_small_url
    h.url_for(product.image.variant(resize: '100x100').processed)
  end

  def convert_to_current_currency(number)
    number.to_money(object.price.currency.code).exchange_to(context[:currency].code).to_s
  end

  def format_currency(number)
    symbol = context[:currency].symbol
    number = decimal(number, 2)

    "#{symbol}#{number}"
  end

  private

    def estimated_cost_per_day(price_per_serving)
      nb_meals_per_day = KCAL_PER_DAY / object.kcal_per_serving
      cost_per_day = nb_meals_per_day * price_per_serving

      convert_to_current_currency(cost_per_day)
    end

    def estimated_cost_per_month(price_per_serving)
      nb_meals_per_month = KCAL_PER_MONTH / object.kcal_per_serving
      cost_per_month = nb_meals_per_month * price_per_serving

      convert_to_current_currency(cost_per_month)
    end

    def decimal(number, precision)
      sprintf("%.#{precision}f", number)
    end
end

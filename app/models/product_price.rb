class ProductPrice < ApplicationRecord
  DAYS_PER_MONTH = 30.4167.freeze
  KCAL_PER_DAY = 2000.freeze
  KCAL_PER_MONTH = (DAYS_PER_MONTH * KCAL_PER_DAY).freeze

  belongs_to :product
  belongs_to :currency

  validates :product, presence: true
  validates :currency_id, presence: true
  validates :per_serving_minimum_order, presence: true
  validates :per_serving_bulk_order, presence: true

  def per_day_minimum_order
    cost_per_day(self.per_serving_minimum_order)
  end

  def per_day_bulk_order
    cost_per_day(self.per_serving_bulk_order)
  end

  def per_month_minimum_order
    per_day_minimum_order * DAYS_PER_MONTH
  end

  def per_month_bulk_order
    per_day_bulk_order * DAYS_PER_MONTH
  end

  #

  def per_serving_minimum_order_in_currency(currency_code)
    in_currency(self.per_serving_minimum_order, currency_code)
  end

  def per_serving_bulk_order_in_currency(currency_code)
    in_currency(self.per_serving_bulk_order, currency_code)
  end

  def per_day_minimum_order_in_currency(currency_code)
    in_currency(per_day_minimum_order, currency_code)
  end

  def per_day_bulk_order_in_currency(currency_code)
    in_currency(per_day_bulk_order, currency_code)
  end

  def per_month_minimum_order_in_currency(currency_code)
    in_currency(per_month_minimum_order, currency_code)
  end

  def per_month_bulk_order_in_currency(currency_code)
    in_currency(per_month_bulk_order, currency_code)
  end

  private

    def in_currency(number, currency_code)
      number.to_money(self.currency.code).exchange_to(currency_code).to_f
    end

    def cost_per_day(price_per_serving)
      meals_per_day = KCAL_PER_DAY / self.product.kcal_per_serving
      cost = meals_per_day * price_per_serving
      in_currency(cost, 'USD')
    end
end

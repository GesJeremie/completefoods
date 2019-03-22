class ProductPrice < ApplicationRecord
  DAYS_PER_MONTH = 30.4167.freeze
  KCAL_PER_DAY = 2000.freeze

  belongs_to :product, touch: true
  belongs_to :currency

  validates :product, presence: true
  validates :currency_id, presence: true
  validates :per_serving_minimum_order, presence: true
  validates :per_serving_bulk_order, presence: true

  def per_kcal(kcal, type:)
    if type == :minimum_order
      kcal * cost_per_kcal(self.per_serving_minimum_order)
    else
      kcal * cost_per_kcal(self.per_serving_bulk_order)
    end
  end

  def per_day(type:)
    per_kcal(KCAL_PER_DAY, type: type)
  end

  def per_month(type:)
    per_day(type: type) * DAYS_PER_MONTH
  end

  def per_kcal_in_currency(kcal, type:, currency:)
    in_currency(
      per_kcal(kcal, type: type),
      currency
    )
  end

  def per_day_in_currency(type:, currency:)
    in_currency(
      per_day(type: type),
      currency
    )
  end

  def per_month_in_currency(type:, currency:)
    in_currency(
      per_month(type: type),
      currency
    )
  end

  private

    def in_currency(number, currency_code)
      number.to_money(self.currency.code).exchange_to(currency_code).to_d
    end

    def cost_per_kcal(price_per_serving)
      price_per_serving / self.product.kcal_per_serving
    end
end

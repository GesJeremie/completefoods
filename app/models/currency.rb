class Currency < ApplicationRecord
  POPULAR_CURRENCIES = %w[AUD GBP CAD HRK CZK EUR HUF MXN MDL PLN SGD SEK CHF USD].freeze

  has_many :product_prices

  def self.popular
    where(code: POPULAR_CURRENCIES).order(:name)
  end
end

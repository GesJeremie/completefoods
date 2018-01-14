class MarketExchange < ApplicationRecord
  belongs_to :crypto_currency
  belongs_to :currency

  def self.last_price(crypto, fiat)
    MarketExchange::Update.(
      crypto_currency: crypto,
      fiat_currency: fiat
    )

    self.where(crypto_currency: crypto, fiat_currency: fiat).order(updated_at: :desc).first&.price || 0
  end
end

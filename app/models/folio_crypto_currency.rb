class FolioCryptoCurrency < ApplicationRecord
  belongs_to :folio
  belongs_to :crypto_currency

  def self.order_by_crypto_currency_name
    includes(:crypto_currency).order('crypto_currencies.name asc')
  end
end

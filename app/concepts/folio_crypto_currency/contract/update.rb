require 'reform/form/validation/unique_validator'

module FolioCryptoCurrency::Contract
  class Update < Reform::Form

    property :folio_id
    property :crypto_currency_id
    property :holding

    validates :folio_id,
      presence: true

    validates :crypto_currency_id,
      presence: true

    validates :holding,
      presence: true,
      numericality: true

  end
end

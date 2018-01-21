require 'reform/form/validation/unique_validator'

module FolioCryptoCurrency::Contract
  class Create < Reform::Form

    property :folio_id
    property :crypto_currency_id

    validates :folio_id,
      presence: true

    validates :crypto_currency_id,
      presence: true

  end
end

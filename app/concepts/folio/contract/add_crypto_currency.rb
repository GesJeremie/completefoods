require 'reform/form/validation/unique_validator'

module Folio::Contract
  class AddCryptoCurrency < Reform::Form

    property :folio_id
    property :crypto_currency_id
    property :holding

    validates :folio_id,
      presence: true,
      numericality: { only_integer: true }

    validates :crypto_currency_id,
      presence: true,
      numericality: { only_integer: true }

    validates :holding,
      presence: true,
      numericality: true
  end
end

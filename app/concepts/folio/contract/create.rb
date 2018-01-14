require 'reform/form/validation/unique_validator'

module Folio::Contract
  class Create < Reform::Form

    property :user_id
    property :currency_id

    validates :user_id,
      presence: true,
      unique: true

    validates :currency_id,
      presence: true

  end
end

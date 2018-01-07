require 'reform/form/validation/unique_validator'

module Folio::Contract
  class Create < Reform::Form

    property :user_id
    property :currency

    validates :user_id,
      presence: true,
      unique: true

    validates :currency,
      presence: true,
      inclusion: {in: %w(EUR USD)}

  end
end

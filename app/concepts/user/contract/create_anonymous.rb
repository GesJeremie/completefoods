require 'reform/form/validation/unique_validator'

module User::Contract
  class CreateAnonymous < Reform::Form

    property :role
    property :token

    validates :role,
      presence: true,
      inclusion: {in: %w(anonymous)}

    validates :token,
      presence: true,
      unique: true

  end
end

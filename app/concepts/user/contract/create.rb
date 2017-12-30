require 'reform/form/validation/unique_validator'

module User::Contract
  class Create < Reform::Form

    property :email
    property :password
    property :role
    property :token

    validates :email,
      presence: true,
      unique: true,
      format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

    validates :password,
      presence: true

    validates :role,
      presence: true,
      inclusion: {in: %w(user)}

    validates :token,
      presence: true,
      unique: true
  end
end

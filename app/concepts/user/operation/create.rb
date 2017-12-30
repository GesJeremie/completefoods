require 'bcrypt'

class User::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:email).filled
    required(:password).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  success   :encrypt_password
  success   :generate_token
  step      Model(User, :new)
  step      Contract::Build(constant: User::Contract::Create)
  success   :assign_user_values
  step      Contract::Validate()
  step      Contract::Persist()

  def encrypt_password(options, params:, **)
    options['data.password'] = BCrypt::Password.create(params[:password])
  end

  def generate_token(options, *)
    token = loop do
      random_token = SecureRandom.uuid
      break random_token unless User.exists?(token: random_token)
    end

    options['data.token'] = token
  end

  def assign_user_values(options, *)
    options['model'].token = options['data.token']
    options['model'].password = options['data.password']
    options['model'].role = 'user'
  end

end

require 'bcrypt'

class User::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:email).filled
    required(:password).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      Model(User, :new)
  success   :generate_token
  success   :encrypt_password
  success   :assign_user_values
  step      Contract::Build(constant: User::Contract::Create)
  step      Contract::Validate()
  step      Contract::Persist()

  def generate_token(options, *)
    options['data.token'] = loop do
                              random_token = SecureRandom.uuid
                              break random_token unless User.exists?(token: random_token)
                            end
  end

  def encrypt_password(options, params:, **)
    params[:password] = BCrypt::Password.create(params[:password])
  end

  def assign_user_values(options, params:, **)
    options['model'].assign_attributes(
      token: options['data.token'],
      role: 'user'
    )
  end

end

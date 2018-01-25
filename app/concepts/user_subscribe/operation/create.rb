require 'bcrypt'

class UserSubscribe::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:email).filled
    required(:password).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      Policy::Guard(:current_user?)
  step      :find_user!
  step      :anonymous?
  success   :encrypt_password
  success   :assign_role
  step      Contract::Build(constant: UserSubscribe::Contract::Create)
  step      Contract::Validate()
  step      Contract::Persist()

  def current_user?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def find_user!(options, params:, **)
    user = User.find_by(id: options['current_user'])

    if user.nil?
      options['errors'] = 'This user doesn\'t exist'
      false
    else
      options['model'] = user
    end
  end

  def anonymous?(options, params:, **)
    return true if options['model'].role == 'anonymous'

    options['errors'] = 'The user is already registered'
    false
  end

  def encrypt_password(options, params:, **)
    params[:password] = BCrypt::Password.create(params[:password])
  end

  def assign_role(options, params:, **)
    options['model'].role = 'user'
  end

end

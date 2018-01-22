require 'bcrypt'

class UserConnect::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:email).filled
    required(:password).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      :user_exists?
  step      :can_connect?

  def user_exists?(options, params:, **)
    user = User.find_by(email: params[:email])

    if user.present?
      options['data.user'] = user
    else
      options['errors'] = 'Email doesn\'t exist'
      false
    end
  end

  def can_connect?(options, params:, **)
    user = options['data.user']

    return true if same_password?(user.password, params[:password])

    options['errors'] = 'Password doesn\'t match'
    false
  end

  private

    def same_password?(user_password, password)
      BCrypt::Password.new(user_password) == password
    end

end

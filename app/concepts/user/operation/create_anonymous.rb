=begin

  Usage:
  ---

  User::CreateAnonymous.()

=end
class User::CreateAnonymous < Trailblazer::Operation

  success   :generate_token
  step      Model(User, :new)
  success   :assign_user_values
  step      Contract::Build(constant: User::Contract::CreateAnonymous)
  step      Contract::Validate()
  step      Contract::Persist()

  def generate_token(options, *)
    token = loop do
      random_token = SecureRandom.uuid
      break random_token unless User.exists?(token: random_token)
    end

    options['data.token'] = token
  end

  def assign_user_values(options, *)
    options['model'].token = options['data.token']
    options['model'].role = 'anonymous'
  end

end

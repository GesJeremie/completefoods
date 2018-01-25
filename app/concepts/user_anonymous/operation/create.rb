class UserAnonymous::Create < Trailblazer::Operation

  success   :generate_token
  step      Model(User, :new)
  success   :assign_user_values
  step      Contract::Build(constant: UserAnonymous::Contract::Create)
  step      Contract::Validate()
  step      Contract::Persist()

  def generate_token(options, *)
    options['data.token'] = loop do
                              random_token = SecureRandom.uuid
                              break random_token unless User.exists?(token: random_token)
                            end
  end

  def assign_user_values(options, *)
    options['model'].assign_attributes(
      token: options['data.token'],
      role: 'anonymous'
    )
  end

end

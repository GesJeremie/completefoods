class Folio::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:user_token).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      :user_exists?
  success   :get_user_id
  step      Model(Folio, :new)
  success   :assign_folio_values
  step      Contract::Build(constant: Folio::Contract::Create)
  step      Contract::Validate()
  step      Contract::Persist()

  def user_exists?(options, params:, **)
    return true if User.exists?(token: params[:user_token])

    options['errors'] = 'The user given doesn\'t exist'
    false
  end

  def get_user_id(options, params:, **)
    options['data.user_id'] = User.where(token: params[:user_token]).first.id
  end

  def assign_folio_values(options, params:, **)
    options['model'].user_id = options['data.user_id']
    options['model'].currency_id = Currency.where(code: 'USD').first.id
  end

end

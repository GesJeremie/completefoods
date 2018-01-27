class SettingsCurrency::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:currency_id).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      Policy::Guard(:current_user?)
  step      :own_folio?
  step      :currency_exists?
  step      :update!

  def current_user?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def own_folio?(options, params:, **)
    return true if options['current_user'].folio.present?

    options['errors'] = 'The user doesn\'t have have a folio'
    false
  end

  def currency_exists?(options, params:, **)
    return true if Currency.find_by(id: params[:currency_id])

    options['errors'] = 'This currency doesn\'t exist'
    false
  end

  def update!(options, params:, **)
    folio = options['current_user'].folio

    folio.currency_id = params[:currency_id]
    folio.save

    options['model'] = folio
  end

end

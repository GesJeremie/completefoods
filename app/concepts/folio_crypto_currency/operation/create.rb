class FolioCryptoCurrency::Create < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency_id).filled
  end)

  step    Contract::Validate(name: 'params'), before: 'operation.new'
  step    Policy::Guard(:options?)
  step    :crypto_currency_exists?
  step    :user_folio?
  step    :crypto_currency_already_added?
  step    Model(FolioCryptoCurrency, :new)
  success :assign_values
  step    Contract::Build(constant: FolioCryptoCurrency::Contract::Create)
  step    Contract::Validate()
  step    Contract::Persist()

  def options?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def crypto_currency_exists?(options, params:, **)
    crypto_currency = CryptoCurrency.find(params[:crypto_currency_id])

    if !crypto_currency.nil?
      options['data.crypto_currency'] = crypto_currency
    else
      options['errors'] = 'This crypto currency is not supported'
      false
    end
  end

  def user_folio?(options, params:, **)
    return true if options['current_user'].folio.present?

    options['errors'] = 'The user does not have a folio'
    false
  end

  def crypto_currency_already_added?(options, params:, **)
    return true if current_user_not_holding_crypto?(options, params)

    options['errors'] = 'Crypto currency already added for this folio'
    false
  end

  def assign_values(options, params:, **)
    options['model'].assign_attributes(
      holding: 0,
      folio_id: options['current_user'].folio.id,
      crypto_currency_id: params[:crypto_currency_id]
    )
  end

  private

    def current_user_not_holding_crypto?(options, params)
      !options['current_user'].folio_crypto_currencies.where(crypto_currency_id: params[:crypto_currency_id]).exists?
    end

end

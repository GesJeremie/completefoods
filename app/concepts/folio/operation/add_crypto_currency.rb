=begin

  Add the given  crypto currency to the folio given.

  Usage:
  ---

  Folio::AddCryptoCurrency.(
    {
      crypto_currency_id: 1,
      folio_id: 12
    },
    'current_user' => User<Model>

  )

=end
class Folio::AddCryptoCurrency < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency_id).filled(:int?)
    required(:folio_id).filled(:int?)
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      :crypto_currency_exists?
  step      :folio_exists?
  step      :authorize!
  step      :crypto_currency_not_already_added?
  step      Model(FolioCryptoCurrency, :new)
  success   :assign_values
  step      Contract::Build(constant: Folio::Contract::AddCryptoCurrency)
  step      Contract::Validate()
  step      Contract::Persist()

  def crypto_currency_exists?(options, params:, **)
    crypto_currency = CryptoCurrency.find(params[:crypto_currency_id])

    if !crypto_currency.nil?
      options['data.crypto_currency'] = crypto_currency
    else
      options['errors'] = 'This crypto currency is not supported'
      false
    end

  end

  def folio_exists?(options, params:, **)
    return true if Folio.exists?(id: params[:folio_id])

    options['errors'] = 'The folio doesn\'t exist'
    false
  end

  def authorize!(options, params:, **)
    return true if options['current_user'].id == Folio.find(params[:folio_id]).user_id

    options['errors'] = 'This user can\'t add a crypto currency in this folio'
    false
  end

  def crypto_currency_not_already_added?(options, params:, **)
    return true if !FolioCryptoCurrency.exists?(folio_id: params[:folio_id], crypto_currency_id: options['data.crypto_currency'].id)

    options['errors'] = 'Crypto currency already added for this folio'
    false
  end

  def assign_values(options, params:, **)
    options['model'].holding = 0
    options['model'].folio_id = params[:folio_id]
    options['model'].crypto_currency_id = options['data.crypto_currency'].id
  end

end

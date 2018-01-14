=begin

  Usage:
  ---

  MarketExchange::Create.(
    crypto_currency: 'BTC',
    currency: 'EUR',
    force: false // Force the create even if the cache is not expired
  )

=end
class MarketExchange::Create < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency).filled(:str?)
    required(:currency).filled(:str?)
    optional(:force).maybe(:bool?)
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  success   :sanitize_params
  step      :crypto_currency_supported?
  step      :currency_supported?
  step      :fetch_current_price!
  success   :update

  def sanitize_params(option, params:, **)
    params[:crypto_currency] = params[:crypto_currency].upcase
  end

  def crypto_currency_supported?(options, params:, **)
    crypto_currency = CryptoCurrency.where(symbol: params[:crypto_currency].upcase).first

    if crypto_currency.nil?
      options['errors'] = 'This crypto currency is not supported yet.'
      return false
    end

    options['data.crypto_currency'] = crypto_currency
  end

  def currency_supported?(options, params:, **)
    currency = Currency.where(symbol: params[:currency].upcase).first

    if currency.nil?
      options['errors'] = 'This currency is not supported yet.'
      return false
    end

    options['data.currency'] = currency
  end

  def fetch_current_price!(options, params:, **)
    return true if !expired_cache?(options, params)

    request = request_current_price(params[:crypto_currency], params[:currency])

    if request.success? and request.parsed_response['success']
      options['data.current_price'] = request.parsed_response['ticker']['price']
    else
      options['errors'] = "Impossible to fetch the current price for: #{params[:crypto_currency]}-#{params[:currency]}"
      false
    end
  end

  def update(options, params:, **)
    if !expired_cache?(options, params)
      options['model'] = MarketExchange.where(crypto_currency: options['data.crypto_currency'].id, currency: options['data.currency'].id).order(updated_at: :desc).first
      return
    end

    market_exchange = MarketExchange.create(
      crypto_currency: options['data.crypto_currency'],
      currency: options['data.currency'],
      price: options['data.current_price']
    )

    options['model'] = market_exchange
  end


  private

    def request_current_price(crypto_currency, currency)
      endpoint = "https://api.cryptonator.com/api/ticker/#{crypto_currency}-#{currency}"
      HTTParty.get(endpoint)
    end


    def expired_cache?(options, params)
      return true if params[:force]

      crypto_currency = options['data.crypto_currency'].id
      currency = options['data.currency'].id

      market_exchange = MarketExchange.where(crypto_currency: crypto_currency, currency: currency).order(updated_at: :desc).first

      return true if market_exchange.nil?

      (Time.now - market_exchange.updated_at) > 10.seconds
    end

end

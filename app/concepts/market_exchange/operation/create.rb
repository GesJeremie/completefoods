class MarketExchange::Create < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency_id).filled
    required(:currency_id).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      :fetch_crypto_currency
  success   :prepare_currencies_for_api
  step      :request_market_data
  success   :update_records
  success   :model

  def fetch_crypto_currency(options, params:, **)
    crypto_currency = CryptoCurrency.find_by(id: params[:crypto_currency_id])

    return false if crypto_currency.nil?

    options['data.crypto_currency'] = crypto_currency
  end

  def prepare_currencies_for_api(options, params:, **)
    options['data.currencies'] = Currency.pluck(:code).join(',')
  end

  def request_market_data(options, params:, **)
    return true if !expired_cache?(options, params)

    request = request_current_price(options)

    return false if !request.success?

    options['data.market_data'] = request.parsed_response['RAW']
  end

  def update_records(options, params:, **)
    return true if !expired_cache?(options, params)

    Currency.all.each do |currency|
      update_market_exchange(currency, options)
    end
  end

  def model(options, params:, **)
    model = options['model'] = MarketExchange.where(crypto_currency_id: params[:crypto_currency_id], currency_id: params[:currency_id]).first
    model.present?
  end

  private


    def expired_cache?(options, params)
      crypto_currency = options['data.crypto_currency'].id

      market_exchange = MarketExchange.where(crypto_currency: crypto_currency).first

      return true if market_exchange.nil?

      (Time.now - market_exchange.updated_at) > 10.seconds
    end

    def request_current_price(options)
      symbol = options['data.crypto_currency'].symbol
      currencies = options['data.currencies']

      endpoint = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{symbol}&tsyms=#{currencies}"
      request = HTTParty.get(endpoint)
    end

    def update_market_exchange(currency, options)
      crypto = options['data.crypto_currency']
      market_data = options['data.market_data'][crypto.symbol][currency.code]

      market = MarketExchange.where(crypto_currency_id: crypto.id, currency_id: currency.id).first_or_initialize

      market.assign_attributes(
        price: market_data['PRICE'],
        price_open_24_hours: market_data['OPEN24HOUR'],
        price_high_24_hours: market_data['HIGH24HOUR'],
        price_low_24_hours: market_data['LOW24HOUR'],
        change_percentage_24_hours: market_data['CHANGEPCT24HOUR']
      )

      market.save

    end

end

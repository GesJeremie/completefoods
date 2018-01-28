# TODO: Code is ugly, I should refactor.
class MarketExchange::Create < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency_id).filled
    required(:currency_id).filled
  end)

  step        Contract::Validate(name: 'params'), before: 'operation.new'
  step        :fetch_crypto_currency!
  step        :fetch_market_data!
  success     :update_records
  step        :model!

  def fetch_crypto_currency!(options, params:, **)
    crypto_currency = CryptoCurrency.find_by(id: params[:crypto_currency_id])

    return false if crypto_currency.nil?

    options['data.crypto_currency'] = crypto_currency
  end


  def fetch_market_data!(options, params:, **)
    return true if !expired_cache?(options, params)

    crypto_currency = options['data.crypto_currency']
    currencies = Currency.pluck(:code).join(',') + ',BTC'
    symbols = crypto_currency.symbol + ',BTC'

    endpoint = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{symbols}&tsyms=#{currencies}"
    request = HTTParty.get(endpoint)

    return false if !request.success?

    options['data.market_data'] = request.parsed_response['RAW']
  end

  def update_records(options, params:, **)
    return true if !expired_cache?(options, params)

    crypto_currency = options['data.crypto_currency']

    Currency.all.each do |currency|
      attributes = get_prices_market_data(options, currency.code)

      market = MarketExchange.where(crypto_currency_id: crypto_currency.id, currency_id: currency.id).first_or_initialize

      market.assign_attributes(attributes)
      market.save
    end

  end

  def model!(options, params:, **)
    model = options['model'] = MarketExchange.where(crypto_currency_id: params[:crypto_currency_id], currency_id: params[:currency_id]).first
    model.present?
  end

  private

    def get_prices_market_data(options, currency_code)
      market_data = options['data.market_data']
      crypto_currency = options['data.crypto_currency']

      if options['data.crypto_currency'].symbol == 'BTC'
        {
          price: market_data['BTC'][currency_code]['PRICE'],
          price_open_24_hours: market_data['BTC'][currency_code]['OPEN24HOUR'],
          price_high_24_hours: market_data['BTC'][currency_code]['HIGH24HOUR'],
          price_low_24_hours: market_data['BTC'][currency_code]['LOW24HOUR']
        }
      else
        {
          price: market_data['BTC'][currency_code]['PRICE'] * market_data[crypto_currency.symbol]['BTC']['PRICE'],
          price_open_24_hours: market_data['BTC'][currency_code]['OPEN24HOUR'] * market_data[crypto_currency.symbol]['BTC']['OPEN24HOUR'],
          price_high_24_hours: market_data['BTC'][currency_code]['HIGH24HOUR'] * market_data[crypto_currency.symbol]['BTC']['HIGH24HOUR'],
          price_low_24_hours: market_data['BTC'][currency_code]['LOW24HOUR'] * market_data[crypto_currency.symbol]['BTC']['LOW24HOUR']
        }
      end
    end

    def expired_cache?(options, params)
      crypto_currency = options['data.crypto_currency'].id

      market_exchange = MarketExchange.where(crypto_currency: crypto_currency).first

      return true if market_exchange.nil?

      (Time.now - market_exchange.updated_at) > 10.seconds
    end

end

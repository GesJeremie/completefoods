class MarketExchange::Update < Trailblazer::Operation
  extend Contract::DSL

  contract 'params' do
    property :crypto_currency
    property :fiat_currency

    validates :crypto_currency, presence: true
    validates :fiat_currency, presence: true
  end

  step Contract::Validate(name: 'params'), before: 'operation.new'
  step :crypto_currency_supported!
  step :fetch_current_price
  success :update

  def crypto_currency_supported!(options, params:, **)
    exists = CryptoCurrency.exists?(symbol: params[:crypto_currency].upcase)

    if exists
      true
    else
      options['errors'] = 'This crypto currency is not supported yet.'
      false
    end
  end

  def fetch_current_price(options, params:, **)
    endpoint = "https://api.cryptonator.com/api/ticker/#{params[:crypto_currency]}-#{params[:fiat_currency]}"
    request = HTTParty.get(endpoint)

    if request.success? and request.parsed_response['success']
      options['data.current_price'] = request.parsed_response['ticker']['price']
      true
    else
      options['errors'] = "Impossible to fetch the current price for: #{params[:crypto_currency]}-#{params[:fiat_currency]}"
    end
  end

  def update(options, params:, **)
    market_exchange = MarketExchange.new(
      crypto_currency: params[:crypto_currency].upcase,
      fiat_currency: params[:fiat_currency].upcase,
      price: options['data.current_price']
    ).save

    options['model'] = market_exchange
  end


end

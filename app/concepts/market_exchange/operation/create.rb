class MarketExchange::Create < Trailblazer::Operation
  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:crypto_currency_ids).filled
    required(:currency_id).filled
  end)

  step    Contract::Validate(name: 'params'), before: 'operation.new'
  success :fetch_prices

  def fetch_prices(options, params:, **)
    currency_id = params[:currency_id]

    prices = params[:crypto_currency_ids].map do |crypto_currency_id|
      fetch_price(currency_id, crypto_currency_id)
    end

    options['model'] = prices
  end

  private

    def fetch_price(currency_id, crypto_currency_id)
      MarketExchange::Update.({
        currency_id: currency_id,
        crypto_currency_id: crypto_currency_id
      })['model']
    end
end

class Tasks::SeedCryptoCurrencies < Trailblazer::Operation

  step     :fetch_crypto_currencies!
  success  :seed

  def fetch_crypto_currencies!(options, params:, **)
    response = HTTParty.get('https://min-api.cryptocompare.com/data/all/coinlist')

    if response.success?
      body = JSON.parse(response.body)
      options['data.coins'] = body['Data']
    else
      false
    end
  end

  def seed(options, params:, **)
    options['data.coins'].each do |coin|
      coin = coin.last
      name = coin['CoinName']
      symbol = coin['Symbol']

      return if CryptoCurrency.exists?(symbol: symbol)

      crypto = CryptoCurrency.create(
        name: name,
        symbol: symbol
      )
    end
  end

end

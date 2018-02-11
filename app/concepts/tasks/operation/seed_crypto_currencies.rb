class Tasks::SeedCryptoCurrencies < Trailblazer::Operation

  step     :fetch_crypto_currencies!
  success  :seed

  def fetch_crypto_currencies!(options, params:, **)
    puts "Seeding crypto currencies"

    response = HTTParty.get('https://min-api.cryptocompare.com/data/all/coinlist')

    return false if !response.success?

    options['data.coins'] = JSON.parse(response.body)['Data']
  end

  def seed(options, params:, **)
    options['data.coins'].each do |coin|
      add_crypto_currency(coin.last)
    end
  end

  private

    def add_crypto_currency(coin)
      name = coin['CoinName']
      symbol = coin['Symbol']
      media = coin['ImageUrl']

      return if CryptoCurrency.exists?(symbol: symbol)

      CryptoCurrency.create(
        name: name,
        symbol: symbol,
        media: media
      )

      puts "Crypto currency #{symbol} added"
    end

end

class Tasks::SeedCryptoCurrencies < Trailblazer::Operation

  step     :fetch_crypto_currencies!
  success  :seed

  def fetch_crypto_currencies!(options, params:, **)
    puts "Seeding crypto currencies"

    response = HTTParty.get('https://min-api.cryptocompare.com/data/all/coinlist')

    if !response.success?
      puts "Impossible to connect to the api cryptocompare.com".red
      false
    else
      options['data.coins'] = JSON.parse(response.body)['Data']
    end
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

      crypto_currency = CryptoCurrency.find_by(symbol: symbol)

      if crypto_currency.present?

        crypto_currency.update(media: media)
        puts "Crypto currency #{symbol}, added media".green

      else
        CryptoCurrency.create(
          name: name,
          symbol: symbol,
          media: media
        )

        puts "Crypto currency #{symbol} added".green

      end

    end

end

class Tasks::SeedCryptoCurrencies < Trailblazer::Operation

  step     :fetch_crypto_currencies!
  success  :seed

  def fetch_crypto_currencies!(options, params:, **)
    puts "Seeding crypto currencies"

    response = HTTParty.get('https://min-api.cryptocompare.com/data/all/coinlist')

    if !response.success?
      puts "[ERROR] Impossible to connect to the api cryptocompare.com"
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

      if !crypto_currency.present?
        CryptoCurrency.create(
          name: name,
          symbol: symbol,
          media: media
        )

        puts "#{symbol} - NEW - Coin and media added."
      end

      if crypto_currency.present? and crypto_currency.media.nil?

        if media.nil?
          puts "#{symbol} - UPDATE - Media missing, crypto compare does not have it, pass!."
        else
          crypto_currency.update(media: media)
          puts "#{symbol} - UPDATE - Media missing, media added."
        end

      end

    end

end

class Home::Index < Trailblazer::Operation
  extend Contract::DSL

  success :create_user_and_folio_needed?
  success :fetch_crypto_currencies

  def create_user_and_folio_needed?(options, params:, **)
    if options['current_user'].nil?
      user = create_user_anonymous
      folio = create_folio(user.token)
      add_crypto_currencies(user, folio.id)
    else
      user = options['current_user']
      folio = Folio.where(user_id: user.id).first
    end

    options['data.user'] = user
    options['data.folio'] = folio
  end

  def fetch_crypto_currencies(options, params:, **)
    options['data.crypto_currencies'] = CryptoCurrency.all
  end


  private

    def create_user_anonymous
      UserAnonymous::Create.()['model']
    end

    def create_folio(user_token)
      Folio.Create.(user_token: user_token)['model']
    end

    def add_crypto_currencies(user, folio_id)
      %w(BTC BCH ETH LTC XRP).each do |symbol|
        add_crypto_currency(user, folio_id, symbol)
      end
    end

    def add_crypto_currency(user, folio_id, crypto_currency_symbol)
      crypto_currency = CryptoCurrency.where(symbol: crypto_currency_symbol).first

      FolioCryptoCurrency::Create.({
        crypto_currency_id: crypto_currency.id,
        folio_id: folio_id
      }, 'current_user' => user)
    end

end

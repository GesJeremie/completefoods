require 'test_helper'

class AddCryptoCurrencyTest < ActiveSupport::TestCase

  test 'create' do
    crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
    user = User::CreateAnonymous.()['model']
    folio = Folio::Create.(user_token: user.token)['model']

    folio_crypto_currency = Folio::AddCryptoCurrency.({
        crypto_currency_id: crypto_currency.id,
        folio_id: folio.id
      }, 'current_user' => user)

    model = folio_crypto_currency['model']

    assert folio_crypto_currency.success?

    assert model.holding == 0
    assert model.folio_id.present?
    assert model.crypto_currency_id.present?
  end

end

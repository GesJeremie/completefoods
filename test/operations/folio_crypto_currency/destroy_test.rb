require 'test_helper'

class FolioCryptoCurrencyDestroyTest < ActiveSupport::TestCase

  test 'destroy crypto currency' do
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)['model']
    crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
    folio_crypto_currency = FolioCryptoCurrency::Create.({crypto_currency_id: crypto_currency.id}, 'current_user' => user.reload)['model']

    result = FolioCryptoCurrency::Destroy.({id: folio_crypto_currency.id}, 'current_user' => user.reload)

    assert result.success?
  end
end

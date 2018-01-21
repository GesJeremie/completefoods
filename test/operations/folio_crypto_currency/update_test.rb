require 'test_helper'

class FolioCryptoCurrencyUpdateTest < ActiveSupport::TestCase

  test 'update folio crypto currency' do
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)['model']
    crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
    folio_crypto_currency = FolioCryptoCurrency::Create.({crypto_currency_id: crypto_currency.id}, 'current_user' => user.reload)['model']

    result = FolioCryptoCurrency::Update.({id: folio_crypto_currency.id, holding: 10.85}, 'current_user' => user)
    model = result['model']

    assert result.success?
    assert model.holding == 10.85
  end

end

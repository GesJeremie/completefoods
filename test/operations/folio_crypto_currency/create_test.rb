require 'test_helper'

class FolioCryptoCurrencyCreateTest < ActiveSupport::TestCase

  test 'create folio crypto currency' do
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)['model']
    crypto_currency = CryptoCurrency.where(symbol: 'BTC').first

    result = FolioCryptoCurrency::Create.({crypto_currency_id: crypto_currency.id}, 'current_user' => user.reload)
    model = result['model']

    assert result.success?
    assert model.crypto_currency_id == crypto_currency.id
    assert model.folio_id == folio.id
  end

  test 'can\'t add duplicate crypto currency' do
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)['model']
    crypto_currency = CryptoCurrency.where(symbol: 'BTC').first

    folio1 = FolioCryptoCurrency::Create.({crypto_currency_id: crypto_currency.id}, 'current_user' => user.reload)
    folio2 = FolioCryptoCurrency::Create.({crypto_currency_id: crypto_currency.id}, 'current_user' => user.reload)

    assert folio1.success?
    assert !folio2.success?
  end
end

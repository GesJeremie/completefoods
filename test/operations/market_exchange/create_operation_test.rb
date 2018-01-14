require 'test_helper'

class MarketExchangeCreateTest < ActiveSupport::TestCase

  test 'create' do
    result = MarketExchange::Create.(crypto_currency: 'BTC', currency: 'EUR')
    model = result['model']

    assert result.success?
    assert model.crypto_currency_id.present?
    assert model.currency_id.present?
    assert model.price.present?
  end

  test 'cache system' do
    result = MarketExchange::Create.(crypto_currency: 'BTC', currency: 'EUR')
    result_with_cache = MarketExchange::Create.(crypto_currency: 'BTC', currency: 'EUR')

    assert result['model'].id == result_with_cache['model'].id
  end

  test 'force option' do
    result = MarketExchange::Create.(crypto_currency: 'BTC', currency: 'EUR')
    result_force = MarketExchange::Create.(crypto_currency: 'BTC', currency: 'EUR', force: true)

    assert result['model'].id != result_force['model'].id

  end

end

require 'test_helper'

class SettingsCurrencyCreateTest < ActiveSupport::TestCase

  test 'update currency' do
    currency_id = Currency.last.id
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)

    result = SettingsCurrency::Create.({currency_id: currency_id}, 'current_user' => user.reload)
    model = result['model']

    assert result.success?
    assert model.currency_id = currency_id
  end

  test 'can\'t update if no folio' do
    currency_id = Currency.last.id
    user = UserAnonymous::Create.()['model']

    result = SettingsCurrency::Create.({currency_id: currency_id}, 'current_user' => user)

    assert !result.success?
  end

  test 'can\'t update if currency does not exist' do
    user = UserAnonymous::Create.()['model']
    folio = Folio::Create.({}, 'current_user' => user)

    result = SettingsCurrency::Create.({currency_id: 150}, 'current_user' => user)

    assert !result.success?
  end

end

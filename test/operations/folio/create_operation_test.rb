require 'test_helper'

class FolioCreateTest < ActiveSupport::TestCase

  test 'create folio' do
    user = User::CreateAnonymous.()
    folio = Folio::Create.(user_token: user['model'].token)
    model = folio['model']

    assert folio.success?
    assert model.user_id.present?
    assert model.currency_id.present?
  end

  test 'doesn\'t create if user doesn\'t exist' do
    folio = Folio::Create.(user_token: 'fake-token')

    assert !folio.success?
  end

  test 'can only create one folio per user' do
    user = User::CreateAnonymous.()
    folio_first = Folio::Create.(user_token: user['model'].token)
    folio_second = Folio::Create.(user_token: user['model'].token)

    assert folio_first.success?
    assert !folio_second.success?
  end

end

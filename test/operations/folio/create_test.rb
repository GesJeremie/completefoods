require 'test_helper'

class FolioCreateTest < ActiveSupport::TestCase

  test 'create folio' do
    result = Folio::Create.({}, 'current_user' => UserAnonymous::Create.()['model'])
    model = result['model']

    assert result.success?
    assert model.currency_id.present?
    assert model.user_id.present?
  end

  test 'no duplicate folio' do
    user = UserAnonymous::Create.()['model']

    folio1 = Folio::Create.({}, 'current_user' => user)
    folio2 = Folio::Create.({}, 'current_user' => user)

    assert folio1.success?
    assert !folio2.success?
  end

end

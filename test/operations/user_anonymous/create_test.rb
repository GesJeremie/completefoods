require 'test_helper'

class UserAnonymousCreateTest < ActiveSupport::TestCase

  test 'create anonymous user' do
    result = UserAnonymous::Create.()
    model = result['model']

    assert result.success?
    assert model.email.nil?
    assert model.password.nil?
    assert model.token.present?
  end

end

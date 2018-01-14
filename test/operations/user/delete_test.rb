require 'test_helper'

class UserDeleteTest < ActiveSupport::TestCase

  test 'delete user' do
    user = User::Create.(email: 'hello@example.com', password: 'fakePassword')['model']
    result = User::Delete.({user_id: user.id}, 'current_user' => user)

    assert result.success?
  end

  test 'can\'t delete other user' do
    peter = User::Create.(email: 'peter@example.com', password: 'fakePassword')['model']
    bryan = User::Create.(email: 'bryan@example.com', password: 'fakePassword')['model']

    result = User::Delete.({user_id: bryan.id}, 'current_user' => peter)

    assert result.failure?
  end
end

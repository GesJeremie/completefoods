require 'test_helper'

class UserCreateAnonymousTest < ActiveSupport::TestCase

  test 'create user' do
    result = User::CreateAnonymous.()
    model = result['model']

    assert model.email.nil?
    assert model.password.nil?
    assert model.token.present?
  end

  test 'doesn\'t create duplicate token' do
    User::CreateAnonymous.()['model'].token != User::CreateAnonymous.()['model'].token
  end

end

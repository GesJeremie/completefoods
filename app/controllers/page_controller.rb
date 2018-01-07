class PageController < ApplicationController

  def home
    # Check if session exists,
    # else
    # - create anonymous user
    # - create folio with anonymous attached
    # - add default alt coins
    operation = User::CreateAnonymous.()
    user_token = operation['model'].token

    Folio::Create.(current_user: user_token)

  end
end

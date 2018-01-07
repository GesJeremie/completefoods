class PageController < ApplicationController

  def home
    # Check if session exists,
    # else
    # - create anonymous user
    # - create folio with anonymous attached
    operation = User::CreateAnonymous.()
    token = operation['model'].token


  end
end

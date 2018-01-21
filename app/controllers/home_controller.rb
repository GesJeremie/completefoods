class HomeController < ApplicationController

  def index

    op = Home::Index.({}, 'current_user' => current_user)

    @user = op['data.user']
    @folio = op['data.folio']
    @crypto_currencies = op['data.crypto_currencies']
  end
end

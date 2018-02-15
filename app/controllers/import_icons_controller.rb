class ImportIconsController < ApplicationController

  def index

    if Rails.env.production?
      return redirect_to root_path
    end

    @crypto_currencies = CryptoCurrency.all

    render layout: false
  end
end

class FolioCryptoCurrencyController < ApplicationController

  def create
    op = FolioCryptoCurrency::Create.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = '[COIN_SYMBOL] added'
    else
      flash[:error] = 'Impossible to add this crypto currency'
    end

    redirect_back fallback_location: '/'
  end

  def delete
  end

  def update
  end
end

class FolioCryptoCurrencyController < ApplicationController

  def create
    op = FolioCryptoCurrency::Create.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = "#{op['model'].crypto_currency.name} added"
    else
      flash[:error] = 'Impossible to add this asset'
    end

    redirect_back fallback_location: '/'
  end

  def destroy
    op = FolioCryptoCurrency::Destroy.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = 'Asset deleted!'
    else
      flash[:error] = 'Impossible to remove this asset'
    end

    redirect_back fallback_location: '/'
  end

end

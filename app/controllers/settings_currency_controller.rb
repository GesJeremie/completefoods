class SettingsCurrencyController < ApplicationController

  def create
    op = SettingsCurrency::Create.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = 'Currency updated'
    else
      flash[:error] = 'Impossible to update the currency'
    end

    redirect_to settings_path
  end
end

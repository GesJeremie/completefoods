class SettingsCurrencyController < ApplicationController

  def create
    op = SettingsCurrency::Create.(params, 'current_user' => current_user)

    if op.success?
      render json: {}, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end

  end
end

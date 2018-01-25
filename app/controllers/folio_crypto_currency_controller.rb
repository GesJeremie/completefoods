class FolioCryptoCurrencyController < ApplicationController

  def create
    op = FolioCryptoCurrency::Create.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = "#{op['model'].crypto_currency.name} added"
    else
      flash[:error] = 'Impossible to add this asset'
    end

    redirect_to root_path
  end

  def destroy
    op = FolioCryptoCurrency::Destroy.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = 'Asset deleted'
    else
      flash[:error] = 'Impossible to remove this asset'
    end

    redirect_to root_path
  end

  def update
    op = FolioCryptoCurrency::Update.(params, 'current_user' => current_user)

    # TODO: Improve
    if request.format.json? and op.success?
      return render json: {}, status: :ok
    end

    if request.format.json? and !op.success?
      return render json: {}, status: :unprocessable_entity
    end

    if op.success?
      flash[:success] = 'Asset updated'
    else
      flash[:error] = 'Impossible to update the asset'
    end

    redirect_to root_path

  end

end

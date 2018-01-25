class MarketExchangeController < ApplicationController

  def create
    op = MarketExchange::Create.(params)

    # TODO: Improve
    if request.format.json? and op.success?
      return render json: op['model'], status: :ok
    end

    if request.format.json? and !op.success?
      return render json: {}, status: :unprocessable_entity
    end

    if op.success?
      flash[:success] = 'Market Exchange updated'
    else
      flash[:error] = 'Impossible to update the market exchange'
    end

    redirect_to root_path
  end
end

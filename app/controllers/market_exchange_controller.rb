class MarketExchangeController < ApplicationController

  def create
    op = MarketExchange::Create.(params)

    if op.success?
      render json: op['model'], status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

end

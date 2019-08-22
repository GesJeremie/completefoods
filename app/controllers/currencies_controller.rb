class CurrenciesController < BaseController
  def index
    model = Currency.popular
    @currencies = CurrencyViewModel.wrap(model, view_model_options)
  end

  def update
    if allowed_code?
      session[:current_currency] = currency_params[:code]
    else
      flash[:error] = "This currency doesn't exist"
    end

    redirect_back fallback_location: root_path
  end

  private

  def currency_params
    params.permit(:code)
  end

  def allowed_code?
    Currency::POPULAR_CURRENCIES.include?(currency_params[:code])
  end
end

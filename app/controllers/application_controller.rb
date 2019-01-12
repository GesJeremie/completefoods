class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_currency

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

  def current_currency
    @current_currency ||=
      begin
        Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
      end
  end

  def view_model_options
    params.to_unsafe_h.merge(
      current_user: current_currency,
      current_currency: current_currency
    )
  end
end

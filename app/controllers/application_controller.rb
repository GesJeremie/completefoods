class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def current_user
      @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    def current_currency
      Currency.find_by_code(params[:currency]) || Currency.find_by_code('USD')
    end
end

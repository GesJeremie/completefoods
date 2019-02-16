class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :redirect_if_old_domain

  def current_currency
    @current_currency ||= begin
        Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
      end
  end
  helper_method :current_currency

  def view_model_options
    params.to_unsafe_h.merge(
      current_currency: current_currency
    )
  end

  private
    def redirect_if_old_domain
      return unless Rails.env.production?

      if ['www.soylent-alternatives.com', 'soylent-alternatives.com'].include?(request.host)
        redirect_to "#{request.protocol}completefood.guru#{request.fullpath}", :status => :moved_permanently
      end
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :redirect_if_old_domain
  before_action :authenticate, if: :admin_controller?
  helper_method :current_currency

  OLD_DOMAINS = ['www.soylent-alternatives.com', 'soylent-alternatives.com'].freeze

  def current_currency
    @current_currency ||= Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
  end

  def view_model_options
    params.to_unsafe_h.merge(
      current_currency: current_currency
    )
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |user, password|
      basic_auth = CompleteFoods.config.basic_auth
      (user == basic_auth[:user]) && (password == basic_auth[:password])
    end
  end

  def redirect_if_old_domain
    return unless Rails.env.production?

    if OLD_DOMAINS.include?(current_domain)
      redirect_to new_domain, status: :moved_permanently
    end
  end

  def admin_controller?
    self.class < ActiveAdmin::BaseController
  end

  def current_domain
    request.host
  end

  def new_domain
    "#{request.protocol}completefood.guru#{request.fullpath}"
  end
end

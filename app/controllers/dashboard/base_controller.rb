class Dashboard::BaseController < ApplicationController
  http_basic_authenticate_with name: ENV['DASHBOARD_ADMIN_NAME'], password: ENV['DASHBOARD_ADMIN_PASSWORD']
  layout 'dashboard'

  def view_model_options
    {}
  end
end

class BaseController < ApplicationController
  layout :current_layout

  def current_layout
    request.xhr? ? false : 'app'
  end
end

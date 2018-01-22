class UserDisconnectController < ApplicationController

  def create
    reset_session

    flash[:success] = 'Logged out'

    redirect_back fallback_location: '/'
  end
end

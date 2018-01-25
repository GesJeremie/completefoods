class UserDisconnectController < ApplicationController

  def create
    reset_session

    flash[:success] = 'Logged out'

    redirect_to root_path
  end
end

class UserConnectController < ApplicationController

  def create
    op = UserConnect::Create.(params)

    if op.success?
      session['current_user_id'] = op['data.user'].id
      flash[:success] = 'Welcome back'
    else
      flash[:error] = 'Impossible to connect with this email/password'
    end

    redirect_to root_path
  end
end

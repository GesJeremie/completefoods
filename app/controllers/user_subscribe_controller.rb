class UserSubscribeController < ApplicationController

  def create
    op = UserSubscribe::Create.(params, 'current_user' => current_user)

    if op.success?
      flash[:success] = 'Folio saved and account created'
    else
      flash[:error] = 'Impossible to save your folio'
    end

    redirect_back fallback_location: '/'
  end
end

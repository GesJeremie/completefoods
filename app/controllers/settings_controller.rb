class SettingsController < ApplicationController

  def index
    # TODO: if current user nil? redirect to home page
    @user = current_user
    @currencies = Currency.all
  end
end

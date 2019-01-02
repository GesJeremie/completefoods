class Api::NewslettersController < Api::BaseController

  def create
    @newsletter = Newsletter.new(newsletter_params)
    session[:newsletter_try] = true
  end

  private

    def newsletter_params
      params.permit(:email)
    end
end

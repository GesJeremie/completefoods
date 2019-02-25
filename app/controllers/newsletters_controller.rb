class NewslettersController < BaseController

  def create
    model = Newsletter.new(newsletter_params)

    if model.save
      flash[:success] = 'Noted! We will let you know!'
      session[:newsletter_try] = true
    else
      flash[:error] = 'You are already enrolled'
    end
  end

  def show
  end

  private

    def newsletter_params
      params.permit(:email)
    end
end

class NewslettersController < BaseController
  def create
    model = Newsletter.new(newsletter_params)

    if model.save
      flash.now[:success] = 'Noted - We will let you know!'
    else
      flash.now[:error] = 'Sorry - You are already enrolled!'
    end

    render :show
  end

  def show
  end

  private

  def newsletter_params
    params.permit(:email)
  end
end

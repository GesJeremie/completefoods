class Dashboard::NewslettersController < Dashboard::BaseController
  def index
    @newsletters = Newsletter.order(created_at: :desc).all
  end
end

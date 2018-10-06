class Dashboard::NewslettersController < Dashboard::BaseController
  def index
    @newsletters = Newsletter.order(created_at: :desc).all
  end

  def destroy
    if Newsletter.find(params[:id]).destroy
      redirect_to dashboard_newsletters_path, notice: 'Newsletter was successfully destroyed.'
    else
      redirect_to dashboard_newsletters_path, error: 'Newsletter was notsuccessfully destroyed.'
    end
  end
end

class Dashboard::GurusController < Dashboard::BaseController
  def index
    @gurus = Wizard.recent.paginate(page: params[:page])
  end
end

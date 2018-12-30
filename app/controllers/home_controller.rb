class HomeController < BaseController
  def index
    @view_model = ApplicationViewModel.new
  end
end

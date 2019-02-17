class Dashboard::GurusController < Dashboard::BaseController
  def index
    @gurus = Wizard.all
  end
end

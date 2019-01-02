class PagesController < BaseController
  def home
    @view_model = Pages::HomeViewModel.new
  end

  def what_is_a_complete_food; end
end

class PagesController < BaseController
  def home
    @page = PageViewModel.wrap(nil, view_model_options)
  end

  def what_is_a_complete_food; end
end

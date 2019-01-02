class ApplicationViewModel
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  def count_active_products
    @count_active_products ||= Product.active.count
  end
end

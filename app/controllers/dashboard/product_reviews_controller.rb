class Dashboard::ProductReviewsController < Dashboard::BaseController
  def index
    model = ProductReview.all
    @reviews = ProductReviewViewModel.wrap(model)
  end

  def destroy
    if ProductReview.find(params[:id]).destroy
      redirect_to dashboard_product_reviews_path, notice: 'Product Review was successfully destroyed.'
    else
      redirect_to dashboard_product_reviews_path, error: 'Product Review was not successfully destroyed.'
    end
  end
end

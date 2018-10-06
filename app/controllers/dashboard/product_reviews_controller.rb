class Dashboard::ProductReviewsController < Dashboard::BaseController
  def index
    @product_reviews = ProductReview.all
    @product_reviews = ProductReviewDecorator.decorate_collection(@product_reviews)
  end

  def destroy
    if ProductReview.find(params[:id]).destroy
      redirect_to dashboard_product_reviews_path, notice: 'Product Review was successfully destroyed.'
    else
      redirect_to dashboard_product_reviews_path, error: 'Product Review was not successfully destroyed.'
    end
  end
end

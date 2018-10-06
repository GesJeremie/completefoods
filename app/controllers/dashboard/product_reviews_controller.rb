class Dashboard::ProductReviewsController < Dashboard::BaseController
  def index
    @product_reviews = ProductReview.all
    @product_reviews = ProductReviewDecorator.decorate_collection(@product_reviews)
  end

  def destroy
    @product_review = ProductReview.find(params[:id])
    @product_review.destroy

    redirect_to dashboard_product_reviews_path, notice: 'Product Review was successfully destroyed.'
  end
end

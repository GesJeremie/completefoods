class Api::ProductReviewsController < Api::BaseController

  def show
    @product = Product.find(params[:id])
  end

  def create
    return if voted_for_product?

    review = ProductReview.new(review_params)

    if review.save
      @success = true
    else
      @success = false
      @errors = review.errors.full_messages.to_sentence
    end
  end

  private

    def voted_for_product?
      return false unless already_voted?

      @success = false
      @errors = 'Sorry - You already wrote a review for this product!'

      return true
    end

    def already_voted?
       ProductReview.where(
        product_id: review_params[:product_id],
        ip: review_params[:ip]
      ).exists?
    end

    def review_params
      @review_params ||=
        begin
          params[:ip] = request.remote_ip
          params.permit(:score, :description, :ip, :product_id)
        end
    end
end

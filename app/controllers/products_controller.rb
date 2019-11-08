class ProductsController < BaseController
  before_action :set_model, only: [:show, :vote]

  def index
    @browse = BrowseProductsViewModel.new(nil, view_model_options)
  end

  def show
  end

  def vote
    @vote = ProductVote.new(vote_params)

    if @vote.save
      flash.now[:success] = '<strong>Whoop, whoop!</strong> - Thanks for the feedback, an admin will review it!'
    else
      flash.now[:error] = '<strong>Oh No!</strong> - We are unable to save your review.'
    end

    render :show
  end

  private

  def set_model
    model = Product.find_by!(slug: params[:slug])
    options = view_model_options.merge(current_ip: request.ip)

    @product = ProductViewModel.wrap(model, options)
  end

  def vote_params
    params.permit(:recommend, :reason).merge(
      ip: request.ip,
      product_id: @product.id
    )
  end
end

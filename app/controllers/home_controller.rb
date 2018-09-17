class HomeController < BaseController
  def index
    @products = ProductFinder.new(params).execute

    unless sorting?
      @products = @products.reorder(:brand_id)
    end

    @products = ProductDecorator.decorate_collection(@products)

    @sorters = Rails.configuration.sorters
  end


  private

    def sorting?
      sort? || narrow?
    end

    def sort?
      params[:sort].present? && params[:sort] != 'nothing'
    end

    def narrow?
      params[:narrow].present? && params[:narrow] != 'nothing'
    end
end

class SearchController < BaseController

  def index
    country_name = params[:country].split('-').map(&:downcase).join(' ')
    country_id = Country.where('lower(name) = ?', country_name).first.id

    @products = Product.joins(:brand).where('brands.country_id': country_id)
    @products = ProductDecorator.decorate_collection(@products, context: {
      currency: get_currency
    })
  end

  private

    def get_currency
      Currency.find_by_code(params[:currency]) || Currency.find_by_code('USD')
    end
end

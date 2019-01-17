class ProductMadeInFinder
  attr_reader :products, :params

  # Examples:
  # ProductMadeInFinder.new(Product.all, { made_in: 'netherlands' }).execute

  def initialize(products, params = {})
    @products = products
    @params = params
  end

  def execute
    return products unless params[:made_in]&.present?
    return products unless country_id.present?
    return products if params[:made_in] == 'everywhere'

    products.joins(:brand).where(brands: { country_id: country_id })
  end

    private

      def country_id
        @country_id ||= Country.where('lower(name) = ?', params[:made_in].titleize.downcase).first&.id
      end

end

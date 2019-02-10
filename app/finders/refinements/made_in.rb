class Refinements::MadeIn
  attr_reader :products
  attr_reader :country

  # Examples:
  # Refinements::MadeIn.new(Product.all, :united_states).perform

  def initialize(products, country)
    @products = products
    @country = country
  end

  def perform
    return products unless country_id.present?

    products.joins(:brand).where(brands: { country_id: country_id } )
  end

  private
    def country_id
      @country_id ||= Country.where('lower(name) = ?', country.to_s.titleize.downcase).first&.id
    end
end

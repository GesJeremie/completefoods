class Brands::ShowViewModel < BrandsViewModel
  attr_reader :brand

  def initialize(brand:)
    @brand = brand.decorate
  end

  def active_products
    @active_products ||= active_products_brand(brand)
  end

  def description
    return brand.description if brand.description.present?

    generic_description
  end

  private

    def generic_description
      "#{brand.name} is a brand based in #{brand.flag} #{brand.country.name} currently producing #{pluralize_active_products}."
    end

    def pluralize_active_products
      pluralize(active_products.count, 'product')
    end
end

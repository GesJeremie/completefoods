class BrandViewModel < ApplicationViewModel
  def name
    model.name.capitalize
  end

  def description
    return model.description if model.description.present?

    generic_description
  end

  def country_code_symbol
    model.country.code.downcase.to_sym
  end

  def active_products
    @active_products ||= ProductViewModel.wrap(products.active, options)
  end

  private

    def generic_description
      "#{model.name} is a brand based in #{model.country.name} currently producing #{pluralize(active_products.count, 'product')}"
    end
end

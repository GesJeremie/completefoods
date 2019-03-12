require 'uri'

class BrandViewModel < ApplicationViewModel
  def meta_description
    strip_tags(description)
  end

  def name
    model.name.capitalize
  end

  def website
    return unless model.website.present?

    website_with_utm_source
  end

  def description
    return model.description if model.description.present?

    generic_description
  end

  def country_code_symbol
    model.country.code.downcase.to_sym
  end

  def products
    @products ||= ProductViewModel.wrap(
      model.products.reorder('products.name asc'),
      options
    )
  end

  def active_products
    @active_products ||= ProductViewModel.wrap(
      model.products.reorder('products.name asc').active,
      options
    )
  end

  private
    def generic_description
      "#{model.name} is a brand based in #{model.country.name} currently producing #{pluralize(active_products.count, 'complete food')}"
    end

    def website_with_utm_source
      uri = URI.parse(model.website)
      uri.query = [uri.query, 'utm_source=completefood.guru'].compact.join('&')
      uri.to_s
    end
end

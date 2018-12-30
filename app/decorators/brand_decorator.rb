class BrandDecorator < Draper::Decorator
  delegate_all

  decorates_association :products

  def name
    object.name.capitalize
  end

  def flag
    country = object.country.code.downcase.to_sym
    h.flag_icon(country)
  end
end

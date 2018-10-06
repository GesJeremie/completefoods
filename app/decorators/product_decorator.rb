class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :brand
  decorates_association :review

  def flag
    country = product.brand.country.code.downcase.to_sym
    h.flag_icon(country)
  end

  def name
    object.name.capitalize
  end

  def kcal_per_serving
    decimal(object.kcal_per_serving, 0)
  end

  def protein_per_serving
    decimal(object.protein_per_serving, 2)
  end

  def carbs_per_serving
    decimal(object.carbs_per_serving, 2)
  end

  def fat_per_serving
    decimal(object.fat_per_serving, 2)
  end

  def image_url
    h.url_for(product.image.variant(resize: '200x200').processed)
  end

  def image_small_url
    h.url_for(product.image.variant(resize: '100x100').processed)
  end

  private

    def decimal(number, precision)
      sprintf("%.#{precision}f", number)
    end
end

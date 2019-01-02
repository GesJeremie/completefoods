class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :brand
  decorates_association :reviews

  def has_notes?
    product.notes.present?
  end

  def flag
    country = product.brand.country.code.downcase.to_sym
    h.flag_icon(country)
  end

  def name
    product.name.capitalize
  end

  def kcal_per_serving
    decimal(product.kcal_per_serving, 0)
  end

  def protein_per_kcal(kcal)
    (kcal * product.protein_per_serving) / product.kcal_per_serving
  end

  def protein_per_serving
    decimal(product.protein_per_serving, 2)
  end

  def carbs_per_kcal(kcal)
    (kcal * product.carbs_per_serving) / product.kcal_per_serving
  end

  def carbs_per_serving
    decimal(product.carbs_per_serving, 2)
  end

  def fat_per_kcal(kcal)
    (kcal * product.fat_per_serving) / product.kcal_per_serving
  end

  def fat_per_serving
    decimal(product.fat_per_serving, 2)
  end

  def image_url
    h.url_for(product.image.variant(resize: '200x200').processed)
  end

  def image_small_url
    h.url_for(product.image.variant(resize: '100x100').processed)
  end

  #def cost_per_month_bulk_order
    #cost_per_month = product.price.per_month_bulk_order_in_currency('USD')
    #h.from_usd_to_current_currency(cost_per_month)
  #end

  #def cost_per_100_kcal_bulk_order
    #cost_per_100kcal = product.price.per_100kcal_bulk_order_in_currency('USD')
    #h.from_usd_to_current_currency(cost_per_100kcal)
  #end

  private

    def decimal(number, precision)
      sprintf("%.#{precision}f", number)
    end
end

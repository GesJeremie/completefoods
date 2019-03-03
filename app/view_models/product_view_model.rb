class ProductViewModel < ApplicationViewModel
  def has_notes?
    model.notes.present?
  end

  def name
    model.name.capitalize
  end

  def country_code_symbol
    model.brand.country.code.downcase.to_sym
  end

  def description
    return if model.description.empty?

    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      tables: true
    ).render(model.description).html_safe
  end

  def brand
    @brand ||= BrandViewModel.wrap(model.brand, options)
  end

  def reviews
    @reviews ||= ProductReviewViewModel.wrap(model.reviews, options)
  end

  def kcal_per_serving
    decimal(model.kcal_per_serving, 0)
  end

  def protein_per_kcal(kcal)
    protein = (kcal * model.protein_per_serving) / model.kcal_per_serving
    decimal(protein, 2)
  end

  def protein_per_serving
    decimal(model.protein_per_serving, 2)
  end

  def carbs_per_kcal(kcal)
    carbs = (kcal * model.carbs_per_serving) / model.kcal_per_serving
    decimal(carbs, 2)
  end

  def carbs_per_serving
    decimal(model.carbs_per_serving, 2)
  end

  def fat_per_kcal(kcal)
    fat = (kcal * model.fat_per_serving) / model.kcal_per_serving
    decimal(fat, 2)
  end

  def fat_per_serving
    decimal(model.fat_per_serving, 2)
  end

  def image
    model.image.variant(resize: '200x200')
  end

  def image_small
    model.image.variant(resize: '100x100')
  end

  private

    def decimal(number, precision)
      sprintf("%.#{precision}f", number)
    end
end

require 'redcarpet/render_strip'

class ProductViewModel < ApplicationViewModel

  def cache_key
    @cache_key ||= [model.cache_key, model.brand.cache_key, options_cache_key].join('/')
  end

  def browser_title
    "#{name} by #{model.brand.name} — Complete Food"
  end

  def meta_description
    if model.description.present?
      truncate(description_without_markdown, length: 158)
    else
      "#{name} is a Complete Food produced in #{model.brand.country.name} by #{model.brand.name}"
    end
  end

  def has_notes?
    model.notes.present?
  end

  def name
    model.name.capitalize
  end

  def type
    return 'Ready-to-Eat' if model.state == 'snack'
    return 'Ready-to-Drink' if model.state == 'bottle'
    return 'Powder' if model.state == 'powder'
  end

  def type_class
    type.parameterize
  end

  def country_code_symbol
    model.brand.country.code.downcase.to_sym
  end

  def description
    return unless model.description.present?

    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      tables: true
    ).render(model.description).html_safe
  end

  def description_without_markdown
    return unless model.description.present?

    Redcarpet::Markdown.new(
      Redcarpet::Render::StripDown
    ).render(model.description)
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

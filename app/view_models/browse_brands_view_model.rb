class BrowseBrandsViewModel < ApplicationViewModel
  ALPHABET = ('a'..'z').freeze

  def cache_key
    [
      'brands',
      Brand.maximum(:updated_at)&.to_s(:number),
      Product.maximum(:updated_at)&.to_s(:number)
    ].join('/')
  end

  def brands
    @brands ||= BrandViewModel.wrap(
      Brand.includes(:country).with_active_products,
      options
    )
  end

  def brands_collections
    @brands_collections ||= brands.group_by { |brand| brand.name[0].downcase }
  end

  def navigation_items
    ALPHABET.map do |letter|
      classes = %w[navigation-alphabet__link link link--alt]

      unless active_letter?(letter)
        classes << 'link--disabled'
      end

      {
        letter: letter.upcase,
        class_css: classes
      }
    end
  end

  private

  def active_letters
    @active_letters ||= brands.pluck(:name).map(&:first).uniq.map(&:downcase)
  end

  def active_letter?(letter)
    active_letters.include?(letter)
  end
end

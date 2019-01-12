class BrandNavigationViewModel < ApplicationViewModel
  ALPHABET = ('a'..'z').freeze

  def initialize(model, options = {})
    super(model, options)
    @used_anchors = []
  end

  def items
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

  def anchor(brand)
    anchor = brand.name.first.upcase

    return if used_anchors.include?(anchor)

    used_anchors << anchor
    anchor
  end

  private

    attr_accessor :used_anchors

    def active_letters
      @active_letters ||= model.pluck(:name).map(&:first).uniq.map(&:downcase)
    end

    def active_letter?(letter)
      active_letters.include?(letter)
    end

end

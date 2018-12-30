class BrandViewModel < ApplicationViewModel
  attr_reader :brands

  ALPHABET = ('a'..'z').freeze

  def initialize(brands:)
    @brands = brands
    @used_anchors = []
  end

  def navigation
    ALPHABET.map do |letter|
      classes = %w[navigation-alphabet__link link link--alt]

      unless active_letter_navigation?(letter)
        classes << 'link--disabled'
      end

      link_to(letter.upcase, "##{letter}", class: classes)
    end
  end

  def navigation_anchor(brand)
    anchor = brand.name.first.downcase

    unless used_anchors.include?(anchor)
      used_anchors << anchor
      anchor
    end
  end

  private

    attr_accessor :used_anchors

    def active_letters_navigation
      @active_letters_navigation ||= brands.pluck(:name).map(&:first).uniq.map(&:downcase)
    end

    def active_letter_navigation?(letter)
      active_letters_navigation.include?(letter)
    end

end

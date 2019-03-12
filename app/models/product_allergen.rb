class ProductAllergen < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :gluten, inclusion: BOOLEANS
  validates :lactose, inclusion: BOOLEANS
  validates :nut, inclusion: BOOLEANS
  validates :ogm, inclusion: BOOLEANS
  validates :soy, inclusion: BOOLEANS
end

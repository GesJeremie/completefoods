class ProductDiet < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :vegan, inclusion: BOOLEANS
  validates :vegetarian, inclusion: BOOLEANS
  validates :ketogenic, inclusion: BOOLEANS
end

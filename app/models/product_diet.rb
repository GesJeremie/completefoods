class ProductDiet < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :vegan, inclusion: { in: BOOLEANS }
  validates :vegetarian, inclusion: { in: BOOLEANS }
  validates :ketogenic, inclusion: { in: BOOLEANS }
end

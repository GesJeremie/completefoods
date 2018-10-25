class ProductAllergen < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :gluten, inclusion: { in: BOOLEANS }
  validates :lactose, inclusion: { in: BOOLEANS }
  validates :nut, inclusion: { in: BOOLEANS }
  validates :ogm, inclusion: { in: BOOLEANS }
  validates :soy, inclusion: { in: BOOLEANS }

  def any?
    self.nut || self.gluten || self.nut || self.ogm || self.soy
  end

end

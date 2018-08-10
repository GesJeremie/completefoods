class ProductShipment < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product

  validates :product, presence: true
  validates :united_states, inclusion: { in: BOOLEANS }
  validates :canada, inclusion: { in: BOOLEANS }
  validates :europe, inclusion: { in: BOOLEANS }
  validates :rest_of_world, inclusion: { in: BOOLEANS }
end

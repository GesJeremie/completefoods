class ProductShipment < ApplicationRecord
  BOOLEANS = [true, false].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :united_states, inclusion: BOOLEANS
  validates :canada, inclusion: BOOLEANS
  validates :europe, inclusion: BOOLEANS
  validates :rest_of_world, inclusion: BOOLEANS
end

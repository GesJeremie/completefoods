class ProductShipment < ApplicationRecord
  SHIPPING_COUNTRIES = %i[canada united_states europe rest_of_world].freeze

  belongs_to :product, touch: true

  validates :product, presence: true
  validates :united_states, inclusion: BOOLEANS
  validates :canada, inclusion: BOOLEANS
  validates :europe, inclusion: BOOLEANS
  validates :rest_of_world, inclusion: BOOLEANS

  def shippable_countries
    SHIPPING_COUNTRIES.reject { |country| !self[country] }
  end
end

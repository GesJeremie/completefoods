class Country < ApplicationRecord
  def self.currently_active_in_brands
    active_countries = Brand.pluck(:country_id).uniq
    find(active_countries)
  end
end

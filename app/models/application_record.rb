class ApplicationRecord < ActiveRecord::Base
  BOOLEANS = [true, false].freeze

  self.abstract_class = true
end

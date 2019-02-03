class Wizard < ApplicationRecord
  has_secure_token
  has_many :wizard_steps
end

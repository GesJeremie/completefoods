class WizardStep < ApplicationRecord
  belongs_to :wizard

  default_scope { order('created_at ASC') }
end

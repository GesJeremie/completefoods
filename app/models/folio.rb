class Folio < ApplicationRecord
  belongs_to :user
  has_many :folio_crypto_currencies
end

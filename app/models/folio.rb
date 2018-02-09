class Folio < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :folio_crypto_currencies
  has_many :crypto_currencies, through: :folio_crypto_currencies
end

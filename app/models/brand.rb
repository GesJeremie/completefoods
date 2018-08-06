class Brand < ApplicationRecord
  belongs_to :country
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :website, presence: true
  validates :facebook, presence: true
  validates :country_id, presence: true
end

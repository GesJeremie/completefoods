class Brand < ApplicationRecord
  belongs_to :country
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :website, presence: true
  validates :country_id, presence: true

  default_scope { order(name: :asc) }

  def self.with_active_products
    Brand.joins(:products).where('products.active', true).group('brands.id')
  end
end

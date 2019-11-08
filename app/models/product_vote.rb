class ProductVote < ApplicationRecord
  belongs_to :product, touch: true

  attribute :active, :boolean, default: false
  attribute :admin, :boolean, default: false

  validates :product, presence: true
  validates :ip, presence: true
  validates_uniqueness_of :ip, { scope: :product, message: 'You already reviewed this product!', unless: :admin? }
  validates :recommend, inclusion: BOOLEANS
  validates :reason, presence: true
  validates :active, inclusion: BOOLEANS

  def self.published
    where(active: true)
  end

  def self.not_published
    where(active: false)
  end

  def self.upvoted
    where(recommend: true)
  end

  def self.downvoted
    where(recommend: false)
  end
end

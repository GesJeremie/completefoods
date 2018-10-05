class ProductReview < ApplicationRecord
  belongs_to :product

  validates :score, presence: true, inclusion: { in: (0..4).to_a }
  validates :ip, presence: true
end

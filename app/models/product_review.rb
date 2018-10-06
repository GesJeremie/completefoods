class ProductReview < ApplicationRecord
  SCORES = ['Hell No!', 'Meh', 'Okay', 'Great', 'Excellent'].freeze

  belongs_to :product

  validates :score, presence: true, inclusion: { in: (0..4).to_a }
  validates :ip, presence: true

  def score_humanized
    SCORES[score]
  end
end

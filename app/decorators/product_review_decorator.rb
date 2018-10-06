class ProductReviewDecorator < Draper::Decorator
  delegate_all

  decorates_association :product
end

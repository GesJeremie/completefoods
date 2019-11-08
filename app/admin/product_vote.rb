ActiveAdmin.register ProductVote do
  permit_params :product_id, :ip, :recommend, :reason, :active

  scope :published
  scope :not_published
end

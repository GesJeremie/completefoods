ActiveAdmin.register ProductVote do
  permit_params :product_id, :ip, :recommend, :reason, :active, :admin

  scope :published
  scope :not_published

  controller do
    def create
      params[:product_vote][:ip] = request.ip
      params[:product_vote][:admin] = true
      super
    end
  end

  form do |f|
    semantic_errors *f.object.errors.keys

    inputs 'Attributes' do
      f.input :product
      f.input :recommend
      f.input :reason, as: :text
      f.input :active
    end

    f.actions
  end
end

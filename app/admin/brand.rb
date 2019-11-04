ActiveAdmin.register Brand do
  actions :all

  index do
    column :id do |brand|
      auto_link(brand, brand.id)
    end
    column :name
    column :country
    column :products do |brand|
      brand.products.count
    end

    actions
  end


  show do |brand|
    panel 'Brand' do
      attributes_table_for brand do
       row :name
       row :website
       row :facebook
       row :country
      end
    end

    panel 'Products' do
      table_for brand.products do
        column :id do |product|
          auto_link(product, product.id)
        end
        column :name
      end
    end
  end

  # index do
  #   column :id
  #   column :first_name
  #   column :last_name
  #   column :active
  #   column :paid
  #   column :moderation_status do |classified|
  #     status = classified.moderation_status
  #     content_tag(:span, status, class: "status_tag #{status}")
  #   end
  #   column :email
  #   column :created_at
  #   column :updated_at
  #   actions
  # end

  # show do
  #   attributes_table do
  #     row :avatar do |classified|
  #       image_tag classified.avatar.thumb_small.url
  #     end

  #     row :first_name
  #     row :last_name
  #     row :birthdate

  #     row :content do |classified|
  #       simple_format classified.content
  #     end

  #     row :perishable_token
  #     row :slug

  #     row :created_at
  #     row :updated_at
  #   end

  #   active_admin_comments
  # end

  # sidebar 'Contact', only: :show do
  #   attributes_table_for classified do
  #     row :email
  #     row :phone
  #     row :hide_phone
  #   end
  # end

  # sidebar 'Moderation', only: :show do
  #   attributes_table_for classified do
  #     row :moderation_status do |classified|
  #       status = classified.moderation_status
  #       content_tag(:div, status.capitalize, class: "status_tag #{status}")
  #     end

  #     row :moderation_rejected_reason
  #   end
  # end

  # sidebar 'Payment', only: :show do
  #   attributes_table_for classified do
  #     row :paid
  #   end
  # end

  # sidebar 'Active', only: :show do
  #   attributes_table_for classified do
  #     row :active
  #   end
  # end

  # form do |f|
  #   f.semantic_errors *f.object.errors.keys
  #   tabs do
  #     tab 'Attributes' do
  #       f.inputs do
  #         f.input :avatar, as: :file
  #         f.input :first_name
  #         f.input :last_name
  #         f.input :email
  #         f.input :phone
  #         f.input :content

  #         f.input :active
  #         f.input :paid
  #         f.input :hide_phone
  #       end
  #     end

  #     tab 'Moderation' do
  #       f.inputs do
  #         f.input :moderation_status, as: :select, collection: ['pending', 'approved', 'rejected']
  #         f.input :moderation_rejected_reason
  #       end
  #     end
  #   end

  #   f.actions
  # end
end

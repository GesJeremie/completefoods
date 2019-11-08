ActiveAdmin.register Product do
  permit_params [
    :id,
    :brand_id,
    :name, :slug,
    :kcal_per_serving,
    :protein_per_serving,
    :carbs_per_serving,
    :fat_per_serving,
    :subscription_available,
    :discount_for_subscription,
    :state,
    :notes,
    :active,
    :created_at,
    :updated_at,
    :flavor,
    :description,
    price_attributes: [:currency_id, :per_serving_minimum_order, :per_serving_bulk_order],
    allergen_attributes: [:gluten, :lactose, :nut, :ogm, :soy],
    diet_attributes: [:vegetarian, :vegan, :ketogenic],
    shipment_attributes: [:united_states, :canada, :europe, :rest_of_world]
  ]

  actions :all

  scope :active
  scope :inactive

  controller do
    defaults finder: :find_by_slug
  end

  index do
    column :id do |product|
      auto_link(product, product.id)
    end
    column :brand do |product|
      link_to product.brand.name, admin_brand_path(product.brand)
    end
    column :name
    column :active

    actions
  end

  form do |f|
    semantic_errors *f.object.errors.keys

    inputs 'Attributes' do
      if f.object.image.present?
        li image_tag f.object.image.variant(resize: '400x400'), class: 'thumb'
      end

      f.input :image, as: :file
      f.input :brand
      f.input :name
      f.input :slug
      f.input :description, as: :text
      f.input :kcal_per_serving
      f.input :protein_per_serving
      f.input :carbs_per_serving
      f.input :fat_per_serving
      f.input :subscription_available
      f.input :discount_for_subscription
      f.input :state
      f.input :notes
      f.input :active
      f.input :flavor
    end

    inputs 'Prices', for: [:price, f.object.price || ProductPrice.new] do |price|
      price.inputs :currency, :per_serving_minimum_order, :per_serving_bulk_order
    end

    columns do
      column do
        panel 'Allergens' do
          li 'Check the allergens present in this product', class: 'help'
          inputs for: [:allergen, f.object.allergen || ProductAllergen.new] do |allergern|
            allergern.inputs :gluten, :lactose, :nut, :ogm, :soy
          end
        end
      end

      column do
        panel 'Diets' do
          li 'Can this product be used for the following diet (if so check the box)', class: 'help'
          inputs for: [:diet, f.object.diet || ProductDiet.new] do |diet|
            diet.inputs :vegetarian, :vegan, :ketogenic
          end
        end
      end

      column do
        panel 'Shipment' do
          li 'Where this product can be shipped?', class: 'help'
          inputs for: [:shipment, f.object.shipment || ProductShipment.new] do |shipment|
            shipment.inputs :united_states, :canada, :europe, :rest_of_world
          end
        end
      end
    end

    f.actions
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

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
end

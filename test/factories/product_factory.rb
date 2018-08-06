class ProductFactory
  attr_accessor :overrides

  def initialize(overrides = {})
    @overrides = overrides
  end

  def build
    Product.new(attributes)
  end

  def create
    product = build

    if product.image.attachment.nil?
      product.image.attach(io: File.open(Rails.root.join('lib/tasks/import/placeholder.jpg')), filename: 'placeholder.jpg')
    end

    product.save
    product
  end

  private

    def attributes
      {
        brand: BrandFactory.new.create,
        diet: ProductDietFactory.new.build,
        price: ProductPriceFactory.new.build,
        shipment: ProductShipmentFactory.new.build,
        allergen: ProductAllergenFactory.new.build,

        name: Faker::FunnyName.name,
        kcal_per_serving: Faker::Number.between(10, 30),
        protein_per_serving: Faker::Number.between(10, 30),
        carbs_per_serving: Faker::Number.between(10, 30),
        fat_per_serving: Faker::Number.between(10, 30),
        subscription_available: Faker::Boolean.boolean,
        discount_for_subscription: Faker::Boolean.boolean,
        shaker_free_first_order: Faker::Boolean.boolean,
        sample_pack_available: Faker::Boolean.boolean,
        state: Product::STATES.sample,
        active: Faker::Boolean.boolean,
        image: nil
      }.merge(@overrides)
    end
end

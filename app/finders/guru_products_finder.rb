class GuruProductsFinder < ApplicationFinder
  attr_reader :answers

  def initialize(answers)
    @answers = answers
  end

  def perform
    products = Product.includes(
      :allergen,
      :diet,
      :shipment,
      { price: [:currency] },
      { image_attachment: [:blob] },
      { brand: [:country] }
    ).active

    products.select do |product|
      states_preferences.include?(product.state)
    end

    if answers[:lactose] == 'on'
      products = products.select { |product| !product.allergen.lactose? }
    end

    if answers[:gluten] == 'on'
      products = products.select { |product| !product.allergen.gluten? }
    end

    if answers[:vegan] == 'on'
      products = products.select { |product| product.diet.vegan? }
    end

    if answers[:vegetarian] == 'on'
      products = products.select { |product| product.diet.vegetarian? }
    end

    if answers[:country] == 'united_states'
      products = products.select { |product| product.shipment.united_states? }
    end

    if answers[:country] == 'europe'
      products = products.select { |product| product.shipment.europe? }
    end

    if answers[:country] == 'canada'
      products = products.select { |product| product.shipment.canada? }
    end

    if answers[:country] == 'other'
      products = products.select { |product| product.shipment.rest_of_world? }
    end

    if answers[:subscription] == 'yes'
      products = products.select { |product| product.subscription_available? }
    end

    if answers[:subscription] == 'yes_only_discount'
      products = products.select { |product| product.subscription_available? && product.discount_for_subscription?}
    end

    products
  end

  private
    def states_preferences
      @states_preferences ||= fetch_states_preferences
    end

    def fetch_states_preferences
      preferences = []

      preferences.push('powder') if answers[:powder] == 'on'
      preferences.push('snack') if answers[:snack] == 'on'
      preferences.push('bottle') if answers[:ready_to_drink] == 'on'

      if preferences.any?
        preferences
      else
        ['powder', 'snack', 'bottle']
      end
    end
end

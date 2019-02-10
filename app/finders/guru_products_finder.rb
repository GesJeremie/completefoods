class GuruProductsFinder < ApplicationFinder
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def perform
    search = {}

    if options['lactose'] == 'on'
      search[:lactose_free] = true
    end

    if options['gluten'] == 'on'
      search[:gluten_free] = true
    end

    if options['vegan'] == 'on'
      search[:vegan] = true
    end

    if options['vegetarian'] == 'on'
      search[:vegetarian] = true
    end

    if options['country'] == 'united_states'
      search[:united_states] = true
    end

    if options['country'] == 'canada'
      search[:canada] = true
    end

    if options['country'] == 'europe'
      search[:europe] = true
    end

    if options['country'] == 'other'
      search[:rest_of_world] = true
    end

    if options['snack'] == 'on'
      search[:snack] = true
    end

    if options['powder'] == 'on'
      search[:powder] = true
    end

    if options['ready_to_drink'] == 'on'
      search[:bottle] = true
    end

    if options['subscription'] == 'yes'
      search[:subscription_available] = true
    end

    if options['subscription'] == 'yes_only_discount'
      search[:subscription_available] = true
      search[:discount_for_subscription] = true
    end

    if options['sort'].present?
      search[:sort] = options['sort'].to_sym
    end

    ProductFinder.new(search).perform
  end
end

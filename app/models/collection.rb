class Collection
  attr_reader :collection

  COLLECTIONS = [
    { name: 'Cheapest', cover: 'cheapest.jpg', slug: 'cheapest' },
    { name: 'Most Expensive', cover: 'most_expensive.jpg', slug: 'most_expensive' },
    { name: 'For Vegans', cover: 'vegan.jpg' },
    { name: 'For Vegetarians', cover: 'vegetarian.jpg' },

    { name: 'Snacks', cover: 'snacks.jpg' },
    { name: 'Ready To Drink', cover: 'ready_to_drink.jpg' },
    { name: 'Powders', cover: 'powder.jpg' },
    { name: 'For Athletes', cover: 'athletes.jpg' },

    { name: 'Gluten Free', cover: 'gluten_free.jpg' },
    { name: 'Lactose Free', cover: 'milk.jpg' },

    { name: 'Made in Canada', cover: 'canada.jpg' },
    { name: 'Made in US', cover: 'us.jpg' },
    { name: 'Made in India', cover: 'india.jpg' },
    { name: 'Made in France', cover: 'france.jpg' },
    { name: 'Made in Germany', cover: 'germany.png' },
    { name: 'Made in Netherlands', cover: 'netherlands.jpg' }

  ].freeze

  def self.all
    COLLECTIONS.map { |collection| new(collection) }
  end

  def initialize(collection)
    @collection = collection
  end

  def name
    collection[:name]
  end

  def slug
    collection[:slug]
  end

  def cover
    path_covers << collection[:cover]
  end

  private

    def path_covers
      'collections/'
    end

end

Rails.application.configure do

  config.number_items_preview_collections = 8
  config.number_items_preview_brands = 16

  config.narrow_max_results = 15

  config.products_per_page = 20

  config.sorters = [
    { label: 'Nothing', value: :nothing, group: nil },

    { label: 'Per serving (lowest)', value: :kcal_per_serving_lowest, group: :calories },
    { label: 'Per serving (most)', value: :kcal_per_serving_most, group: :calories },

    { label: 'Per serving (lowest)', value: :fat_per_serving_lowest, group: :fat },
    { label: 'Per serving (most)', value: :fat_per_serving_most, group: :fat },

    { label: 'Per serving (lowest)', value: :fat_per_serving_ratio_lowest, group: :fat_ratio },
    { label: 'Per serving (most)', value: :fat_per_serving_ratio_most, group: :fat_ratio },

    { label: 'Per serving (lowest)', value: :carbs_per_serving_lowest, group: :carbs },
    { label: 'Per serving (most)', value: :carbs_per_serving_most, group: :carbs },

    { label: 'Per serving (lowest)', value: :carbs_per_serving_ratio_lowest, group: :carbs_ratio },
    { label: 'Per serving (most)', value: :carbs_per_serving_ratio_most, group: :carbs_ratio },

    { label: 'Per serving (lowest)', value: :protein_per_serving_lowest, group: :protein},
    { label: 'Per serving (most)', value: :protein_per_serving_most, group: :protein},

    { label: 'Per serving (lowest)', value: :protein_per_serving_ratio_lowest, group: :protein_ratio},
    { label: 'Per serving (most)', value: :protein_per_serving_ratio_most, group: :protein_ratio},

    { label: 'Minimum Order (cheapest)', value: :price_per_serving_minimum_order_cheapest, group: :price_per_serving },
    { label: 'Minimum Order (most expensive)', value: :price_per_serving_minimum_order_most_expensive, group: :price_per_serving },
    { label: 'Bulk Order (cheapest)', value: :price_per_serving_bulk_order_cheapest, group: :price_per_serving },
    { label: 'Bulk Order (most expensive)', value: :price_per_serving_bulk_order_most_expensive, group: :price_per_serving },

    { label: 'Minimum Order (cheapest)', value: :price_per_day_minimum_order_cheapest, group: :price_per_day },
    { label: 'Minimum Order (most expensive)', value: :price_per_day_minimum_order_most_expensive, group: :price_per_day },
    { label: 'Bulk Order (cheapest)', value: :price_per_day_bulk_order_cheapest, group: :price_per_day },
    { label: 'Bulk Order (most expensive)', value: :price_per_day_bulk_order_most_expensive, group: :price_per_day }
  ]

  config.collections = [
    { name: 'Cheapest', cover: 'collections/cheapest.jpg', group: 'price', route: 'cheapest' },
    { name: 'Most Expensive', cover: 'collections/most_expensive.jpg', group: 'price', route: 'most-expensive'},

    { name: 'For Vegans', cover: 'collections/vegan.jpg', group: 'diet', route: 'for-vegans' },
    { name: 'For Vegetarians', cover: 'collections/vegetarian.jpg', group: 'diet', route: 'for-vegetarians' },

    { name: 'Snacks', cover: 'collections/snacks.jpg', group: 'type', route: 'snacks' },
    { name: 'Ready To Drink', cover: 'collections/ready_to_drink.jpg', group: 'type', route: 'ready-to-drink' },
    { name: 'Powders', cover: 'collections/powder.jpg', group: 'type', route: 'powders' },

    { name: 'For Athletes', cover: 'collections/athletes.jpg', group: 'misc', route: 'for-athletes' },

    { name: 'Gluten Free', cover: 'collections/gluten_free.jpg', group: 'allergens', route: 'gluten-free' },
    { name: 'Lactose Free', cover: 'collections/milk.jpg', group: 'allergens', route: 'lactose-free' },

    { name: 'Made in Canada', cover: 'collections/canada.jpg', group: 'country', route: 'made-in-canada' },
    { name: 'Made in USA', cover: 'collections/us.jpg', group: 'country', route: 'made-in-united-states' },
    { name: 'Made in India', cover: 'collections/india.jpg', group: 'coutry', route: 'made-in-india' },
    { name: 'Made in France', cover: 'collections/france.jpg', group: 'country', route: 'made-in-france' },
    { name: 'Made in Germany', cover: 'collections/germany.png', group: 'country', route: 'made-in-germany' },
    { name: 'Made in Netherlands', cover: 'collections/netherlands.jpg', group: 'country', route: 'made-in-netherlands' }
  ]
end

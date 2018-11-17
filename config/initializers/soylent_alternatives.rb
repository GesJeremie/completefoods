Rails.application.configure do

  config.narrow_max_results = 15

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
    { name: 'Cheapest', cover: 'collections/cheapest.jpg', route: 'cheapest' },
    { name: 'Most Expensive', cover: 'collections/most_expensive.jpg', route: 'most-expensive'},
    { name: 'For Vegans', cover: 'collections/vegan.jpg', route: 'for-vegans' },
    { name: 'For Vegetarians', cover: 'collections/vegetarian.jpg', route: 'for-vegetarians' },

    { name: 'Snacks', cover: 'collections/snacks.jpg', route: 'snacks' },
    { name: 'Ready To Drink', cover: 'collections/ready_to_drink.jpg', route: 'ready-to-drink' },
    { name: 'Powders', cover: 'collections/powder.jpg', route: 'powders' },
    { name: 'For Athletes', cover: 'collections/athletes.jpg', route: 'for-athletes' },

    { name: 'Gluten Free', cover: 'collections/gluten_free.jpg', route: 'gluten-free' },
    { name: 'Lactose Free', cover: 'collections/milk.jpg', route: 'lactose-free' },

    { name: 'Made in Canada', cover: 'collections/canada.jpg', route: 'made-in-canada' },
    { name: 'Made in USA', cover: 'collections/us.jpg', route: 'made-in-united-states' },
    { name: 'Made in India', cover: 'collections/india.jpg', route: 'made-in-india' },
    { name: 'Made in France', cover: 'collections/france.jpg', route: 'made-in-france' },
    { name: 'Made in Germany', cover: 'collections/germany.png', route: 'made-in-germany' },
    { name: 'Made in Netherlands', cover: 'collections/netherlands.jpg', route: 'made-in-netherlands' }
  ]
end

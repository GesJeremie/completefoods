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
end

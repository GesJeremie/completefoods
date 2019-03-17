Rails.application.configure do

  # How many collections do you want to display on home page
  config.number_items_preview_collections = 8

  # How many brands do you want to display on home page
  config.number_items_preview_brands = 16

  # How many products do you want to display per page
  # on /products
  config.browse_products_per_page = 20

  # Define every "made in" collections
  config.collections_made_in = [
    'austria',
    'canada',
    'czech_republic',
    'estonia',
    'finland',
    'france',
    'germany',
    'india',
    'italy',
    'netherlands',
    'singapore',
    'spain',
    'sweden',
    'united_kingdom',
    'united_states'
  ]
end

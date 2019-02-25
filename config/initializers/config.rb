Rails.application.configure do

  config.number_items_preview_collections = 8
  config.number_items_preview_brands = 16

  config.products_per_page = 20

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

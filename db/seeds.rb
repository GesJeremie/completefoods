# We reserve the db:seed tasks specifically for data that must be present for your application to function in any environment.
# One example of this may be a list of US States in your database that your address form relies on.
# That data should always exist, whether the app is being used in development or production.

# Seed Countries
ISO3166::Country.translations.each do |code, name|
  Country.where(
    code: code,
    name: name
  ).first_or_create
end

# Seed Currencies
Money::Currency.table.values.each do |currency|
  Currency.where(
    code: currency[:iso_code],
    name: currency[:name],
    symbol: currency[:symbol]
  ).first_or_create
end

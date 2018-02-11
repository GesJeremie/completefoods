namespace :seed do
    desc "Fetch crypto currencies from cryptocompare api and add them in the project if not already added."
    task crypto_currencies: :environment do
        Tasks::SeedCryptoCurrencies.()
    end
end

namespace :seed do
    desc "Add currencies to the project if they are not already added."
    task currencies: :environment do
        Tasks::SeedCurrencies.()
    end
end

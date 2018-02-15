namespace :import do
    desc "Import the icons from public/import"
    task icons: :environment do
        Tasks::ImportIcons.()
    end
end

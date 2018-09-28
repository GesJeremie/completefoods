# Load the Rails application.
require_relative 'application'

Rails.application.configure do
  #config.autoload_paths << Rails.root.join('app/finders/**')
  ##config.autoload_paths << Rails.root.join('app/services/**')
  #config.autoload_paths << Rails.root.join('app/view_models/**')
end

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.routes.draw do

  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'home#index'

  # SEO Routes
  # get '/soylent-alternatives-made-in-:country', to: 'search#index'

  resources :products, only: [:show]

  namespace :dashboard do
    resources :brands
    resources :products
  end

  namespace :api, constraints: { format: 'json' } do
    resources :products, only: [:index]
  end

end


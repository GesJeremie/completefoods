Rails.application.routes.draw do

  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'home#index'

  # SEO Routes
  # get '/soylent-alternatives-made-in-:country', to: 'search#index'

  resources :products, only: [:show], param: :slug
  resources :currencies, only: [:update], param: :code

  namespace :dashboard do
    root 'brands#index'
    resources :brands
    resources :products
  end

  namespace :api, constraints: { format: 'json' } do
    resources :products, only: [:index]
  end

end


Rails.application.routes.draw do

  # Redirect www to no-www
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'home#index'

  # Collections
  get 'made-in-:country', to: 'collections#made_in'
  get 'produced-in-:country', to: 'collections#made_in'
  get 'suitable-for-vegans', to: 'collections#vegan'
  get 'for-vegans', to: 'collections#vegan'
  get 'produced-by-:brand', to: 'collections#made_by'
  get 'made-by-:brand', to: 'collections#made_by'

  resources :products, only: [:show], param: :slug
  resources :currencies, only: [:update], param: :code
  resources :sitemap, only: [:index], constraints: { format: 'xml' }

  namespace :dashboard do
    root 'brands#index'
    resources :brands
    resources :products, param: :slug
    resources :newsletters, only: [:index]
  end

  namespace :api, constraints: { format: 'json' } do
    resources :products, only: [:index]
    resources :product_reviews, only: [:create, :show]
    resources :newsletters, only: [:create]
  end

end


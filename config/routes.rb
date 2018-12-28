Rails.application.routes.draw do

  # Redirect www to no-www
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'home#index'

  # Collections
  # TODO: Put in a collection scope.
  get 'cheapest', to: 'collections#cheapest'
  get 'for-athletes', to: 'collections#athletes'
  get 'for-vegans', to: 'collections#vegan'
  get 'for-vegetarians', to: 'collections#vegetarian'
  get 'gluten-free', to: 'collections#gluten_free'
  get 'lactose-free', to: 'collections#lactose_free'
  get 'made-by-:brand', to: 'collections#made_by'
  get 'made-in-:country', to: 'collections#made_in'
  get 'most-expensive', to: 'collections#most_expensive'
  get 'powders', to: 'collections#powders'
  get 'ready-to-drink', to: 'collections#ready_to_drink'
  get 'snacks', to: 'collections#snacks'

  # Collections aliases for sitemap (TODO: Remove from there + sitemap)
  get 'produced-in-:country', to: 'collections#made_in'
  get 'suitable-for-vegans', to: 'collections#vegan'
  get 'produced-by-:brand', to: 'collections#made_by'

  resources :collections, only: [:index]
  resources :brands, only: [:index]
  resources :products, only: [:index, :show], param: :slug
  resources :currencies, only: [:update], param: :code
  resources :sitemap, only: [:index], constraints: { format: 'xml' }

  resources :pages, only: [] do
    collection do
      get 'what-is-a-complete-food'
    end
  end

  namespace :dashboard do
    root 'brands#index'
    resources :brands
    resources :products, param: :slug
    resources :newsletters, only: [:index, :destroy]
    resources :product_reviews, only: [:index, :destroy]
  end

  namespace :api, constraints: { format: 'json' } do
    resources :products, only: [:index]
    resources :product_reviews, only: [:create, :show]
    resources :newsletters, only: [:create]
  end
end


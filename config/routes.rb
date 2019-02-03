Rails.application.routes.draw do

  # Redirect www to no-www
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'pages#home'

  resources :brands, only: [:index, :show], param: :slug
  resources :products, only: [:index, :show], param: :slug
  resources :collections, only: [:index, :show], param: :slug
  resources :currencies, only: [:index, :update], param: :code
  resources :sitemap, only: [:index], constraints: { format: 'xml' }

  resource :guru do
    collection do
      get '/', action: :index, as: :index
      get :allergen
      get :diet
      get :location
      get :type
      get :subscription_create
      get :sort
      get :narrow
      get '/:id', action: :show, as: :show

      post :allergen_create
      post :diet_create
      post :location_create
      post :type_create
      post :subscription_create
      post :sort_create
      post :sort_create
      post :narrow_create
    end
  end

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


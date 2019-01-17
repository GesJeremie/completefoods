Rails.application.routes.draw do

  # Redirect www to no-www
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'pages#home'

  resources :brands, only: [:index, :show], param: :slug
  resources :products, only: [:index, :show], param: :slug
  resources :collections, only: [:index, :show], param: :slug
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


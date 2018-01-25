Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :folio_crypto_currency, only: [:create, :destroy, :update]
  resources :user_subscribe, only: [:create]
  resources :user_disconnect, only: [:create]
  resources :user_connect, only: [:create]
  resources :market_exchange, only: [:create]

end


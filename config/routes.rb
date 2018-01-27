Rails.application.routes.draw do

  root 'home#index'

  resources :folio_crypto_currency,   only: [:create, :destroy, :update]
  resources :user_subscribe,          only: [:create]
  resources :user_disconnect,         only: [:create]
  resources :user_connect,            only: [:create]
  resources :market_exchange,         only: [:create]
  resources :settings,                only: [:index]
  resources :settings_currency,       only: [:create]

end


Rails.application.routes.draw do
  root 'initiators#index'

  resources :initiators, only: [:index]
  resources :pings, only: [:index]
end

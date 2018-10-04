Rails.application.routes.draw do
  root 'initiators#index'

  resources :initiators, only: [:index]
end

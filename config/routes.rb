Rails.application.routes.draw do
  devise_for :users
  root to: 'cars#index'

  resources :bookings, only: [:show]
  resources :cars do
    resources :bookings, except: [:show]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

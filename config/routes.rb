Rails.application.routes.draw do
  devise_for :users
  root to: 'cars#index'

  post 'cars/search' => 'cars#search', as: 'search_cars'
  get 'users/:id' => 'dashboard#show', as: 'user'
  get 'dashboard' => 'dashbaord#dashboard', as: 'dashboard'

  resources :bookings, only: [:show]

  resources :cars do
    resources :bookings, except: [:show]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

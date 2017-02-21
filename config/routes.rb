Rails.application.routes.draw do
  devise_for :users
  root to: 'cars#index'

  post 'cars/search' => 'cars#search', as: 'search_cars'
  resources :cars do
    resources :bookings
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

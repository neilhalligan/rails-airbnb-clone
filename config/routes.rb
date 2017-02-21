Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'cars#index'

  post 'cars/search' => 'cars#search', as: 'search_cars'
  get 'users/:id' => 'dashboards#show', as: 'user'
  get 'dashboard' => 'dashboards#dashboard', as: 'dashboard'

  resources :bookings, only: [:show]

  resources :cars do
    resources :bookings, except: [:show]

  end
mount Attachinary::Engine => "/attachinary" # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

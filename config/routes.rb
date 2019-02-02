Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'products#index'

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts
end

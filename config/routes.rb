Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :mypages, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
end

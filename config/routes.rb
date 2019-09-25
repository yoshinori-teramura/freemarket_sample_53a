Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :mypages, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users/signup" => "users#signup"
  get "users/users/registration" => "users#registration"
  get "users/users/users/sms_confirmation" => "users#sms_confirmation"
  get "users/address" => "users#address"
  get "users/credit" => "users#credit"
  get "users/complete" => "users#complete"
  get "users/login" => "users#login"
  get "users/sign_up" => "devise/registrations#new"

  root 'items#index'
end

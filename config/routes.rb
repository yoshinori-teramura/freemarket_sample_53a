Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :items
  resources :mypages do
    member do
      get 'profile'
      get 'deliver_address'
      get 'credit'
      get 'email_password'
      get 'identification'
      get 'sms_confirmation'
      patch 'update_user'
      patch 'update_address'
    end
  end

  resources :logout, only: :index

  resources :sell, only: [:index, :create, :edit, :update] do
    collection do
        get 'get_category_children', defaults: {format: 'json'}
        get 'get_delivery_types', defaults: {format: 'json'}
    end
  end
  resources :buy

  resources :credit, only: [:create, :show, :edit] do
    collection do
      post 'delete', to: 'credit#delete'
      post 'show'
    end
    member do
      get 'confirmation'
    end
  end

  resources :signup do          #新規登録用コントローラー
    collection do
      get 'registration_type'   #新規登録を、メールor Facebook or google選択画面
      get 'registration'        #会員情報登録画面
      get 'sms_confirmation'    #TEL登録画面（SMS認証）
      get 'address'              #住所情報登録画面
      get 'credit'              #クレジット情報登録画面
      get 'complete'            #完了画面
    end
  end
  root 'items#index'
end

Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations",sessions: 'users/sessions', passwords: 'users/passwords', mniauth_callbacks:  "users/omniauth_callbacks" }

  devise_scope :user do
    ## ↓登録方法の選択ページ
    get 'users/select_registration', to: 'users/registrations#select', as: :select_registration
    get 'users/confirm_phone', to: 'users/registrations#confirm_phone', as: :confirm_phone
    get 'users/new_address', to: 'users/registrations#new_address', as: :new_regist_address
    post 'users/regist_address', to: 'users/registrations#regist_address', as: :regist_address
    get 'user/regist_completed', to: 'users/registrations#completed', as: :regist_completed
  end

  # devise_for :users
  root to: "items#index"


  resources :users, only: [:show] do
    collection do
      get "card"
      get "selling"
      get "selling_progress"
      get "sold"
      get "bought_progress"
      get "bought_past"
    end
  end

  resources :items  do
    member do
      get "purchase_confirmation"
      post "purchase"
    end
  end
  resources :categories, only: [:index, :show]
  resource :cards, only: [:new, :create, :show, :update, :destroy]

end
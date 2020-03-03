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

  resources :items do
    collection do
      get "scraping_category"
      get "scraping_autobike"
      get "scraping_car_parts"
      get "scraping_cosme"
      get "scraping_domestic_car"
      get "scraping_foods"
      get "scraping_forign_car"
      get "scraping_game"
      get "scraping_instrument"
      get "scraping_interior"
      get "scraping_kids"
      get "scraping_kitchen"
      get "scraping_ladies"
      get "scraping_mens"
      get "scraping_phone"
      get "scraping_sports"
      get "scraping_watch"
    end
  end

  namespace :api do
    resources :items, only: [:create, :update], defaults: { format: 'json' }
    resources :categories, only: [:index], defaults: { format: 'json' }
  end

end
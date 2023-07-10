require 'sidekiq/web'

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users, controllers: { registrations: 'users/registrations' }

    resources :products do
      resources :reviews, module: :products do
        post :archive, on: :member
      end

      post :change_status, on: :member
    end

    resources :users do
      resources :reviews, module: :users do
        post :archive, on: :member
      end
    end

    resources :carts, only: %i[destroy show] do
      resources :cart_items, only: %i[destroy create]
    end

    get 'search', to: 'products#search'

    root 'pages#index'

    mount Sidekiq::Web => '/sidekiq'
  end
end

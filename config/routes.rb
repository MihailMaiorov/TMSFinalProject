# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, skip: %i[session password registration],
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users, skip: [:omniauth_callbacks], controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }

    resources :products do
      resources :reviews, module: :products do
        post :archive, on: :member
      end

      post :change_status, on: :member

      collection do
        get :search, path: 'search'
      end
    end

    resources :users do
      resources :reviews, module: :users do
        post :archive, on: :member
      end
    end

    resources :cart_items, only: %i[destroy create show]

    root 'pages#index'

    mount Sidekiq::Web => '/sidekiq'
  end
end

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users, controllers: { registrations: 'users/registrations' }

    resources :products, :users do
      resources :reviews

      post :change_status, on: :member
    end

    resources :carts, only: %i[destroy show] do
      resources :cart_items, only: %i[destroy create]
    end

    root 'pages#index'
  end
end

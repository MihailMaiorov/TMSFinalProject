Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users, controllers: { registrations: 'users/registrations' }

    resources :products, :users do
      resources :reviews, only: %i[new index create edit destroy]
    end

    root 'pages#index'
  end
end

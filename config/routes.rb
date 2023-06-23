Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users, controllers: { registrations: 'users/registrations' }

    resources :categories, only: %i[index show] do
      resources :products
    end

    patch 'change_locale' => 'locales#change_locale'

    root 'categories#index'
  end
end

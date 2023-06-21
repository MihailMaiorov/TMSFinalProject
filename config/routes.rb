Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :categories, only: %i[index show] do
    resources :products
  end

  root 'categories#index'
end

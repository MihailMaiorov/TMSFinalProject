Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: %i[index show] do
    resources :products
  end

  root 'categories#index'
end

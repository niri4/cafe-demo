Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers
  root to: "home#index"
  resources :home
  resources :orders
  resources :line_items, only: [:update]
  get "add_to_cart" => "orders#add_to_cart"
end

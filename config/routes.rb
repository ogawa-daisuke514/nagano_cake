Rails.application.routes.draw do

  root to: 'public/homes#top'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customer, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    resources :orders, only: [:index, :show, :update]
    get "customers/:id/orders" => "customers#orders", as: "customer_orders"
    resources :customers, only: [:index, :edit, :show, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :edit, :create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  scope module: :public do

    get 'items/genre/:id' => "items#genre", as: "items_genre"
    resources :items, only: [:index, :show]

    post 'orders/confirm', as: "orders_confirm"
    get 'orders/thanks', as: "orders_thanks"
    resources :orders, only: [:new, :index, :show, :create]
  end
  root to: 'public/homes#top'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customer, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    patch "order_items/:id" => "order_items#update", as: "order_item"
    resources :orders, only: [:index, :show, :update]
    get "customers/:id/orders" => "customers#orders", as: "customer_orders"
    resources :customers, only: [:index, :edit, :show, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :edit, :create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

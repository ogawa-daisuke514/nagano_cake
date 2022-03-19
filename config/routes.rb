Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customer, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :customer do
    #リダイレクト用にgetメソッドによるログアウトを追加
    get '/customer/sign_out', to: 'public/sessions#withdraw_destroy', as: :customer_log_out
  end

  scope module: :public do
    #public/homes
    root to: 'homes#top'
    get 'about' => 'homes#about'

    #public/mypage
    get 'my_page/withdraw_confirm' => 'my_pages#withdraw_confirm'
    patch 'my_page/withdraw' => 'my_pages#withdraw'
    resource :my_page, only: [:show, :edit, :update]

    #public/items
    get 'items/genre/:id' => "items#genre", as: "items_genre"
    resources :items, only: [:index, :show]

    #public/cart_items
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]

    #public/orders
    post 'orders/confirm', as: "orders_confirm"
    get 'orders/thanks', as: "orders_thanks"
    resources :orders, only: [:new, :index, :show, :create]

    #public/addresses
    resources :addresses, only: [:index, :edit, :update, :destroy, :create]

    #devise
  end

  namespace :admin do
    #admin/orders
    root to: "orders#index"
    resources :orders, only: [:index, :show, :update]
    patch "order_items/:id" => "order_items#update", as: "order_item"
    get "customers/:id/orders" => "customers#orders", as: "customer_orders"
    resources :customers, only: [:index, :edit, :show, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :edit, :create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

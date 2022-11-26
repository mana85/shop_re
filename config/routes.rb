Rails.application.routes.draw do
  # devise記載変更
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #
  # 顧客用
  scope module: :public do
    # homes
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    # products
    resources :products, only: [:index, :show]
    get "searches" => "products#searches"
    get "searche_word" => "products#searche_word"
    # customers
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get "customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
    patch "customers/withdrawal" => "customers#withdrawal", as: "withdrawal"
    # cart_items
    resources :cart_items, only: [:index, :update, :destroy, :create]do
      delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all"
    end
    # orders
    resources :orders, only: [:new, :create, :index]
    post "orders/confirm" => "orders#confirm", as: "confirm"
    get "orders/complete" => "orders#complete", as: "complete"
    get "orders/:id" => "orders#show", as: "orders"
    # shipping_address
    resources :shipping_address
  end
  #
  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :product
    resources :genres, only: [:index, :create, :edit, :uodate]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

end

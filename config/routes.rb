Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "relationship/create"
    get "relationship/destroy"
    get "sessions/new"
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/about"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :blogs, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
  end
end

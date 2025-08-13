Rails.application.routes.draw do
  get "tags/index"
  get "likes/create"
  get "likes/destroy"
  get "user_mfa_sessions/new"
  get "user_mfa_sessions/create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "posts#index"
  # root "posts#index"

  resources :users, only: %i[new create destroy] do
    member do
      get :activate
    end
  end

  resources :posts do
    get :bookmarks, on: :collection
    resource :bookmarks, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
    get :likes, on: :collection
    resource :likes, only: %i[create destroy]
  end

  resources :tags, only: %i[ index, show ]
  resource :profile, only: %i[show edit update]

  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  post "guest_login", to: "user_sessions#guest_login"
end

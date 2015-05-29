Rails.application.routes.draw do
  devise_for :users, 
    path: :citizens,
    controllers: { registrations: "users/registrations" }
  root to: "directory#index"

  get "/representative/:slug", to: "representatives#show", as: "rep"
  resources :representatives, only: [:edit, :update]
  resources :citizens, only: [:show]
  resources :stances, only: [:index, :create, :update, :destroy]
  get "/directory/filter", to: "directory#filter"
end


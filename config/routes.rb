Rails.application.routes.draw do
  devise_for :users, 
    path: :citizens,
    controllers: { registrations: "registrations" }
  root to: "directory#index"

  get "/representative/:slug", to: "representatives#show", as: "rep"
  resources :representatives, only: [:edit, :update]
  resources :citizens, only: [:show, :edit, :update]
  resources :stances, only: [:index, :create, :update, :destroy]
  resources :news, only: [:index]
  get "/directory/filter", to: "directory#filter"
end


Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "directory#index"
  get "/representative/:slug", to: "representatives#show", as: "rep"
  resources :representatives, only: [:edit, :update]
  resources :stances, only: [:index, :create, :update]

  get "/directory/filter", to: "directory#filter"
end


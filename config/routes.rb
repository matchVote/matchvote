Rails.application.routes.draw do
  devise_for :users, 
    path: :citizens,
    controllers: { registrations: "registrations" }

  root to: "directory#index"

  get "/representative/:slug", to: "representatives#show", as: "rep"
  resources :representatives, only: [:edit, :update]

  resources :citizens, only: [:show, :edit, :update, :index]
  post "/citizens/:id/update_personal", to: "citizens#update_personal_info"
  post "/citizens/:id/update_contact",  to: "citizens#update_contact_info"
  post "/citizens/:id/update_settings", to: "citizens#update_settings"

  resources :stances, only: [:index, :create, :update, :destroy]
  resources :news, only: [:index]
  resources :elections, only: [:index]
  get "/directory/filter", to: "directory#filter"
end


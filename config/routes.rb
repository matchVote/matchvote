Rails.application.routes.draw do
  devise_for :users,
    path: :citizens,
    controllers: { registrations: "registrations" }

  root to: "directory#index"

  resources :representatives, only: [:edit, :update]
  get "/representative/:slug", to: "representatives#show", as: "rep"
  get "/representatives/:id/edit/demographics",
    to: "representatives#edit_demographics"
  post "/representatives/:id/edit/demographics",
    to: "representatives#update_demographics"
  get "/representatives/:id/edit/biography", to: "representatives#edit_biography"
  post "/representatives/:id/edit/biography", to: "representatives#update_biography"

  resources :citizens, only: [:show, :edit, :update, :index]
  post "/citizens/:id/update_personal", to: "citizens#update_personal_info"
  post "/citizens/:id/update_contact",  to: "citizens#update_contact_info"
  post "/citizens/:id/update_settings", to: "citizens#update_settings"

  resources :stances, only: [:index, :create, :update, :destroy]
  resources :elections, only: [:index]
  get "/directory/filter", to: "directory#filter"

  resources :rep_stances, only: [:index]

  get "/news", to: "articles#index"
  patch "/articles/:id/newsworthiness", to: "articles#newsworthiness"
end


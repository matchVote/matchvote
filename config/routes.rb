Rails.application.routes.draw do
  devise_for :users
  root to: "directory#index"
  get "/representative/:slug", to: "representative#show", as: "rep"
  resources :stances

  get "/directory/filter", to: "directory#filter"
end


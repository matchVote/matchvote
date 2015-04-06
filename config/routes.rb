Rails.application.routes.draw do
  devise_for :users
  root to: "directory#index"
  get "/representative/:slug", to: "representative#show", as: "rep"
  resources :stances

  get "/directory/sort_reps", to: "directory#sort_reps"
  get "/directory/search", to: "directory#search"
end

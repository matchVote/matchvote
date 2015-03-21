Rails.application.routes.draw do
  devise_for :users
  root to: "directory#index"
  get "/representative/:full_name", to: "representative#show", as: "rep"
end

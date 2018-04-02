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
  resources :articles, only: [:show]
  patch "/articles/:id/newsworthiness", to: "articles#newsworthiness"
  post "/articles/:id/bookmark", to: "articles#bookmark"

  scope "/api" do
    resources :comments, only: [:create]
    get "/news_feed_stats", to: "articles#news_feed_stats"
    get "/articles", to: "articles#api_index"
    get "/articles/:id/comments", to: "comments#index_for_article"
    patch "/articles/:id/increment_read_count", to: "articles#increment_read_count"
    patch "/comments/:id/likes", to: "comments#likes"
    patch "/citizens/:id/upgrade_account", to: "citizens#upgrade_account"
    resources :relationships, only: [:create]
    post "/relationships/unfollow", to: "relationships#unfollow"
  end

  resource :forum, only: [:show], controller: "forum"
  resources :editorials, only: [:index, :show]
end

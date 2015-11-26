Shine::Engine.routes.draw do
  devise_for :users, class_name: "Shine::User", module: 'shine'

  post "/sync" => "contentful#sync", defaults: { format: :json }

  resources :posts do
    post "assets/create" => "assets#create"
  end

  resources :categories
  resources :assets
end

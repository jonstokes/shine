Shine::Engine.routes.draw do
  devise_for :users, class_name: "Shine::User"
  post "/sync" => "contentful#sync", defaults: { format: :json }

  resources :posts
end

Shine::Engine.routes.draw do
  post "/sync" => "contentful#sync", defaults: { format: :json }

  resources :posts
end

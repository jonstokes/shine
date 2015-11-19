Rails.application.routes.draw do

  mount Alloutdoor::Engine => "/blog"

  root to: "posts#index"

  resources :categories, only: [:index, :show]
  resources :authors, only: [:index, :show]
  resources :posts, only: [:index, :show]

  post '/webhook' => 'contentful#webhook', defaults: { format: 'json' }
end

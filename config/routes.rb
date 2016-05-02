Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :pages
  resources :venues
  resources :events
  resources :users

  namespace :admin do
    resources :pages
    resources :articles
  end


  match '/:id' => 'pages#show', via: [ :get, :post ]

  root 'pages#show'
  
end
